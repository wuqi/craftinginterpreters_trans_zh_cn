# 第26章 类（classes）审校记录

## 一、机器结构核对

| 项 | 原文 | 译文 |
|---|---|---|
| `<aside name=>` | 24 | 24 |
| `<span name=>` | 21 | 21 |
| `name="..."` 总数 | 45 | 45 |
| `name` 出现顺序 | — | **完全一致** |
| `<img>` | 7 | 7 |
| img `src` 逐条 | — | **完全一致** |
| `^code` | 49 | 49 |
| `^code` 名称+参数逐条 | — | **完全一致** |
| `## ` / `### ` | 9 / 5 | 9 / 5 |
| `<div class=>` | 2 | 2 |
| 代码围栏 ``` | 56 | 56 |
| 空行分段数 | 391 | 391 |
| **段落类型序列** | — | **逐位零分歧** |

最后一项是关键：只比「总数 391 = 391」会漏掉「一进一出正好抵消」的错位，
所以额外做了逐段类型比对（TEXT / CODE / FENCE / ASIDE / IMG / NUM / BUL / LINKDEF / HEAD / QUOTE），
结果完全一致。

## 二、初稿查出并已修的 9 处

| # | 问题 | 处理 |
|---|---|---|
| F1 | 漏 span `allocate`（「运行时为崭新的实例**分配**」丢了锚点） | 补 `<span name="allocate">**分配**</span>` |
| F2 | 漏 span `words`（「很多（很多）**字**」丢了锚点） | 补 `<span name="words">**字**</span>` |
| F3 | 60 余处 `*斜体*` 混用 | 逐行转 `**粗体**`，正文剩余斜体 = 0 |
| F4 | 编号列表全写成 `1.`，破坏 4 组不同编号 | 改回 `1,1,1 \| 1,2 \| 1,2,3 \| 1,2,3`，与原文逐位相同 |
| F5 | 漏一整段「The method is looked up using this:」 | 补回「方法就是用这个查出来的：」，置于 `shadow` aside 之前 |
| F6 | **段落顺序错位**：把「如果你从某个实例上抓住一个方法的句柄…」移到了 Person 代码块**之前** | 移回代码块之后（原文顺序：代码块 → 该段 → 「更病态的例子」） |
| F7 | `[proto]` 定义被我挪到了首次引用处 | 移回设计说明「复杂度」列表之后，与原文一致 |
| F8 | **链接 id 断链 2 处**：`[之前][function rule]` 但定义写成 `[之前]`；`[以后][later]` 但定义写成 `[以后]` | 定义改回 `[function rule]` / `[later]` |
| F9 | PowerShell 重写引入 CRLF | 转回 LF，`^code` 校验重新逐条通过 |

修完后所有引用 id 都有对应定义，`site/classes.html` 无任何残留 `[x][]`。

## 三、`hidden` / `order` / `local` 三个「只有 aside」的特例

这 3 个 name 在原文里只出现 1 次（没有 span），全文 span 数因此是 21 而不是 24。
译文严格保持 21 / 45，没有为它们硬造锚点。

## 四、链接（26 条定义 / 23 个被引用目标）

- `[inheritance]` **重复定义两次**，照抄。
- `[原型]`（原 `prototypes`）**重复定义两次**：正文一次 + 文件末尾 `</div>` 之后一次。
- 文件末尾 5 条连续定义（`delegate` / `原型` / `self` / `finch` / `wren`）之间**无空行**，
  属同一段落，排版照抄。
- `[proto]` 定义在「复杂度」列表之后。
- 英文 id 全部保留：`function rule`、`later`、`placement new`、`hidden classes`→`隐藏类`、
  `proto`、`self`、`finch`、`wren`、`delegate`、`clos`、`magpie`、`dylan`、`julia`、`raku`、
  `lua`、`appendix-*`、`metaclasses`→`元类`。
- `site/classes.html` 校验：23 个目标全部命中，残留空引用 0。

## 五、编号列表

原文 4 组：`1,1,1`（类的三件事）、`1,2`（构造的两个操作）、`1,2,3`（order aside 的三个操作）、
`1,2,3`（三道挑战）。译文序列 `1,1,1,1,2,3,1,2,1,2,3`，与原文逐位相同。

## 六、强调标记

原文 60 处斜体 + 5 处粗体。译文 `**粗体**` 共 76 项，正文（排除代码块与 `*   ` 列表符）
**单星号斜体 = 0**。

容易漏掉的都已补上：`*really*`（**真的**）、`*super rad*`（**酷毙了**）、
`*have*`（**没有**）、`*Et voilà*`（**成了**）、`*still*`（**还**）、
`*which*`（**哪些**）、`*own*`（**拥有**）、`*should*`（**应该**）。

`## This` 章下的 `this` 与 `This` 标题按原样保留英文（这是语言关键字）。

## 七、术语

- **power → 力量**：沿用 `titles.zh.json` 中设计说明标题「原型与力量」的既有译名；
  公式代码块 `power = breadth × ease ÷ complexity` **一字不改**，散文里对应
  「广度 × 易用性 ÷ 复杂度」。
- `multimethod` → 多重分派；`metaclass` → 元类；`bound method` → 绑定方法；
  `hidden class` → 隐藏类；`encapsulate` → 封装；`property dispatch` → 属性分派。
- getter / setter / get 表达式 / set 表达式沿用既有译法。
- 人名首次出现「中文（English）」：列奥纳多·达·芬奇、戴维·昂加、兰德尔·史密斯、
  布伦丹·艾克、埃尔顿·约翰。
- 语言名全保留。

## 八、代码块

- `ebnf` 3 块、`lox` 十余块、`text` 1 块（力量公式）全部原样。
- 挑战 2 的 `area { ... }` 与 `3.141592653 * this.radius * this.radius;` 一字未改。
- `setter.png` 的 alt 是代码 `breakfast.omelette.filling.meat = ham`，原样保留。
- 其余 6 张图 alt 译中文，`src` 未动。
- `<aside name="allocate">` 连同 `</aside>` 保持缩进 4 空格、仍在编号列表项内部。

## 九、结论

结构零偏差（含段落类型序列）、强调全数合规、编号与链接 id 全部正确、7 张图齐备。
构建退出 0、5,336 行代码、`site/classes.html` 无空引用。可交付。