# 第 5 章「表示代码」译前分析

## 1. 内容与作者意图

- **讲什么**：给代码设计一种内存里的表示——上下文无关文法（CFG）、抽象语法树（AST）、
  用代码生成器造出 AST 类、访问者模式，最后写一个 AstPrinter 把树打印出来。
- **核心论点**：代码既要让语法解析器容易**产出**，又要让解释器容易**消费**；树是最自然
  的中间形态。而「用类表示树」会撞上**表达式问题**——行好加还是列好加。
- **作者在干什么**：这是全书第一处**元编程**（自己写脚本生成自己的类），也是第一次正面
  讲设计模式。Bob 明说这一章「大概是全书最无聊的一章」，所以拼命塞乐子调节奏。
- **承接**：接第 4 章的词法单元。正文用上一章那张「词法文法 vs 句法文法」的对照表开刀。
- **钩子**：结尾「下一章我们开始把 Lox 代码语法解析成语法树」，直接喂给第 6 章。
- **注意**：任务书说本章有 `Design Note: It's Just Parsing`。**实际没有**——该设计说明在
  `book/compiling-expressions.md`（第 17 章）。本章 md 到 Challenges 的 `</div>`（1058 行）
  就结束了。不臆造。

## 2. 术语预判

| 英文 | 译法 | 状态 |
|---|---|---|
| representation | 表示（形式） | 新增。「代码的表示」 |
| syntax tree | 语法树 | 表内（`abstract syntax tree`=抽象语法树） |
| parse tree | 语法树（区分用「语法树」，AST 叫抽象语法树） | 沿用 a-map 第 78-80 行先例 |
| context-free grammar (CFG) | **上下文无关文法（CFG）** | 表内新增 |
| formal grammar | **形式文法** | 表内新增 |
| regular language | 正则语言 | 表内 |
| alphabet | 字母表 | 新增 |
| string（文法意义） | 字符串 | 表内 |
| terminal | **终结符** | 新增 |
| nonterminal | **非终结符** | 新增 |
| production | **产生式** | 新增 |
| derivation | **推导** | 新增 |
| head / body | **头 / 体** | 新增 |
| metavocabulary: metasyntax | **元语法** | 新增 |
| Backus-Naur form (BNF) | 保留原文 | 红线 |
| EBNF | 保留原文 | 红线 |
| recursive descent | 递归下降 | 红线/a-map 已用 |
| visitor pattern | 访问者模式 | 表内 |
| polymorphic dispatch | **多态分派** | 新增 |
| indirection | **间接层** | 新增 |
| separation of concerns | **关注点分离** | 新增 |
| Interpreter pattern | **解释器模式** | 新增 |
| expression problem | **表达式问题** | 新增 |
| multimethods | **多重方法** | 新增 |
| pattern matching | **模式匹配** | 新增 |
| metaprogramming | **元编程** | 新增 |
| pretty printer | **打印器** | 新增 |
| `beignet` / `cruller` | 保留英文（类名，不译） | 新增 |
| precedence | 优先级 | 表内 |
| side / grain | 边 / 纹理 | 见 4.2 |

**保留不译**：Lox、jlox、Java、BNF、EBNF、ML、Lisp、SML、Caml、OCaml、Haskell、F#、
Scala、Rust、Swift、Common Lisp、CLOS、Dylan、Julia、GCC、Roslyn、V8、Jython、
IronPython、ALGOL 58、RPN、SMT。

**人名**（全部音译，写进术语表 `_names`）：
Thomas Hardy 托马斯·哈代 ｜ Jim Hugunin 吉姆·休宁 ｜ John Backus 约翰·巴克斯 ｜
Pāṇini 波你尼 ｜ Erich Gamma 埃里希·伽玛 ｜ Robin Milner 罗宾·米尔纳

**书名**：
*Under the Greenwood Tree*《绿树荫下》（查过，无中译本，直译）｜
*Design Patterns: Elements of Reusable Object-Oriented Software*
《设计模式：可复用面向对象软件的基础》（四人帮，zh.wikipedia 同名）

## 3. 语域判断

- 偏理论 + 偏动手，但自嘲密度高。作者反复拿「这一章最无聊」自嘲。
- 幽默/比喻密集区：
  - L14 `cover`（span boring）——「讲讲」被拆出来当笑点
  - L112 "Oof. Maybe a table will help:" ——「呼」
  - L112–143 那张「字母表 / 字符串 / 谁来实现」对照表（三行全带省略号）
  - L145–148 「eggs are tasty for breakfast」vs「tasty breakfast for are eggs」
  - L194 "whichever floats your boat" ——「哪条船能载你就上哪条」
  - L211–217 turtles 旁注「一层套一层，全是语言！」
  - L221–226 breakfast 旁注「是的，这本书从头到尾都会用早餐举例。抱歉。」
  - L302 「加点火腿和荷兰酱，你就得到班尼迪克蛋」
  - L569–576 automate 旁注「'自——动——化。'」（连写读出声）
  - L587–595 python 旁注（Jim Hugunin / 别一次性扔太多语言给你）
  - L643–645 「21 个这样的类」「不想浪费你的时间**或我的墨水**」
  - L659 「把你的想象力帽子戴上」
  - L729–750 表达式问题——「先见之明」段落，带「向后兼容 vs 逻辑自洽」的调侃
  - L791–793 「《设计模式》里最被误解的模式」
  - L851 「多态来救场！」
  - L804–805 「计算机科学解决几乎所有问题的办法：加一层间接」
  - L927 「结束这章的瞎扯之前」
- 图注 alt 也要译（7 张图）。

## 4. 翻译难点清单

### 4.1 Comprehension gaps

| 位置 | 落差 | 处理 |
|---|---|---|
| L37–43 PEMDAS 口诀 | 中文没有「请原谅我亲爱的萨利阿姨」的通行说法 | **retain 英文链接文本 + 加 PEMDAS 缩写作桥**。英文链接文本 + **具名引用** |
| L196–204 波你尼 / 八章书 | 中文学界一般不熟 | 音译「波你尼」+《八章书》（复旦文史官网用法），首现标英文原名 |
| L597–595 Jim Hugunin | 冷门，但造了 Jython/IronPython，读者可能查 | 音译「吉姆·休宁」，首次带英文 |
| L742–750 ML | ML = MetaLanguage | 译「元语言（metalanguage）」 |
| L773–775 CLOS / 多重方法 | 冷门 | 译「多重方法（multimethods）」，保留 CLOS |
| L934–938 漂亮打印 | 中文没有定译 | 译「漂亮打印（pretty printing）」，动词用「打印」 |
| L643–654 AstPrinter | 类名不译（style guide） | 正文用 AstPrinter / Visitor 英文类名 |

### 4.2 Figurative language（比喻 / 双关）

| 原文 | 机制 | 处理 | 译法 |
|---|---|---|---|
| "the old *Please Excuse My Dear Aunt Sally* stuff" | 英文首字母口诀，直译即失效 | **retain + 补桥** | 那个「[Please Excuse My Dear Aunt Sally][sally]」（PEMDAS）老口诀 |
| "Oof." | 看到一堆引号头疼 | interpret | 呼。 |
| "whichever floats your boat" | 谚语 | interpret | 哪条船载得动你就上哪条 |
| "It's languages all the way down!" | 呼应「乌龟叠罗汉」梗，turtles 旁注 | **substitute**（换掉龟，保留「套下去」的节奏） | 一层套一层，全是语言！ |
| "breakfast examples... Sorry." | 自嘲 | interpret | 是的，这本书从头到尾都会拿早餐举例。抱歉。 |
| "Throw in some ham and Hollandaise... eggs Benedict" | 夸张食谱 | interpret | 加点火腿和荷兰酱，班尼迪克蛋就成了 |
| "kicks it up even more" | 口语 | interpret | 更上一层楼 |
| "handy dandy new notation" | 俏皮 | interpret | 我们这套顺手又顺眼的新记号 |
| "a bag of data" | 贬义比喻 | interpret | 只是一袋数据 |
| "Are really owned by *neither*" | 强调 | **粗体** | 哪边都不属于 |
| "Disoriented objects" | **双关**：disoriented（迷失方向）+ object-oriented | **造词**（读得通才用） | `### 晕头转向的「对象」`；正文再补一刀「它们不知道该把 orientation 朝哪边摆」 |
| "striped of behavior" | 与 architecture 的 «architecture» 呼应 | interpret | 被剥掉了行为 |
| "the grain of a paradigm" + "rub against the grain" | 木纹比喻（orient 的木纹） | **retain 意象** | 范式有它自己的「纹理」／跟 Java 的纹理相抵触 |
| "AU-TO-MATE." | 读出声的造词笑点 | **造词** | 「自——动——化。」 |
| "Robustness ain't a priority." | 自嘲 | interpret | 健壮性不在优先考虑之列 |
| "blasts out a new file" | 强调（span longer） | interpret | 一口气**轰**出一个新文件 |
| "this shotguns... / It rocks" | 口语 | interpret | 「它 rocks」→「它贼好用。」 |
| "Polymorphism to the rescue!" | 漫画梗 | interpret | 多态来救场！ |
| "smush a bunch of different domains together" | 捏 | interpret | 把一堆不同的领域糅成一团 |
| "throw on your imagination hat" | 夸张 | interpret | 把想象力帽子戴上 |
| "beignet" 旁注（读音 "ben-yay"） | 读音梗 | **retain** | 音标式注音改写成「念作『贝涅』，两个音节一样重」 |
| "not as *human* friendly" | 与 "Parse" 双关，不译即可 | interpret | 不那么**像给人读**的 |
| "this book omits the trophy case" | 自嘲 | interpret | 这本书省掉了奖杯陈列柜 |
| "the parser can't read your mind" | 玩笑 | interpret | 语法解析器读不了你的心 |
| "…like barnacles" | 习语（形容堆积） | interpret | 像藤壶一样越积越多 |
| "roundoff and overflow" | 术语 | 舍入误差 / 溢出 | 术语表已有 overflow |

### 4.3 Structural challenges

| 位置 | 难点 | 处理 |
|---|---|---|
| L112–143 HTML 表格 | 单元格含 `&ldquo;`、`class="ellipse"` | 表格骨架**原样**，只译文字；实体保留 |
| `^code generate-ast` 等 18 处 | 代码块来自 `book-zh/java`，注释已汉化 | **一个字都不碰**，不译代码注释 |
| `expr` / `robust` / `overload` 三个旁注**没有 span** | 容易误以为漏了 | 原样保留，不补 span |
| `## A (Not Very) Pretty Printer` 等标题 | 标题即锚点，翻译会改锚点 | 见报告：译标题 → 跨章 `#a-not-very-pretty-printer` 等 3 个锚点失效 |
| L234–236 `&ldquo;.java" file` | 原文引号不配对 | 统一成 `".java"` |
| L503 `// [expr]` | 这是 aside 定位标记，不是注释 | 原样保留 |
| L668–672 手写 java 块 `// ...` | 占位省略号，不是注释 | 原样保留 |
| 全章 | 英文 we/it 对立 | 硬规则：不以「它」指代代码 |
| 全章 | 中文无斜体 | 原文 `*em*` 一律译粗体 |
| L940–942 `1 + 2 * 3` | 是**示例输出字符串**，不是代码 | 保留原样 |

### 4.4 处理策略

- 双关走 **interpret / substitute / 造词**，只有 beignet 读音和 PEMDAS 走 **retain**
- 早餐例子（breakfast/protein/bacon/crispy/crullers/toast/biscuits）**一律不译**：
  它们在 ```ebnf 代码块里，且 Lox 本身没有这些词；旁注另作解释
- 表格、代码块、链接定义、`^code` 行**零改动**
