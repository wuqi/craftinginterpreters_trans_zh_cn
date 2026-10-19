# 第26章 类（classes）译前分析

## 1. 结构基线（脚本核对）

| 项 | 数量 |
|---|---|
| `<aside name=>` | 24 |
| `<span name=>` | 21 |
| `name="..."` 总数 | 45 |
| `<img>` | 7 |
| `^code` | 49 |
| `## ` / `### ` | 9 / 5 |
| `<div class=>` | 2 |
| 代码围栏 ``` | 56 |
| 空行分段数 | 391 |

24 个 name 中，**21 个各出现两次**（aside + span），**3 个只有 aside**：
`hidden`、`order`、`local`。span 数因此是 21 而非 24，不要给这三处补 span。

## 2. 已知的四类坑（第22–25章各踩过一遍）

1. **漏 span**：`hidden`、`allocate`、`words`、`get-ast` 四处的 span 在初稿里被丢掉，
   因为中文把原文句首的 "The"/"A" 删掉后，span 变成了段首。删虚词时必须同步搬运 span。
2. **斜体混用**：初稿有 60 余处 `*斜体*`，必须全部转 `**`。
3. **编号列表不是一律 `1.`**：原文序列 `1,1,1 | 1,2 | 1,2,3 | 1,2,3`，共 4 组。
4. **段落顺序错位**：初稿把 Person 代码块和它前面那段话、以及 `shadow` aside
   和它前面那句「方法就是用这个查出来的」都调换了位置。用「段落类型序列逐位比对」
   才能发现，光数总数会漏掉「一进一出正好抵消」的情况。

## 3. 链接（26 条定义，其中 3 条重复定义）

- `[inheritance]` **定义两次**（正文开头一次、`circle` aside 之后一次）——照抄。
- `[原型]`（原 `prototypes`）**定义两次**：正文一次 + 文件末尾 `</div>` 之后一次。
- 文件**末尾 `</div>` 之后**还有 5 条连续定义（`delegate`/`prototypes`/`self`/`finch`/`wren`），
  彼此之间**没有空行**，属于同一段落。
- `[proto]` 的定义位置在设计说明的「复杂度」列表之后，不是首次用到它的地方。
- id 与引用文字不同的：`[function rule]`、`[later]`、`[placement new]`、`[hidden classes]`
  必须**保持英文 id**，只把引用处的显示文字译成中文，否则链接断掉。

## 4. 术语与人名

- `power` → **力量**（沿用 `titles.zh.json` 里「原型与力量」这一既有译名），
  公式 `power = breadth × ease ÷ complexity` **一字不改**，正文译为「广度 × 易用性 ÷ 复杂度」。
- `getter` / `setter` / `get expression` / `set expression` 沿用既有译法（英文 + 中文说明）。
- `multimethod` → 多重分派；`metaclass` → 元类；`bound method` → 绑定方法；
  `hidden class` → 隐藏类；`encapsulate` → 封装；`dispatch` → 分派。
- 人名首次出现用「中文（English）」：列奥纳多·达·芬奇、David Ungar、Randall Smith、
  Brendan Eich、埃尔顿·约翰。
- 语言/运行时名全保留：Java、C++、Smalltalk、Ruby、Python、JavaScript、Lua、C#、
  Fortran、Matlab、AppleScript、Simula、Self、Magpie、CLOS、Dylan、Julia、Raku。
- 设计说明标题沿用既有译名「原型与力量」。

## 5. 易错点

- `It was goto all along!` 类玩笑保留语气；`Et voilà` → 「*成了*」。
- 挑战 2 的 `area { ... }`（getter 无形参列表）与 `3.141592653 * this.radius * this.radius;`
  **一字不改**，这个 `*` 不能当强调处理。
- `img src="image/classes/setter.png" alt="breakfast.omelette.filling.meat = ham"`
  alt 是代码，原样保留。
- `<aside name="allocate">` 在编号列表项**内部**，缩进 4 空格，连同 `</aside>` 一起。
- `allocate` aside 里的 `[placement new]` 定义带空格，且是独立段落。

## 6. 交付前自检

- [ ] aside 24 / span 21 / name 45 顺序一致
- [ ] `^code` 49 个名称+参数逐条一致
- [ ] 分段数 391，且**段落类型序列逐位零分歧**
- [ ] 编号列表序列 `1,1,1,1,2,3,1,2,1,2,3` 与原文一致
- [ ] 26 条链接定义齐全、所有引用 id 都有定义
- [ ] 7 张图 src 未变、alt 已译
- [ ] 正文斜体 = 0