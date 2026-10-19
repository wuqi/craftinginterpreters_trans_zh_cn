# 第15章《虚拟机》译前分析

## 3.1 内容与作者

- **讲什么**：clox 的执行核心。定义 VM 结构体与全局实例、指令指针（IP）、`run()` 分派循环、
  执行追踪（disassembler + 栈追踪）、值栈（压入/弹出）、两条指令的重做（`OP_CONSTANT` 压栈、
  `OP_RETURN` 弹栈打印）、一元取负与四则二元运算。
- **作者意图**：先讲「后端」（执行），因为「没见过指令跑起来就写不出编译器」。为第16章之后
  的「按需扫描 / 编译表达式」铺路。
- **钩子**：开头承接上一章「手工造的字节码块」；结尾「这是最后一个手工搭的块，下次见字节码
  时我们会写编译器」——预埋后面 15 章。设计说明引出「基于寄存器 vs 基于栈」。

## 3.2 术语预判（对照 glossary）

| 英文 | 定译 | 备注 |
|---|---|---|
| instruction pointer / IP | 指令指针 | 新增 |
| program counter / PC | 程序计数器 | 新增 |
| decode / decoding | 解码 | 新增 |
| dispatch / dispatching | 分派 | 新增 |
| push / pop | 压入 / 弹出 | 新增（动词）；名词也同 |
| stack overflow | 栈溢出 | 新增 |
| stack | 栈 | 已有 |
| stack frame / call frame | 栈帧 / 调用帧 | 已有 |
| operand / opcode / instruction | 操作数 / 操作码 / 指令 | 已有 |
| disassembler | 反汇编器 | 已有 |
| unary negation / binary operator | 一元取负 / 二元运算符 | 已有 |
| postorder traversal | 后序遍历 | 已有 |
| register allocation | 寄存器分配 | 上一章已加 |
| register-based bytecode | 基于寄存器的字节码 | titles.zh.json 设计说明名 |
| just-in-time compilation | 即时编译（JIT） | 新增 |
| silver bullet | 银弹 | 新增 |
| minuend / subtrahend | 被减数 / 减数 | 新增 |
| direct threaded code / jump table / computed goto | 保留英文（读者要自查） | 加中文桥 |
| Value / Chunk / stackTop / ip | 保留原样，正常字体 | style guide |
| register windows | 寄存器窗口 | 新增 |

人名音译：Christopher Priest→克里斯托弗·普里斯特；Vaughan Pratt→沃恩·普拉特；
Roberto Ierusalimschy→罗伯托·耶鲁萨林斯基；Waldemar Celes→瓦尔德马·塞莱斯；
Luiz Henrique de Figueiredo→路易斯·恩里克·德·菲格雷多。
书名：*The Prestige* →《致命魔术》（有中译本；`<em>` 按既有约定转《》、不加粗，见
`book/types-of-values.md` 先例）。

## 3.3 语域判断

**动手为主**，`^code` 39 处；叙述夹在指令之间。幽默/比喻密集：

- L9「像只用填充的死动物标本学生物」
- L38「把这些函数叫『实现』有点勉强」
- L163「它**会**……（将在几章后）如今可算不上什么软件巫术奇迹」
- L299 旁注：查字典查来的 minuend/subtrahend，「『被减数』听上去像一种伊丽莎白时代的舞蹈」
- L413「这就叫作……栈！」
- L419 旁注：煎饼的「栈」
- L434「我**爱**基于栈的虚拟机」「撕开看穿后仍留有火花」
- L461 旁注：银弹、脱掉一层光泽
- L472「好嘞，开写代码！」
- L645「神奇！」
- L683 旁注：把 *运算符* 当宏参数传进去
- L697 `WAKE_UP()` 咖啡段子
- 结尾：「把它从你系统里释放出来」「这是我们手工搭的最后一个块」

## 3.4 翻译难点清单

| 类别 | 原文 | 处理 |
|---|---|---|
| 比喻 | `learning biology using only stuffed, dead animals` | retain 意象：像只对着填充的死标本学解剖 |
| 比喻 | `watching the instructions prance around` | interpret：看着指令活蹦乱跳 |
| 习语 | `achingly slow` | 慢得让人难受 |
| 短语 | `spin up / wind it down` | 启动 / 收尾关掉 |
| 短语 | `wire it up` | 把它接进 |
| 短语 | `plumbing that constant along` | 把常量一路输送 |
| 短语 | `black box` | 黑盒 |
| 习语 | `dead simple` / `a piece of cake` / `cheating at the game` | 简单得要命 / 小菜一碟 / 像在作弊 |
| 习语 | `take a bit of the sheen off` | 稍稍磨掉一点光泽 |
| 习语 | `burning hellscape of pain` | 一片火海般的痛苦炼狱 |
| 习语 | `surgically extracting a nasty bug from the bowels` | 像做手术一样从内脏里剜出一只恶心的 bug |
| 习语 | `get it out of your system` | 趁热把它玩个够（尽情释放） |
| 词 | `Alas` / `Alack` | 唉 / 悲哉 |
| 词 | `adventurous` (macro) | 有点**胆大妄为** |
| 双关 | `crepe`（可丽饼，字母入栈） | 保留，注「可堆叠的早餐」 |
| 双关 | `pancakes` 旁注「这也是一个栈」 | 保留（煎饼叠起来） |
| 结构 | `**decoding** / **dispatching**` | 术语首现加粗：**解码**、**分派** |
| 结构 | L350–356 输出注释 `// from echo(1)` | 程序输出**不译**，保留原样 |
| 结构 | `#define WAKE_UP()` 等 C 段 | 代码不动 |
| 结构 | `<img>` alt 全部翻译 | |
| 长难句 | L363–374「jlox 用局部变量存临时值…clox 没这待遇」 | 拆句 |
