# 第25章 闭包（closures）审校记录

## 一、机器结构核对（脚本比对，全项一致）

| 项 | 原文 | 译文 |
|---|---|---|
| `<aside name=>` | 27 | 27 |
| `<span name=>` | 27 | 27 |
| `name="..."` 总数 | 54 | 54 |
| `name` 出现顺序 | — | **完全一致** |
| `<img>` | 8 | 8 |
| img `src` + `class` 逐条 | — | **完全一致** |
| `^code` | 68 | 68 |
| `^code` 名称+参数逐条 | — | **完全一致** |
| `## ` / `### ` | 6 / 9 | 6 / 9 |
| `<div class=>` | 2 | 2 |
| 代码围栏 ``` | 48 | 48 |
| 空行分段数 | 441 | 441 |

27 个 name（flying…three）各出现两次（aside + span），无单例特例。

## 二、初稿查出并已修的 7 处

| # | 问题 | 处理 |
|---|---|---|
| F1 | 漏 span `lambda`（`all <span>manner</span> of ways`） | 补 `<span name="lambda">**各式各样**</span>`，并删掉自造的「（all manner of）」注释 |
| F2 | 漏 span `raw`（`the <span>"raw"</span> compile-time state`） | 补 `<span name="raw">**原始**（raw）</span>` |
| F3 | 漏 span `outer`（`the most deeply <span>nested</span> call`） | 补 `<span name="outer">嵌套最深</span>` |
| F4 | 漏 span `close`（`The compiler <span>does</span> *not* emit`） | 补 `<span name="close">**绝不会**</span>` |
| F5 | 「否则，我们为我们的局部槽位创建一个新 / upvalue」被硬拆成两段，比原文多一个分段且句子断裂 | 合回一段 |
| F6 | **系统性缺陷**：初稿有 66 处 `*斜体*` 混用（违反「中文不得用斜体」），散布在 40 行 | 逐行转成 `**粗体**`，转换后正文斜体数 = 0 |
| F7 | PowerShell 重写文件引入 CRLF 行尾，导致 `^code` 校验因尾随 `\r` 全部失配 | 全部转回 LF，`CR` 残留 = 0，`^code` 逐条比对重新通过 |

## 三、强调标记终态

原文 72 处斜体 + 6 处粗体 = 78 处；译文 `**粗体**` 共 88 项，其中：

- **嵌套强调 2 处合并**：原文 `**The local slot we stopped at *is* the slot we're looking for.**`
  与 `**We found an upvalue whose local slot is *below* ...**`。中文只有一种粗体层级，
  内外两层无法同时表达，故把整句加粗（`就是`／`之下` 不再单独区分）。
  原文 `*does*` + `*not*` 连写同理，合并为 `**绝不会**`。
- 其余 86 项与原文一一对应，包括容易漏掉的：
  `在大体`、`*all*`（在**所有**引用它的对象）、`*will*`（用户**将**有可能）、
  `*are*`（**确实**被闭包使用）、`*yet*`（**目前**还不用）、`*does*`（编译器**确实不**会）、
  挑战里的 `*x*` `*y*` 各两处、`*three*`、`*should*`（**本该**能工作 / Lox **应该**怎么表现）。

清理后正文（排除代码块与 `*   ` 列表符）**单星号斜体 = 0**。

## 四、链接（8 条定义 / 8 处引用）

| 引用 | 定义 |
|---|---|
| `[上一章][last]` | `calls-and-functions.html` |
| `[原型继承][]` | `Prototype-based_programming`（在 `raw` aside 内） |
| `[即将到来的垃圾回收器][gc]` ×2 | `garbage-collection.html`，**定义出现两次**（`pop` aside 内 + obj-upvalue 段末），与原文一致 |
| ``[`map()`][map]`` / ``[`filter()`][filter]`` | 两个 Wikipedia 链接（`create` aside 内） |
| `[下一步][]` | `garbage-collection.html` |
| `[著名的公案][koan]` | `wiki.c2.com/?ClosuresAndObjectsAreEquivalent` |

无 `[x][]` 空引用；8 条定义的**目标地址集合与原文完全相同**。

## 五、编号列表

原文序列 `1,2 | 1,2 | 1,2,3 | 1,2,3`（两个问题、两个待答问题、三个退出理由、三道挑战）。
初稿一律写成 `1.`，已全部改回原文编号。译文序列现为 `1,2,1,2,1,2,3,1,2,3`，与原文逐位相同。

## 六、代码与图逐字核对

- `text` 反汇编样例 5 行（含 `|` 续行对齐与 `upvalue 0` / `local 1`）**一字未改**。
- `text` 预期输出 3 行 `return from outer / create inner closure / value` 一字未改。
- 挑战 3 末尾 `[koan]` 定义前保留原文的**两个连续空行**（这会多出一个空段落，
  但正是原文的排版，已照抄以保证分段数 441 一致）。
- `&#9312; &#9313; &#9314;` 三个实体原样保留。
- `flying.png` 的 `class="above"` 属性保留；8 张图 alt 全部译成中文，`src` 未动。
- 所有 `lox` 代码块、`(1)(2)(3)` 行尾注释、`// (1)` 全部原样。

## 七、术语决定

- **upvalue 保留英文**。全章出现约 150 次，且代码里是 `OP_GET_UPVALUE`、`ObjUpvalue`、
  `addUpvalue()`；自造中文译名（曾考虑「上值」）反而割裂。首次出现处标注
  「**upvalue**（闭包变量）」，全书统一。
- `open upvalue` / `closed upvalue` 同样保留英文，因为它们是 Lua 的专有构造名，
  且中文「开放/关闭」与「作用域开放」易混。
- `close over`（动词）→「捕获」；`closed-over variable` →「被捕获的变量」/「被闭包捕获的局部变量」。
- `close`（关闭 upvalue 的动作）→「关闭」，首次给原文 `closing`。
- `hoist` →「提升/搬到堆上」；`intrusive list` →「侵入式链表」；
  `singly linked list` →「单链表」；`indirection` →「一层间接」。
- `koan` →「公案」（禅宗公案）；`Data Structures 101` →「数据结构入门」。
- 语言与运行时名一律保留：Lua、JavaScript、Python、Ruby、C#、Java、Dart、JS 的 `var`/`let`。
- `Foucault's Pendulum` →《傅科钟》；`Umberto Eco` 沿用第23章已登记的「翁贝托·埃科」。

## 八、结论

结构零偏差，强调标记已全部合规（正文斜体 0），编号列表与原文逐位一致，
8 条链接与 8 张图齐备，两个 `text` 代码块逐行匹配。可进入构建。