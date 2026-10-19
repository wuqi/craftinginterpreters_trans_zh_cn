# 第14章《字节码块》译前分析

## 3.1 内容与作者

- **讲什么**：本书第二部分（字节码虚拟机 clox）的开篇。先论证「为什么不走树遍历、不直接编译成原生码，而选字节码」，再动手搭出 clox 的骨架：`Chunk` 数据结构、动态数组、内存管理（`reallocate`）、反汇编器、常量表、行号信息。
- **作者意图**：从 jlox 的「已能跑」切换到「换一套执行模型」。这一章偏**动手**（大量 `^code`），但开头有很长的**论证式叙述**（性能/可移植性权衡），是全书最长的一段「说理」。
- **钩子**：结尾明说「下一章见虚拟机如何执行字节码」；开头承接「jlox 已完整但太慢」。埋的伏笔：GC（第26章）、`OP_CONSTANT_LONG`（习题2）、游程编码行号（习题1）。译文要看得见「还没跑代码、只是搭结构」这个状态。

## 3.2 术语预判（对照 glossary，冲突当场定）

| 英文 | 定译 | 备注 |
|---|---|---|
| bytecode | 字节码 | 已有 |
| chunk | 字节码块 | 已有 |
| opcode / operation code | 操作码 | 已有 |
| operand | 操作数 | 已有（注意：指令操作数 ≠ 算术操作数，见原文 aside） |
| disassembler / assembler | 反汇编器 / 汇编器 | 已有 |
| instruction format | 指令格式 | 新增 |
| dynamic array | 动态数组 | 新增 |
| capacity / count | 容量 / 计数 | 新增（原文带引号的字段名） |
| immediate instruction / immediate | 立即指令 / 立即数 | 新增 |
| constant pool | 常量池 | 新增（JVM）；chunk 的用「常量表」（已有） |
| amortized analysis | 摊还分析 | 新增 |
| spatial locality / cache line | 空间局部性 / 缓存行 | 新增 |
| run-length encoding | 游程编码 | 新增 |
| native code / machine code | 原生代码 / 机器码 | 新增（native 系列沿用「原生」） |
| microcode | 微码 | 新增 |
| emulator | 模拟器 | 新增 |
| register allocation / pipelining / instruction scheduling | 寄存器分配 / 流水线 / 指令调度 | 新增 |
| intermediate language | 中间语言 | 新增 |
| p-code | p-code | 保留 |
| Value / Obj / double / uint8_t | 保留原样、正常字体 | style guide 要求 |
| "debug"/"value"/"memory"/"chunk" 模块名 | 加引号保留英文 | style guide 要求 |

人名音译：Donald Knuth→唐纳德·克努特；Niklaus Wirth→尼克劳斯·维尔特。

## 3.3 语域判断

- 前 2/3 偏**叙述/论证**（性能、缓存、权衡），后 2/3 偏**动手**。
- 幽默/自嘲集中段：`metal` 旁注（微码/书架）、`hand` 旁注（用拳头打孔卡）、`flavor` 旁注（其实最爱山核桃黄油味）、`locality` 旁注（另一本书）、`ready` 旁注（配乐蒙太奇）、「AMC Gremlin 抛光成 SR-71 黑鸟」、「像在古早年代」、「我们那个小小的、呃、手工打造的字节码块」、`p-code` 旁注（寒武纪大爆发）、结尾设计说明的「不想变成一场说教」。这些必须保留调侃。

## 3.4 翻译难点清单

| 类别 | 原文 | 处理 |
|---|---|---|
| 习语 | `down to the metal` | interpret：一路深入到最底层 |
| 习语 | `it won't fly` | interpret：根本跑不动 |
| 习语 | `polish an AMC Gremlin into an SR-71 Blackbird` | retain 意象 + 保留车/机名：把一辆 AMC Gremlin 打磨成 SR-71「黑鸟」 |
| 习语 | `like in Ye Olden Times` | 沿用既有「古早的」：像古早年代那样 |
| 习语 | `off the rails` | interpret：脱轨 |
| 习语 | `worth more than squeezing the maximum performance` | interpret：比从每块芯片里榨出极限性能更值 |
| 习语 | `roll our own` | interpret：自己造 |
| 习语 | `carte blanche` | interpret：完全自由地 |
| 习语 | `whip up yet another module` | interpret：再麻利地搓一个模块 |
| 习语 | `The situation isn't entirely dire` | interpret：情况还没到那么糟 |
| 习语 | `vanilla is my favorite ice cream flavor` | 直译保留 + 旁注 butter pecan→山核桃黄油味 |
| 用词 | `venerable NULL` | interpret：德高望重的 NULL |
| 双关/字号 | `*really* fast` / `*sounds* fast`（作者重读） | 一律 **粗体**：**真的**快 / 光**念出来**就快 |
| 结构 | `Constant-time indexed element lookup` 等三条 bullet | 保留 bullet，译成短句 |
| 结构 | `<table>` 4 行（oldSize/newSize/Operation） | 表格文字翻译，`Non&#8209;zero`→非零 |
| 结构 | `<span name="header"></span>` 空锚点 | 原样保留 |
| 长句 | 「the execution model — walking the AST — is fundamentally the wrong design」 | 拆成中文短句 |
| 数字 | 72 seconds / half a second / two orders of magnitude / 32 or 64 bits / 100 times / 15MHz | 见 style guide：散文数字用词，位宽用 0/1 不受影响；「两个数量级」保留 |
| 代码字体 | `OP_RETURN`、`OP_CONSTANT`、`OP_CONSTANT_LONG`、`writeChunk()`、`reallocate()`、`malloc()`、`free()`、`realloc()`、`GROW_ARRAY()`、`Chunk`、`Value` | 代码字体（`OP_*` 与函数带 `()`），类名/类型名 `Chunk`/`Value` 正常字体 |
