# 第 3 章「Lox 语言」译前分析

## 1. 内容与作者意图

- **讲什么**：Lox 这门语言的手册。数据类型 → 表达式 → 语句 → 变量 → 控制流 → 函数 → 闭包
  → 类 → 标准库。纯叙事章，**零 `^code`**，全靠小段 Lox 示例。
- **核心论点**：Lox 是「小型但够用」的 C 家族语言；动态类型、自动内存管理是取舍的结果，
  不是偷懒；类是给用户省麻烦的封装。
- **作者在干什么**：**给读者一个可以直接上手试的心智模型**。每个小节都是
  「这是什么 → 几行例子 → 一句吐槽」。旁注承担大部分玩笑。
- **承接**：接导言的两个解释器预告。**钩子**：结尾说「后面章节开始动手」，
  并留 `breakfast` 变量梗给第 7 章。
- **语域**：**吐槽密度仅次于导言**。几乎每个语法要点都带一句冷笑话。

## 2. 术语预判

| 英文 | 译法 | 状态 |
|---|---|---|
| high-level language | 高级语言 | 新增 |
| scripting language | 脚本语言 | 新增 |
| dynamic typing | 动态类型 | 表内 |
| static typing | 静态类型 | 表内 |
| automatic memory management | 自动内存管理 | 新增 |
| reference counting | 引用计数 | 新增 |
| tracing garbage collection | 追踪式垃圾回收 | 新增 |
| garbage collection / GC | 垃圾回收 | 表内 |
| write barrier | 写屏障 | 新增 |
| retain call | retain 调用（保留） | — |
| literal | 字面量 | 表内 |
| operand | 操作数 | 表内 |
| binary operator | 二元运算符 | 表内 |
| infix / prefix / postfix | 中缀 / 前缀 / 后缀 | 新增 |
| mixfix operator | **混缀运算符（mixfix）** | 新增 |
| fixity | 定缀 | 新增 |
| logical operator | 逻辑运算符 | 新增 |
| short-circuit | 短路 | 表内 |
| block | 块 | 新增 |
| block scope / lexical scope | 块作用域 / 词法作用域 | 新增（词法作用域） |
| declaration vs definition | 声明 vs 定义 | 新增 |
| actual parameter / formal parameter | 实参 / 形参 | 新增 |
| first class | 一等公民 | 新增 |
| closure | 闭包 | 表内 |
| class / instance / method / field | 类 / 实例 / 方法 / 字段 | 表内 |
| prototype | 原型 | 新增 |
| prototypal | 原型式的 | 新增 |
| dispatch | 派发 | 新增 |
| static dispatch / dynamic dispatch | 静态派发 / 动态派发 | 新增 |
| derived class / base class | 派生类 / 基类 | 新增 |
| subclass / superclass | 子类 / 超类 | 表内 |
| initializer | 初始化器 | 表内 |
| metaprogramming | 元编程 | 新增 |
| standard library | 标准库 | 新增 |
| implicit return | 隐式返回 | 新增 |
| precedence table | 优先级表 | 新增 |
| waterbed theory | **水床理论（waterbed theory）** | 新增 |
| object-oriented programming (OOP) | 面向对象编程（OOP） | 新增 |
| grapheme cluster | 字素簇 | 新增 |

**保留不译**：Lox、Java、C、JavaScript、Scheme、Lua、Smalltalk、Racket、Ruby、Lisp、
Haskell、CoffeeScript、Pascal、C#、C++、Bacon（作者）、jlox、clox、nihilism→虚无主义

**人名**：Anthony Bourdain 安东尼·伯丁、Dennis Ritchie 丹尼斯·里奇、
Brendan Eich 布伦丹·艾奇、Peter J. Landin 彼得·兰丁、Larry Wall 拉里·沃尔、
George Boole 乔治·布尔、Bugs Bunny 兔八哥、MacGyver《百战天龙》

## 3. 语域判断

- 偏叙述，但**每一节都夹着玩笑**。幽默集中在：

| 位置 | 原文梗 |
|---|---|
| L1 | Bourdain 早餐引文 |
| L18-21 | 「你还没有 Lox 解释器，因为你还没造一个！」+「别怕，用我的」 |
| L29-36 | **lox 也是熏三文鱼**（核心双关） |
| L47-50 | 「北欧家具式极简」→ Scheme |
| L54-62 | 「declaration reflects use」+ Lox 没静态类型所以躲开了 |
| L89-100 | Brendan Eich **十天**写完第一个 JS 解释器；MacGyver 一集剧集的原料和时间 |
| L101 | 「所以 Lox 应该干净一点」 |
| L112-124 | 「静态类型」+ 旁注「我们用来实现 Lox 的两门语言都是静态类型的」 |
| L128-132 | 「谁一大早起来迎接朝阳喊『我等不及要弄清楚今天分配的每个字节该在哪儿 free()』」 |
| L155-160 | 「调试 GC 会让你梦里都在看十六进制转储」 |
| L167-171 | 布尔值是软件阴阳；「我们又不是**野蛮人**」 |
| L173-180 | 布尔以 George Boole 命名；他 1864 年去世 |
| L186-187 | `false; // Not *not* false.` |
| L224-234 | nil「从没被邀请，却总是不请自来」；空指针错误是这行的祸根 |
| L289 | 「Ye Olde Comparison Operators」 |
| L317 | 「我一般来说反对隐式转换」 |
| L339-346 | `and` / `or` 用词不用符号；旁注解释理由 |
| L366-378 | 「运算符动物园」；「你在我这儿能加印象分」 |
| L385-388 | 表达式产**值**，语句产**效果** |
| L400-405 | 把 `print` 烤进语言是 hack |
| L435-439 | 「forcing every variable to be initialized」 |
| L457-462 | 「早餐前写这本书」的 bagels / beignets |
| L477-484 | 旁注：Scheme 无循环、Smalltalk 无分支 |
| L510-513 | 「It’s your party.」 |
| L524-528 | C 风格 `for` 粗糙；Lox 保持简单 |
| L560-564 | `fn` / `fun` / `func` / `function`，期待 `functio` |
| L573-576 | 「把最细的绒毛一根根劈开来辨语义」 |
| L611-614 | 「我早说了 `nil` 会趁你不备偷偷溜进来」 |
| L667-667 | 「kosher?」 |
| L672-689 | Landin 造词；「damn near half the terms」；`closes over` 双关 |
| L703-705 | 类「没活吹」 |
| L708-711 | 「卖断了，只在体育馆开演唱会」；8-track |
| L712-717 | 「all inheritance all the time」的暴食 |
| L722-728 | `hash-copy` / `vector-copy` |
| L790-796 | 「人们用原型的力量……来重新发明类」 |
| L800-804 | waterbed theory |
| L846-847 | 方法「一样好玩」 |
| L858-861 | 类本身就是实例的工厂函数 |
| L892 / L909 | `// ...` |
| L980-989 | Lox 不是**纯粹**的面向对象语言 |

## 4. 翻译难点清单

### 4.1 Comprehension gaps

| 位置 | 落差 | 处理 |
|---|---|---|
| L50-52 Curry-Howard（在导言） | — | 已在导言译，本章不重复 |
| L54-58 declaration reflects use | C 的设计原则，中文无定译 | **substitute**「声明反映使用」（declaration reflects use），首现标英文 |
| L146-149 A Unified Theory of GC | 论文 | 保留论文英文名 + 链接 |
| L218-222 character 的多重含义 | 概念本身 | 旁注原文就在拆解，直接译 |
| L578-584 argument vs parameter | 中文本来就分 实参/形参 | **substitute** 实参 / 形参，首现标英文 |
| L808-812 waterbed theory | 圈内术语 | **substitute**「水床理论（waterbed theory）」，中文软件工程文献通用 |
| L95-97 MacGyver | 影视 IP | **substitute**《百战天龙》，保留英文原名 |

### 4.2 Figurative language

| 原文 | 机制 | 处理 | 译法 |
|---|---|---|---|
| "What nicer thing can you do for somebody than make them breakfast?" | Bourdain 引文 | interpret（**查过，无中译**） | 对一个人来说，还有什么事比给他做一顿早餐更美好呢？ |
| **lox（语言 / 熏三文鱼）** | 一词二义 | **retain 双关** | 这是你尝的第一口 Lox——我说的是这门语言。至于 Lox 这种冷熏三文鱼…… |
| "language lawyering and specification-ese" | 夸张 | interpret | 成堆成堆的法律文书和规范黑话 |
| "Scandinavian-furniture-minimalism" | IKEA 梗 | interpret | 北欧家具式的极简 |
| "the atoms / molecules" | 化学比喻 | retain | 内置数据类型是原子，表达式是分子 |
| "yin and yang of software" | 比喻 | interpret | 软件的阴阳 |
| "we aren't *savages*" | 自嘲 | retain 粗体 | 我们又不是**野蛮人** |
| "Ye Olde Comparison Operators" | 古英语拼写梗 | interpret（**损失**：假古体拼法丢失） | 那套古老的比较运算符 |
| "It has nothing to do with the ones-and-zeroes use of 'binary'" | 澄清 | interpret | 跟「二进制」在「一和零」意义上的用法毫无关系 |
| "operator menagerie" | 动物园 | interpret | 运算符动物园 |
| "bonus points in my heart" | 幽默 | interpret | 你要是给自己的实现加上它们，能在我这儿加印象分 |
| "produced to an *effect*" | 值 / 效果对立 | retain 粗体 | 表达式的活儿是产出**值**，语句的活儿是产生**效果** |
| "statement-hood" | 造词 | interpret | 语句身份 |
| "Baking `print` into the language" | 烘焙双关 | interpret | 把 `print` 烤进语言里 |
| "splitting the finest of downy hairs" | 夸张 | interpret | 把最细的绒毛一根根劈开 |
| "kosher" | 犹太洁食 | interpret | 这合规吗？ |
| "damn near half the terms" | 夸张 | retain | **几乎**一半的术语 |
| "*closes over*" | 术语双关 | retain | 因为它把需要的变量**关**在里面…… |
| "sold out / arena shows" | 音乐圈 | interpret | 都卖断了，只在体育馆开演唱会 |
| "releasing music on 8-track" | 年代梗 | interpret | 跟用八轨磁带发唱片一样 |
| "all inheritance all the time binge" | 暴食 | interpret | 「 Inheritance 全都要」式的暴食 |
| "push down / swells up" | 水床 | retain | 按下去一个地方，别处就鼓起来 |
| "It's your party." | 呼应 L224 的 party | interpret | 随你高兴，这是你的派对 |
| "hex dumps in your dreams" | 夸张 | interpret | 梦里都在看十六进制转储 |
| "nihilism" | 夸张 | interpret | 已经不只是极简主义，简直近乎**虚无主义** |
| "for prosaic reasons" | 轻描淡写 | interpret | 理由很俗 |

### 4.3 Structural challenges

| 位置 | 难点 | 处理 |
|---|---|---|
| L38-41, 185-221, 246-251, 291-315, 324-327, 334-345, 372, 392-394, 409-423, 442-444, 451-455, 490-522, 544-571, 602-605, 623-663, 826-836, 851-855, 864-865, 875-877, 886-894, 903-915, 925-929, 952-953, 972-977 | 大量 ```lox 块 | **代码与 Lox 语法不译**；`//` 后的**注释译**，**程序输出不译**（`// "beignets".`、`// "Breakfast instance".` 等） |
| L226-235 nil 与 L673 nil | 两处 nil 指同物 | 术语表已有 `nil`，统一 |
| L376 `<span\nname="gc">` | 跨行标签 | 合并成一行 |
| L1038 `## Design Note: Expressions and Statements` | 工具按前缀识别 | 改 `## 设计说明：表达式与语句`（titles.zh.json 已配） |
| L85 `[part iii]: a-bytecode-virtual-machine.html` | 链接定义 URL 不可译 | 原样保留 |
| L744-750 classes / prototypes 链接定义 | 同上 | 原样保留；正文引用文本含中文时用**具名引用** `[类][classes]` |
| 全章 | 英文靠 we/it 区分人和代码 | 不写「它」指代码 |

### 4.4 处理策略

- 代码块策略（**本章特例**）：
  - `//` 注释 → **译**（`// 一个整数。` `// 打印出 "3"。`）
  - 程序输出 / 输出描述 → **不译**（`// "beignets".` `// "Breakfast instance".`）
  - 字符串字面量（`"Hello, world!"` `"One statement."`）→ **不译**，它们是程序内容
  - `// ...` 占位省略号 → 不动
- 双关走 interpret / substitute / retain，不造新词。**loxe/三文鱼、closes over 两条必须留住。**
- 这一章是「语言手册」，句子要短、例子要跟手，**不要写成语言规范条文**。