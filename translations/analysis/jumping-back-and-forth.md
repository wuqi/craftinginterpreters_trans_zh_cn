# 第23章 跳转（jumping-back-and-forth）译前分析

## 1. 章节定位

- clox 第一条真正的控制流：条件跳转 → 回填 → `if/else` → 逻辑运算符短路 → `while` → `for`。
- 全章围绕一条主线：**把嵌套的语法结构压平成字节码里的跳与回跳**。
- 结尾「设计说明：重温 goto 有害论」是本书最长的设计说明，需完整保留论证链条。

## 2. 结构基线（已用脚本核对）

| 项 | 数量 |
|---|---|
| `<aside name=...>` | 12 |
| `<span name=...>` | 11 |
| `<img>` | 9 |
| `^code` | 37 |
| `## ` | 6 |
| `### ` | 5 |
| `<div class=...>` | 2 |

aside 的 `name`：`paren`、`legend`、`offset`、`if`、`80s`、`instr`、`pop`、`detail`、
`infinite`、`leap`、`style`、`break`。

span 的 `name`：`legend`、`offset`、`if`、`80s`、`instr`、`pop`、`detail`、`infinite`、
`leap`、`style`、`break`。

除 `paren` 只有 aside 没有 span 外，其余 11 个 name 在 aside 与 span 中各出现一次，
共 23 处 `name=`。**每个 span 必须放在对应 aside 之前的正文中**，不得内联丢失。

空 span（`<span name="legend"></span>` 等，8 个）：`legend`、`detail`、`break`。
带锚点文字的 span（3 个）：`offset`（"offset"）、`if`（"If"）、
`pop`（跨行的 `<span name="pop">pop</span>`）。其余为行内 `<span name="x">词</span>`。

## 3. `^code` 清单（37 个，含全部 diff 参数）

`parse-if (2 before, 1 after)`、`if-statement`、`emit-jump`、`patch-jump`、
`jump-if-false-op (1 before, 1 after)`、`op-jump-if-false (2 before, 1 after)`、
`read-short (1 before, 1 after)`、`undef-read-short (1 before, 1 after)`、
`compile-else (1 before, 1 after)`、`jump-over-else (2 before, 1 after)`、
`patch-else (1 before, 1 after)`、`jump-op (1 before, 1 after)`、
`op-jump (2 before, 1 after)`、`pop-then (1 before, 1 after)`、
`pop-end (1 before, 2 after)`、`disassemble-jump (1 before, 1 after)`、
`jump-instruction`、`table-and (1 before, 1 after)`、`and`、`table-or (1 before, 1 after)`、
`or`、`parse-while (1 before, 1 after)`、`while-statement`、`loop (1 before, 2 after)`、
`loop-start (1 before, 1 after)`、`emit-loop`、`loop-op (1 before, 1 after)`、
`op-loop (1 before, 1 after)`、`disassemble-loop (1 before, 1 after)`、
`parse-for (1 before, 1 after)`、`for-statement`、`for-initializer (1 before, 2 after)`、
`for-begin-scope (1 before, 1 after)`、`for-end-scope (1 before, 1 after)`、
`for-exit (1 before, 1 after)`、`exit-jump (1 before, 2 after)`、
`for-increment (2 before, 2 after)`

注意 `(N before, M after)` 的数字必须一字不差。

## 4. 需逐字保留的代码块

- `lox` 片段：`if (condition) print("condition was truthy");`（**保留英文输出串**）、
  `if condition) print("looks weird");`（故意语法错误，照译）。
- `ebnf` 文法（两处）：`switchStmt`/`switchCase`/`defaultCase`、`continueStmt`。
  key、箭头 `→`、引号、分号原样，右侧说明翻中文。
- `c` 片段：`case OP_JUMP_IF_FALSE:` 示意代码（正文有 `vm.ip += falsey() * offset;`，
  **保留不修**，这是原书刻意的「假代码」）。
- `c` 片段（设计说明内）：两版矩阵 `break` / `goto done` 对照。注释
  `// See if the matrix contains a zero.` 要译。
- 挑战 1 里的 `switch` 文法块在 `<div class="challenges">` 内部，缩进为 4 空格，
  列表编号用 `1.` 重复。

## 5. 链接（3 条）

| 定义 | 目标 | 处理 |
|---|---|---|
| `[structured programming][]` | en.wikipedia.org/wiki/Structured_programming | 正文 `[结构化程序设计][]` |
| `[jlox]`（aside detail 内） | `control-flow.html#for-loops` | 正文 `[更详细的说明][jlox]`，定义保留在该 aside 内 |
| `[proved][]` | en.wikipedia.org/wiki/Structured_program_theorem | 正文 `[证明了][]` |

除 `structured programming` 外没有跨文件相对链接。**不要改成 `[]` 空引用。**

## 6. 图片（9 张，alt 需译成中文，src 不动）

`if-without-else.png`、`patch.png`、`bad-else.png`、`if-else.png`、`full-if-else.png`、
`and.png`、`or.png`、`while.png`、`for.png`，均在 `image/jumping-back-and-forth/`。

alt 是读者可见的无障碍文本，译中文，保留图中代码/指令名原样（如 `OP_JUMP_IF_FALSE`）。

## 7. 术语决策

| 英文 | 中文 | 备注 |
|---|---|---|
| backpatching | 回填 | 首次出现加「（backpatching）」 |
| placeholder operand | 占位操作数 | |
| fallthrough | fallthrough | 不用译，避免造词 |
| guard variable | 守卫变量 | |
| short-circuit | 短路 | |
| desugar | 脱糖 | |
| multi-way branching | 多路分支 | |
| conditional expression | 条件表达式 | |
| ternary | 三目运算符 | |
| clause（for 的三段） | 子句 | 初始化/条件/增量子句 |
| structured / unstructured | 结构化 / 非结构化 | |
| Turing complete | 图灵完备 | |
| signed operand | 带符号操作数 | |
| opcode space | 操作码空间 | |
| opcode | 操作码 | |
| disassemble | 反汇编 | |
| dispatch | 分派 | |
| iteration | 迭代 | |
| indent 4 空格列表 | 保持 `*   ` 原样 | 机器格式，不动 |

保留英文不译：`if`/`else`/`while`/`for`/`and`/`or`/`switch`/`case`/`default`/`break`/
`continue`/`return`/`var`、`goto`、`OP_JUMP`、`OP_LOOP`、`OP_POP`、`OP_JUMP_IF_FALSE`、
`jlox`、`clox`、Lox 名称、`emitJump()`/`patchJump()`/`emitLoop()`/`loopStart`/`falsey()`、
`Algol 68`、`Groovy`、`.clox`/`.lox`。

## 8. 人名与专名

| 英文 | 中文 |
|---|---|
| Umberto Eco | 翁贝托·埃科 |
| The Name of the Rose | 《玫瑰的名字》 |
| Morticia Addams / Gomez | 莫蒂西亚·亚当斯 / 戈麦兹（《亚当斯一家》中的夫妻） |
| Edsger Dijkstra | 埃德斯·迪赫斯特拉 |
| Go To Statement Considered Harmful | 《Go To 语句被认为是有害的》 |
| Communications of the ACM | 《ACM 通讯》 |
| Scooby Doo | 史酷比 |
| Böhm / Jacopini | 伯姆 / 雅科普尼 |
| Depeche Mode | 保留英文（乐队名，中文文献普遍用原文） |

题词 `<cite>` 内 `The Name of the Rose` 用书名号，与正文书名一致。

## 9. 设计说明（goto 有害论）翻译要点

这是全章最难的部分，五段结构必须完整：

1. 史酷比揭面具的比喻 + 「怪物其实藏在面具**下**面」。
2. Dijkstra 1968 年 3 月《ACM 通讯》文章，以及他 3 条论点（静态文本 vs 动态行为、
   更擅长推理静态物、动态执行越贴合文本结构越好）。论点列表保留 `1.` `2.` `3.` 编号。
3. 他的「correspondence」定义（块引用），作者吐槽「定义相当手挥（hand-wavey）」。
4. 两段块引用：**"The unbridled use..."** 和 **"With the go to statement one can..."**，
   都要照原文节奏译，不要意译抹平。
5. 作者的反驳：循环计数器也是 counter（"normalized clock"），Böhm–Jacopini 结构化定理
   给出反例（作者自己承认「我的论证也弱」），再到 `break` vs `goto done` 两段 C 代码对照，
   最后落到「基于恐惧做语言设计」。

`Groovy.` 这句在原文中是独立成段的双关（Groovy 语言名 = groovy/热闹），译
「Groovy。」保留原样并可在分析里记为双关，不加解释性旁注。

设计说明内的 `faux-modest self-aggrandizing` 是嘲讽语气，译「假装谦虚的自吹自擂」。

## 10. 重点校对清单

- [ ] 12 个 aside 全部存在、顺序不变、内部 `name` 一致。
- [ ] 11 个 span 全部存在（3 个空 span 写成 `<span name="x"></span>`）。
- [ ] 37 个 `^code` 的名称与 `(N before, M after)` 全部一致。
- [ ] 9 张 img 的 src 路径不动，alt 已译。
- [ ] 3 条链接定义都在，且引用处不是空引用。
- [ ] 挑战里两处 `ebnf` 代码块缩进仍是 4 空格、仍在 `challenges` div 内。
- [ ] `OP_JUMP_IF_FALSE` 假代码里的 `vm.ip += falsey() * offset;` 未被"修正"。
- [ ] 全文 `*斜体*` 只在原文处使用，中文强调统一 `**粗体**`。
- [ ] 段落数与原文一致（不合并、不拆分）。