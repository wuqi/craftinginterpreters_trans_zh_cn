# 第 6 章「语法解析表达式」译前分析

## 0. 红线复述

- `parse` / `parser` **一律**「语法解析」「语法解析器」，**绝不**用「解析」。
  （术语表 4.2 节：`resolve` 才译「作用域解析」。）
- `resolve`（`name resolution`）→ 作用域解析。本章只出现一次（`[resolution]: resolving-and-binding.html`），
  链接文字译「后面你会看到」。
- 英文靠 we/it 区分「人做的」和「代码做的」，中文没有这组对立。
  **硬规则：不得以「它」指代代码。** 代码是施动者就把代码名提为主语，或省略主语。
- 原文 `*em*` / `**strong**` 一律译 `**粗体**`，全书零斜体。
- 中文链接文本**一律具名引用** `[文本][key]`，绝不用空引用 `[]`。
- `<span name="x">` 与 `<aside name="x">` 的 name 值逐个比对，不许丢。
- 手写 ``` 代码块的**注释要译**，**程序输出不译**（本章设计说明里的 `// Wrong.` / `// Right.` 是注释）。

## 1. 内容与作者意图

- **讲什么**：把词法单元序列变成语法树。依次解决歧义（优先级 / 结合性）、
  把文法分层、用**递归下降**写成语法解析器，再写完整的错误处理与**错误恢复**。
- **核心论点**：
  1. 歧义是文法与生成分离带来的，必须靠优先级/结合性表来消除；
  2. 递归下降 = 把文法逐条直译成函数，表格一一对应；
  3. 语法解析器的两份工作同样重要：产出树 + 不崩、不挂、报尽量多的错；
  4. 错误恢复的本质是**重新同步**，用异常来退栈。
- **作者在干什么**：这一章是全书的**第一个大里程碑**（Bob 明说），所以序言用莫里哀
  的台词开题，中途反复插科打诨调节奏，末尾用「你跨过了门槛」收束。
- **承接**：接第 5 章的文法表。开头直接说「上一章已经把难活儿前置了」。
- **钩子**：结尾「下一章开始把 Lox 代码语法解析成语法树」——本章已经接上第 5 章的钩子，
  反过来埋第 7 章的钩子（AstPrinter 已经就位，缺的是求值）。

## 2. 术语预判

| 英文 | 译法 | 状态 |
|---|---|---|
| parse / parsing | **语法解析** | 红线 |
| parser | **语法解析器** | 红线 |
| resolve | 作用域解析 | 红线 |
| precedence | 优先级 | 表内 |
| associativity | **结合性** | 新增 |
| left-associative / right-associative / non-associative | **左结合 / 右结合 / 非结合** | 新增 |
| bind tighter | 结合得更紧 | 新增 |
| ambiguity / ambiguous | **歧义** | 新增 |
| grammar / rule / production | 文法 / 规则 / 产生式 | 表内 + 第5章新增 |
| terminal / nonterminal | 终结符 / 非终结符 | 第5章新增 |
| recursive descent | **递归下降** | a-map 先例 |
| top-down parser | **自顶向下语法解析器** | 新增 |
| bottom-up parser | 自底向上语法解析器 | 新增 |
| predictive parser | **预测性语法解析器** | 新增 |
| left recursion | **左递归** | 新增 |
| left-recursive | 左递归（带连字符） | 新增 |
| panic mode | **panic 模式**（保留英文术语） | 新增 |
| error recovery | **错误恢复** | 新增 |
| error productions | **错误产生式** | 新增 |
| synchronization (panic) | **同步** | 新增 |
| cascade / cascaded errors | **连锁错误** | 新增 |
| sentinel class | 哨兵类 | 表内 `sentinel` |
| parser generator | 语法解析器生成器 | 新增 |
| parser combinators | **解析器组合子** | 新增 |
| Earley parsers | Earley 语法解析器 | 新增（Earley 保留） |
| shunting yard algorithm | **调度场算法** | 新增 |
| packrat parsing | **记忆化解析（packrat parsing）** | 新增 |
| PEG | 解析表达式文法 | 新增（链接指向它） |
| reverse Polish notation (RPN) | **逆波兰式（RPN）** | 新增 |
| comma operator | **逗号运算符** | 新增 |
| ternary operator | **三目运算符** | 新增 |
| primitive expression / primary | 初始表达式 / 基本表达式 | 新增 |
| bitwise | 按位 | 新增 |
| multimethod | 多重方法 | 第5章新增 |
| recursive descent 的"下降" | 下降 | — |

**保留不译**：LL(k)、LR(1)、LALR、BNF、EBNF、GCC、V8、Roslyn、Yacc、Bison、ANTLR、
Fortran、ALGOL、IEEE 754、C、Java、C#、Perl、Lox、jlox、Metalanguage/SML/Caml/OCaml/Haskell/F#。

**优先级表的规则名**（`equality` / `comparison` / `term` / `factor` / `unary` / `primary`）
是 C 的标准叫法，代码里就叫这些名字 → 表格里**保留英文规则名并加中文注**，
读者要能对上文法里的规则名。

**人名**：Thomas Molière 莫里哀（仅书眉引用）。

## 3. 语域判断

- 偏动手，但**开场最长的一段自嘲**（L37–64）——编译器教科书吹捧史，Bob 拆台。
- 幽默/比喻密集区：
  - L4–11 序言：「难看的正则表达式大杂烩」「维护噩���」「在这一行里显露身手」
  - L43–48 human/machine 旁注：「想想那些老机器上写汇编有多可怕，他们才会觉得 *Fortran*
    是个进步」
  - L55–59 龙书封面梗（骑士盾牌上写着 "LALR parser generator"）
  - L61–64 「奖杯陈列柜」
  - L112–117 引号地狱 + "Oof"-式吐槽
  - L146–148 「早餐真好吃」vs 词序乱掉的版本
  - L387–393 「It rocks.」
  - L412–415 方向隐喻吐槽（栈往哪长、树的根为什么在上头）
  - L500–507 「zip through a sequence」
  - L588–602 「keep on truckin'」（滚动贝斯梗）
  - L639–647 读心术梗
  - L663–667「all manner of horrors may be summoned」
  - L669–671「table stakes / raise the ante」（扑克梗）
  - L707–713 PANIC 按钮图 + "You know you want to push it."
  - L800–805 「accumulate error productions like barnacles」
  - L894–897 「跨过了门槛」
- 图注 alt 也要译（5 张图）。

## 4. 翻译难点清单

### 4.1 Comprehension gaps

| 位置 | 落差 | 处理 |
|---|---|---|
| L15–19 "Parse" 词源旁注 | 古法语 `pars` = part of speech | 保留英文原词 + 解释（原文本身就在解释） |
| L55–59 龙书封面 | 中文读者没见过 | 沿用第 4 章先例：「《编译原理：原理、技术与工具》」（人称「龙书」） |
| L373–385 解析技术名词墙 | LL(k)/LR(1)/LALR/Earley/调度场/packrat | LL/LR/LALR 保留；调度场算法译；packrat 译「记忆化解析」并标英文 |
| L391–393 Roslyn | 「用 C# 写的 C# 编译器」这个梗 | 保留 C#，句子照样直译 |
| L600 **predictive parsers** | 冷门术语 | 译「预测性语法解析器」并加粗 |
| L616–619 `primary()` | 「基本表达式」是 C 标准叫法 | 定译 **基本表达式（primary）**，首现标英文 |
| L697 「error productions」 | 冷门 | 译「错误产生式」，原文已解释，够用 |
| L706–724 panic mode | 直译「恐慌模式」不好懂 | **保留英文 panic 模式**并加粗 |
| L790–811 「表达式问题」 | 第 5 章已铺垫 | 沿用第 5 章译法 |
| L944–1005 设计说明 | 逻辑 vs 历史 | 标题译 `## 设计说明：逻辑 vs 历史`（与 `titles.zh.json` 一致） |

### 4.2 Figurative language（比喻 / 双关）

| 原文 | 机制 | 处理 | 译法 |
|---|---|---|---|
| "a mishmash of regular expressions" | 大杂烩 | interpret | 一堆正则表达式和字符串截取拼起来的**大杂烩** |
| "a beast to maintain" | 维护噩梦 | interpret | 一头维护噩梦般的野兽 |
| "attain it" | 里程碑式 | interpret | 你会在本章**拿到**它 |
| "fawning hagiographies" | 谚语 + 吹捧文 | interpret | 歌功颂德的圣徒传 |
| "They laid it on thick." | 习语 | interpret | 他们可真是**使劲吹** |
| "bang out a parser" | 口语 = 敲出来 | interpret | 敲出一个高质量语法解析器 |
| "this book omits the trophy case" | 自嘲 | interpret | 这本书省掉了奖杯陈列柜 |
| "Oof" 类吐槽 | — | interpret | 呼。 |
| "It rocks." | 口语赞叹 | interpret | 它贼好用。 |
| "zip through a sequence" | 夸张 | interpret | 一路飞奔过整串相等表达式 |
| "keep on truckin'" | 乐句梗 | interpret | 一路**开**下去 |
| "table stakes" / "raise the ante" | 扑克 | interpret | 这只是**入场费**；但你真正想把门槛**抬高** |
| "You know you want to push it." | PANIC 按钮旁注 | interpret | 你知道你想按它。 |
| "like barnacles" | 习语 | interpret | 像藤壶一样越积越多 |
| "the parser can't read your mind" | 玩笑 | interpret | 语法解析器读不了你的**心** |
| "all manner of horrors may be summoned" | 夸张 | interpret | 各种恐怖都会被招来 |
| "Shoot that down." / "any which way you want" | 口语 | interpret | 爱怎么嵌套就怎么嵌套 |
| "We've crawled up the precedence hierarchy" | 爬楼梯 | interpret | 我们正沿着优先级这座梯子往上爬 |
| "suck" (Design Note: "kind of sucks") | 口语 | interpret | 挺**烂**的 |
| "burn the history books and start our own story" | 夸张 | interpret | 把历史书一把烧了，自己另起炉灶 |
| "give your users a leg up" | 习语 | interpret | 让用户**站在别人的肩膀上**起步 |
| "You can't *always* stick to history" | — | interpret | 你又不能**永远**抱着历史不放 |

### 4.3 Structural challenges

| 位置 | 难点 | 处理 |
|---|---|---|
| L84–96 / L468–475 / … 重复出现的文法块 | 同一段文法在本章出现 6 次 | **一字不改**，全部原样复制 |
| L179–215 优先级表 HTML | 规则名是 C 标准英文 | 保留英文规则名 + 中文注；表头译 |
| L422–436 文法记号 ↔ 代码 对照表 | 含 `&rsquo;` 实体 | 骨架原样，只译文字 |
| L594 `<span name="descent">down</span>` 跨行 | 原文 `<span` 与 `name=` 分行 | 合并成一行（工具不依赖换行） |
| L707–713 panic 旁注里嵌 `<img>` | 图在旁注**内部** | 必须留在旁注内 |
| L410 `<img ...>` 在 aside `descent` 内 | 同上 | 留在旁注内 |
| L866 `^code primary-error (5 before, 1 after)` | 参数必须一字不差 | 原样 |
| L953–956 设计说明里的 C 块 | `// Wrong.` / `// Right.` 是**注释** | 译成 `// 错了。` / `// 对了。` |
| L946 设计说明标题 | 工具认 `设计说明：` 前缀 | 改成 `## 设计说明：逻辑 vs 历史` |
| L888 `[ast-printer]: representing-code.html#a-not-very-pretty-printer` | URL 不得改 | URL 原样；第 5 章译标题后此锚点失效 → **进报告** |
| 全章 | we/it 对立 | 不以「它」指代代码 |
| 全章 | 中文无斜体 | 原文 `*em*` 一律译粗体 |
| L917 `## Challenges` | 工具认「习题」 | 改成 `## 习题`（与第 4 章一致） |

### 4.4 处理策略

- 大量重复文法块 **零改动**，靠复制保证一字不差
- 「优先级 / 结合性」为红线，表格与正文必须一致
- 「语法解析器读不了你的心」这类调侃保留口语
- 设计说明语气比其他章更松（讲课式），允许稍长的句子
