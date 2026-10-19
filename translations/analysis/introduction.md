# 第 1 章「导言」译前分析

## 1. 内容与作者意图

- **讲什么**：全书序言。交代「这是本讲怎么实现解释器的书」「这是本讲怎么设计语言的书」，
  回答「为什么要学这玩意儿」，介绍本书的编排方式（三部分、代码片段、旁注、习题、设计说明），
  最后预告两个解释器（jlox 用 Java，clox 用 C）。
- **核心论点**：动手做解释器是最好的学语言方式。理论重要，但 Bob 自陈「我就是动手学得最快」。
- **作者在干什么**：**建立亲密感**。这一章几乎没有代码，全是作者在跟读者唠嗑。
  同时提前把「本书长什么样」的约定说清楚（旁注可跳、习题要动手、代码片段怎么用）。
- **承接**：接《欢迎》。**钩子**：明确宣布「接下来两大部分各造一个完整解释器」，
  为第 3 章（Lox 语言）和第 4 章（扫描）铺路。
- **语域**：全书最松的一章。调侃、自嘲、挖苦（编译器书都在这一节自我论证）密度最高。

## 2. 术语预判

| 英文 | 译法 | 状态 |
|---|---|---|
| interpreter | 解释器 | 表内 |
| implementation / implement | 实现 | 表内 |
| language | 语言 | — |
| lingo / jargon | 行话 / 术语 | 新增 |
| formal reasoning | 形式化推理 | 新增 |
| type system | 类型系统 | 新增 |
| static type system | 静态类型系统 | 表内（dynamic/static typing） |
| Curry-Howard isomorphism | **柯里-霍华德同构** | 新增 |
| little language | **小语言** | 新增 |
| domain-specific language | **领域特定语言**（DSL） | 新增 |
| pidgin | **皮钦语** | 新增 |
| template engine | 模板引擎 | 新增 |
| markup format | 标记格式 | 新增 |
| compiler-compiler | **编译器-编译器** | 新增 |
| dynamic array | 动态数组 | 新增 |
| recursion | 递归 | 新增 |
| graph | 图 | 表内（tree） |
| hash table | 哈希表 | 表内 |
| bytecode | 字节码 | 表内 |
| garbage collector | 垃圾回收器 | 表内 |
| dynamic array / hash table（自己实现） | 动态数组 / 哈希表 | 表内 |
| reference counting | 引用计数 | 新增 |
| tracing GC | 追踪式垃圾回收 | 新增 |
| self-hosting | **自宿主** | 新增 |
| bootstrapping | **自举** | 新增 |
| punched card | 打孔卡 | 新增 |
| benchmark | 基准测试 | 新增 |
| makefile | Makefile | 保留英文 |
| diamond operator | 菱形运算符 | 新增 |
| FORTRAN 77 / COBOL | 保留英文 | — |

**保留不译**：Lox、clox、jlox、Java、C、JavaScript、PHP、Perl、Python、Lua、Ruby、
CPython、MRI、Go、GCC、LLVM、Lex、Yacc、Bison、IDE、Makefile、REPL、OOP

**人名**：G. K. Chesterton 切斯特顿、Neil Gaiman 尼尔·盖曼、Haskell Curry 哈斯凯尔·柯里、
William Alvin Howard 威廉·阿尔文·霍华德、Dennis Ritchie 丹尼斯·里奇、
Bugs Bunny 兔八哥

## 3. 语域判断

- 偏叙述，**纯唠嗑章**。幽默几乎每段都有，重点保护区：

| 位置 | 原文梗 |
|---|---|
| L6-10 | "I'm really excited we're going on this journey together" |
| L14 | 致朋友和家人「抱歉我一直心不在焉」 |
| L27-34 | PL 研究者的鸡尾酒会 + 旁注「其中有些人能喝多少」 |
| L42-43 | "if I've coded something, run it, and debugged it, then I *get* it" |
| L50-52 | Curry-Howard 同构（旁注，严肃内容） |
| L65-68 | 编译器书都有「为什么要学这一节」，鸟类学不会这么问 |
| L72-75 | 「就算不把折叠车顶撑开，也装得下」大众面包车 |
| L79-83 | little languages → DSL，「术语经济的通胀」 |
| L94-96 | "rolling your own" / "a tall order" |
| L105-108 | 长跑运动员绑沙袋、高原训练 |
| L128-131 | 同学讲编译器课时脸上的敬畏 → 巫师 |
| L133-138 | "*I* didn't feel like a wizard" |
| L142-148 | 旁注：两本书封面一条龙、一个巫师 |
| L161 | "Someone has to." |
| L186-188 | "We're about *crafting* interpreters" |
| L193-194 | "strong opinions -- some might say religious convictions" |
| L200-212 | Yacc / Bison / yak 双关 + 「语言书呆子的幽默感是后天培养的」 |
| L226-229 | cavalier / 省略 `private` / 页面比 IDE 窄 |
| L239 | XO 白兰地 vs 后院私酿 |
| L248 | "all the bells and whistles" |
| L277-284 | 旁注可以跳，「不过我可能有点难过」+ 旁注自嘲 |
| L295-297 | 习题；"tour bus" |
| L324-336 | FORTRAN 77 + 打孔卡旁注 |
| L342-343 | "a large pinch of salt" + "food for thought" |
| L418-419 | 「丹尼斯·里奇的转世」 |
| L433-436 | clox 读音玩笑 |
| L447-448 | 「一份价钱两份货！」 |

## 4. 翻译难点清单

### 4.1 Comprehension gaps

| 位置 | 落差 | 处理 |
|---|---|---|
| L50-54 Curry-Howard | 数学术语，中文读者多半没听过 | **substitute**「柯里-霍华德同构」，附维基链接 |
| L196-212 Yacc/Bison | 名字缩写来历 | 保留 Yacc/Bison，正文拆解 **Yet Another** Compiler-Compiler |
| L381-396 self-hosting / bootstrapping | 两个术语容易混 | 旁注内给出中文「自宿主」「自举」，并解释拔自己 bootstraps 的意象 |
| L286-289 AI 搜索引擎 | 2024 年的梗 | 直译，不解释 |
| L212 makefile | — | 保留 Makefile |

### 4.2 Figurative language

| 原文 | 机制 | 处理 | 译法 |
|---|---|---|---|
| "cocktail party full of PL researchers" | 社交焦虑 | interpret | 一屋子 PL（编程语言）研究者的鸡尾酒会 |
| "I learn best by doing" | 口号 | interpret | 我就是**动手**学得最快 |
| "Volkswagen bus... pop-top camper" | 大众房车 | interpret | 大众面包车——就算不把折叠车顶撑开 |
| "inflation in the jargon economy" | 通胀双关 | retain 机制 | 术语经济的**通胀** |
| "rolling your own" | 造轮子 | **substitute** | 自己造轮子 |
| "a tall order" | 习语 | interpret | 要求可就太高了 |
| "weights strapped to their ankles / high altitude" | 长跑训练比喻 | interpret | 绑沙袋、高原训练 |
| "wizards granted privileged access to arcane arts" | 夸张 | interpret | 被特许研习秘术的巫师 |
| "That 'magical' quality... excluded *me*" | 呼应 | retain 粗体 | 那种「 magical」的特质……把**我**挡在门外 |
| "a dragon and a wizard on their covers" | 龙书 + SICP | substitute | 封面上一条**龙**、一个**巫师** |
| "Someone has to." | 短促 | retain | 总得有人来当吧。 |
| "We're about *crafting* interpreters" | about 是名词 + 书名双关 | retain 粗体 | 我们马上要**手雕**解释器了 |
| "religious convictions" | 夸张 | retain | 有些人甚至说是**宗教信仰** |
| "yak"（Yacc 读音） | 双关 | retain | 拿 Yacc 的读音「yak」（牦牛）玩的双关 |
| "acquired taste" | 习语 | interpret | 后天培养出来的 |
| "cavalier" | 词源是骑士 | interpret | 有点吊儿郎当 |
| "XO brandy, not backyard hooch" | 对比 | interpret | XO 白兰地，而不是后院私酿 |
| "all the bells and whistles" | 习语 | interpret | 全套零件 |
| "Vanquish the challenges / tour bus" | 游览车 | interpret | 打赢习题……别想窝在游览车那圈舒适区里 |
| "a large pinch of salt" / "food for thought" | 食物双关 | retain | 加一大撮盐……这样吃起来才是更有味道的思想食粮 |
| "reincarnation of Dennis Ritchie" | 夸张 | interpret | 丹尼斯·里奇的转世 |
| "sea-locks / clocks / cloch" | 读音玩笑 | interpret | 念成「西-洛克斯」……你也可以念「clocks」，甚至「克洛夫」 |
| "Two for the price of one!" | 超市口号 | interpret | 一份价钱两份货！ |

### 4.3 Structural challenges

| 位置 | 难点 | 处理 |
|---|---|---|
| L250-264 手写 codehilite 示例 | 这是**工具生成的 HTML 样本**，不是散文 | **整块一字不动**（含 `in scanToken()` / `replace 1 line`），见报告「拿不准」第 1 条 |
| L9-10 `<span\nname="head">` | 标签与 name 跨行 | 合并成一行，name 值不变 |
| L479 `## Design Note: What's in a Name?` | 工具按前缀识别设计说明 | 改 `## 设计说明：名字里能有什么？`（titles.zh.json 已配） |
| L461-473 习题里的链接定义 | `[repo]` / `[doubly linked list]` 在 `<div class="challenges">` 块内 | 链接定义留在原位，**文本含中文时用具名引用** |
| 全章 | 英文靠 we/it 区分人和代码 | 本章几乎不涉及代码行为，但仍不写「它」指代码 |
| 全章 | 中文无斜体 | `*em*` / `**strong**` 一律译粗体 |

### 4.4 处理策略

- 引文：**Chesterton/Gaiman 无公认中译**（已查），给平实直译；出处译「G. K. 切斯特顿，转引自尼尔·盖曼《鬼妈妈》」。
- 双关全部走 interpret / substitute / retain，**不造新词**。
- 这一章读者刚进书，句子偏短、语气偏软，不要写成「本书介绍了……」的说明书腔。