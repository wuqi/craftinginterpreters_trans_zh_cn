# 第22章《局部变量》译前分析

## 3.1 内容与作者

- **讲什么**：把变量从全局扩到局部。栈上表示（编译器用**栈槽位偏移**当操作数，运行时零查找）；
  Compiler 里的 `locals` 数组 + `scopeDepth`；块语句与 `beginScope`/`endScope`；
  声明/定义两阶段（`-1` 哨兵深度表示「未初始化」，挡住 `var a = a;`）；
  `OP_GET_LOCAL`/`OP_SET_LOCAL`；编译器里抹掉变量名带来的调试难题。
- **作者意图**：承接第21章「局部可以用更高效的策略」，兑现那句伏笔。章首明说 C 里
  一切都要多费功夫，所以这一章工作量其实不小。
- **钩子**：结尾把「把工作前移到编译器」抬成 clox 相对 jlox 的**持续趋势**，用静态类型作
  极端例证；设计观察指向后续函数/闭包章节。

## 3.2 术语预判（对照 glossary）

| 英文 | 定译 | 备注 |
|---|---|---|
| local variable | 局部变量 | 已有 |
| lexical scope / lexical scoping | 词法作用域 / 词法作用域规则 | 已有 |
| scope depth | 作用域深度 | 新增 |
| scope | 作用域 | 已有 |
| shadowing | 遮蔽 | 已有 |
| stack slot | 栈槽位 | 新增 |
| late bound | 晚绑定 | 上一章新增，章内复用 |
| tentative definition | —（未出现）| |
| hash code | 哈希码 | 已有（旁注呼应第20章）|
| register-based bytecode | 基于寄存器的字节码 | 已有（链接指向第15章设计说明）|
| static typing / statically typed | 静态类型 | 已有 |
| sentinel | 哨兵值 | 已有 |
| `depth` | depth | 保留（结构体字段名）|

人名/书名：William Shakespeare→威廉·莎士比亚；*A Midsummer Night's Dream*→《仲夏夜之梦》
（朱生豪有通译本；此处按所给英译直译，不套朱译）。
语言/工具：Rust / Java / JavaScript / Swift / Scala / Kotlin / Scheme 保留。
术语 Algol 60 / Algol 58 / BCPL 保留。

## 3.3 语域判断

**动手为主**，`^code` 33 处。幽默/比喻：

- 章首「think globally, act locally 的冷笑话，我找不到」
- 「deliciously fast——像给数组下标一样简单」
- 「站在直线尽头的瘫痪」（Shakespeare 本人台词）
- 「多线程……用全局变量是个**坏**主意」（反讽）
- 旁注「block 这个名字有点怪」+ 「煤渣砌的方块」图 + 「Algol 58 叫它语句括号」
- 「诸如此类，像鬼一样 linger」（变量像幽灵滞留）
- 「像个正经小软件工程师那样」
- 「连 Scheme 都不是」
- 「诚实到不行的词法作用域」
- 「优化器工具箱里最大的锤子之一：把工作前移到编译器」

## 3.4 翻译难点清单

| 类别 | 原文 | 处理 |
|---|---|---|
| 引用 | 章首莎士比亚 | 有通译但套不上这段→忠于所给英译直译 |
| 双关 | `airy nothing` | interpret：空无一物者 / 虚无缥缈之物 |
| 词 | `hashy little optimization` | 「要是能比一比哈希就好了」（呼应第20章）|
| 词 | `lingers on` | 像幽灵一样赖着不走 |
| 词 | `parsimonious with memory` | 「在内存上稍微抠一点」|
| 词 | `strange beastie` | 「这只怪东西」（呼应第11章 beastie）|
| 词 | `slayed it` | 「当时我们把它斩杀了」|
| 习语 | `pulling work forward into the compiler` | 把工作前移到编译器 |
| 比喻 | `one of the biggest hammers in the toolbox` | 工具箱里最大的锤子之一 |
| 习语 | `straightforward` | 直截了当 |
| 结构 | 图 5 张、C 代码、lox 片段 | 原样保留，alt 翻译 |
| 结构 | `<img ... class="above">`（block.png） | 保留 class |
| 结构 | `<span name="locals"></span>` 空 span | 原样保留 |

## 3.5 结构基线（待机器校验）

- asides 18：global/params/harmony/fn/order/thread/block/helper/locals/lexeme/rust/
  negative/hash/pop/slot/debug/elegant/static（`negative`、`slot`、`debug` 仅 aside）
- spans 15、img 5（scopes/block/declaration/local-slots/phases）、`^code` 33、
  `## ` 5、`### ` 2、div 1
- 链接：last chapter / functions / reg / shadow
