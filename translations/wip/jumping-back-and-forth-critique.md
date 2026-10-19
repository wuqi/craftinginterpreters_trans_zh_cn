# 第23章 跳转（jumping-back-and-forth）审校记录

## 一、机器结构核对（脚本比对，全部通过）

| 项 | 原文 | 译文 |
|---|---|---|
| `<aside name=>` | 12 | 12 |
| `<span name=>` | 11 | 11 |
| `name="..."` 总数 | 23 | 23 |
| `name` 出现顺序 | — | **完全一致** |
| `<img>` | 9 | 9 |
| img `src` 逐条 | — | **完全一致** |
| `^code` | 37 | 37 |
| `^code` 名称+参数逐条 | — | **完全一致（0 处不符）** |
| `## ` | 6 | 6 |
| `### ` | 5 | 5 |
| `<div class=>` | 2 | 2 |
| 空行分段数 | 246 | 246 |

上一章（22）初稿曾把 8 个旁注内容误内联进正文，本章初稿一次性放对，
没有出现同类问题：12 个 aside 与 11 个 span 全部位于原文对应位置。

## 二、必须修的 8 处

| # | 位置 | 问题 | 处理 |
|---|---|---|---|
| F1 | 「那三个**分支**结构」段 | 原文 `only jump *forward* over code` 强调的是**方向** forward，初稿误把 `跳过` 加粗 | 改为「只会**向前**跳过代码」 |
| F2 | `## While 语句` 首段 | 原文 `jump *backward*`，初稿写成「向后**跳**」 | 改为「**向后**跳」 |
| F3 | `emit-loop` 段 | 原文 `jumps *backwards*`，初稿写成「向后**跳**」 | 改为「**向后**跳」 |
| F4 | 增量子句第 2 段 | 原文 `jump *back* up to the increment`，初稿写成「向后**跳回**」 | 改为「**向后**跳回增量」 |
| F5 | 设计说明「6,201 条指令」段 | 原文反问句 `*anything* edifying` 的强调被整个丢掉 | 补为「**任何**有教益的信息」 |
| F6 | Böhm–Jacopini 段 | 原文 `*any* control flow using goto` 的强调被丢掉 | 补为「**任何**使用 goto 的控制流」 |
| F7 | 设计说明的三条论点 | 初稿写成 `1. / 1. / 1.`，原文是 `1. / 2. / 3.`（挑战区才是 `1.` 重复） | 恢复 `1. 2. 3.` |
| F8 | Dijkstra 段落 | 原文 `*Communications of the ACM*` 是斜体刊名 | 复核确认初稿已按本书惯例去掉斜体标记、作《ACM 通讯》，无需改动 |

## 三、强调标记逐条复核

原文 22 处 `*…*` / `**…**` 全部落到 `**…**`，无遗漏、无新增：

| 原文 | 译文 |
|---|---|
| `*JVM itself*` | `**JVM 本身**` |
| `*controlling*` | `**控制**` |
| `*current*` | `**当前**` |
| `*conditionally*` | `**有条件地**` |
| `**backpatching**` | `**回填（backpatching）**` |
| `*control flow*` | `**控制流**` |
| `*truthy*` | `**真值**` |
| `*branching*` | `**分支**` |
| `*forward*` | `**向前**` |
| `*looping*` / `*backward*` | `**循环**` / `**向后**` |
| `*backwards*` | `**向后**` |
| `*after*` | `**之后**` |
| `*jump over*` / `*back*` | `**跳过**` / `**向后**跳回` |
| `*increment*` | `**增量**` |
| `*under*` | 面具`**下面**` |
| `*the entire program's*` / `*right*` | `**整个程序**执行` / `**正确的调用点**` |
| `*anything*` | `**任何**` |
| `*any*` | `**任何**` |
| `*can*` | `**可以**` |

译文中除 `**粗体**` 外无任何斜体标记（`*` 只作为 `**` 的组成部分出现）。

span 内的强调也一并核对：`offset`→「偏移」、`if`→「如果」、
`instr`→「留在」、`80s`→「80 年代」、`pop`→「弹出」、
`infinite`→「无限」、`leap`→「跃进」、`style`→「写作」，锚点文字非空。

## 四、链接与图片

| 项 | 结果 |
|---|---|
| `[结构化程序设计][]` + 定义行 | 在位，url 未改 |
| `[讲得更详细][jlox]` + `[jlox]: control-flow.html#for-loops` | 在位，定义行仍留在 `detail` aside 内部 |
| `[证明了][]` + `[证明了]: .../Structured_program_theorem` | 在位 |
| 无 `[x][]` 空引用 | 确认 |
| 9 张图 `image/jumping-back-and-forth/*.png` | src 全部未改，alt 已译成中文，图中的指令名/`OP_*` 保留原样 |

9 张图的 alt 分别对应：无 else 的 if、缝补丁、错误贯穿、带 else 的 if、
完整 if-else 流程、and、or、while、for。

## 五、代码块逐字核对

- `if (condition) print("condition was truthy");` 输出串保留英文。
- `if condition) print("looks weird");` 故意少一个括号的坏语法照原样保留。
- `case OP_JUMP_IF_FALSE:` 示意块保留 `vm.ip += falsey() * offset;`（原书刻意的假代码，
  **没有**「修正」成 `READ_SHORT()` 或 `falsey(peek())`）。
- `for (;;)` 原样。
- 两处 `ebnf` 文法块：key、`→`、引号、括号、分号、缩进全部未动，仅右侧说明译中文。
  两块仍缩进 4 空格且位于 `challenges` div 内。
- `done:` 标签、`!found &&`、`printf("found")`、`found = true` 原样。
- `// See if the matrix contains a zero.` 注释译为「// 看看这个矩阵里有没有 0。」，
  其余代码零改动。

## 六、术语与人名一致性

- `backpatching` 首次出现给「回填（backpatching）」，后续不再重复英文。
- 「条件跳转 / 跳转偏移 / 操作数 / 代码块 / 指令分派 / 反汇编 / 操作码空间 /
  脱糖 / 短路 / 多路分支 / 守卫变量 / 归一化的时钟」全书沿用既有译法。
- `then 分支` / `else 分支` 统一，不混用「然后分支」。
- for 的三个子句统一为「初始化子句 / 条件子句 / 增量子句」，与 21、22 章一致。
- 人名首次出现用「中文（English）」：埃德斯·迪赫斯特拉（Edsger Dijkstra）、
  伯姆（Böhm）、雅科普尼（Jacopini）。Depeche Mode 保留英文（乐队名，中文文献普遍用原文）。
- 题词 `<cite>` 内用《玫瑰的名字》，与 `titles.zh.json` 的书名写法一致。

## 七、通顺度复查

- 「一半一半」类直译已改写为中文语序：`VM 会老老实实地执行这样的字节码`、
  「不管怎么说，我对 Depeche Mode 持久的爱」。
- 挑衅式口吻保留：`请原谅我的这些小乐趣`、`我毫不后悔`、`把我们洗澡水和孩子一起泼掉`、
  `装样子的数学`、`都催我写出来`。
- 「Groovy.」单独成段的玩笑保留原样，不加解释。
- 长句按中文习惯拆逗号，未拆段（分段数与原文一致）。

## 八、构建前结论

结构零偏差，强调八处已修，三条链接与九张图全部在位。
可直接进入 `book/` 并构建。