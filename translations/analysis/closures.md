# 第25章 闭包（closures）译前分析

## 1. 章节定位

clox 第一次真正实现闭包：先有 `ObjClosure`，再有 `upvalue`，最后把 `upvalue` 从栈上
「关闭」进堆。技术路线来自 Lua VM：单遍编译器 + upvalue 间接层。

## 2. 结构基线（脚本核对）

| 项 | 数量 |
|---|---|
| `<aside name=>` | 27 |
| `<span name=>` | 27 |
| `name="..."` 总数 | 54 |
| `<img>` | 8 |
| `^code` | 68 |
| `## ` | 6 |
| `### ` | 9 |
| `<div class=>` | 2 |
| 代码围栏 ``` | 48 |
| 空行分段数 | 441 |

27 个 name（`flying`、`stack`、`lambda`、`literal`、`raw`、`macro`、`naked`、`pop`、
`undefined`、`bridge`、`devious`、`base`、`outer`、`count`、`assign`、`academic`、
`global`、`after`、`param`、`zero`、`indirect`、`create`、`head`、`double`、`cool`、
`close`、`three`）**各出现两次**，无单例特例。

## 3. 风险点（第22、23、24章各栽过一次的地方）

1. **27 个 span 全部带锚点文字或为空 span**，其中 5 个是空的：
   `<span name="pop">The</span>` 之类要把整词换成中文（`pop`→`编译器`），
   不能只保留 `**粗体**` 而丢锚点。
2. **段落数 441 极多**，任何一处拆分/合并都会破坏计数。用脚本逐项比对，不靠肉眼。
3. **两个 `text` 代码块必须逐行原样**：
   反汇编样例（含 `|` 对齐）、预期输出 3 行。
4. **`&#9312; &#9313; &#9314;` 三个 HTML 实体**不能改成 ①②③，必须保留实体。
5. **挑战 3 末尾 `[koan]` 定义前有两个连续空行**，这在原文里制造一个空段落；
   照抄才能让分段数对上 441。
6. **编号列表不是一律 `1.`**：原文序列是 `1,2 | 1,2 | 1,2,3 | 1,2,3`，四组列表各不相同。

## 4. `^code` 清单（68 个）

分四段：闭包对象 21 个（`obj-closure` … `interpret (1 before, 2 after)`）、
编译 upvalue 15 个、`upvalue` 对象 17 个、运行时关闭 15 个。
完整清单见脚本输出，重点是带参数的：
`new-closure-h (2 before, 1 after)`、`disassemble-closure (2 before, 1 after)`、
`read-constant (2 before, 2 after)`、`named-variable-upvalue (3 before, 1 after)`、
`too-many-upvalues (5 before, 1 after)`、`resolve-upvalue-recurse (4 before, 1 after)`、
`end-scope (3 before, 2 after)`、`interpret (1 before, 2 after)`、
`free-upvalue (3 before, 1 after)`、`print-upvalue (3 before, 1 after)`。

## 5. 链接（8 条定义，注意 `[gc]` 重复定义两次）

`[last]`、`[prototypal inheritance]`（raw aside 内）、`[gc]` ×2、`[map]`、`[filter]`
（create aside 内）、`[next step]`、`[koan]`。
`[gc]: garbage-collection.html` 在「pop aside 内」和「obj-upvalue 段末」各定义一次，
**两处都要保留**。

## 6. 图片（8 张）

`flying.png`（带 `class="above"`，在 flying aside 内）、`obj-closure.png`、
`open-upvalue.png`、`execution-flow.png`、`linked-upvalues.png`、`recursion.png`、
`linked-list.png`、`closing.png`。alt 译中文，`src` 与 `class` 原样。

## 7. 术语

- **upvalue 保留英文**，首次出现标「**upvalue**（闭包变量）」。理由：全章约 150 次，
  且代码里就是 `OP_GET_UPVALUE`/`ObjUpvalue`/`addUpvalue()`；自造中文名会割裂。
  `open upvalue` / `closed upvalue` 同理保留。
- close over → 捕获；closed-over variable → 被捕获的变量；
  close（upvalue）→ 关闭；hoist → 提升/搬到堆；stack window → 栈窗口；
  stack slot → 栈槽位；indirection → 一层间接；intrusive list → 侵入式链表；
  singly linked list → 单链表；heap → 堆；koan → 公案；
  `Data Structures 101` → 数据结构入门；`Zen master` → 禅师。

## 8. 人名与书名

- Umberto Eco → 翁贝托·埃科（沿用第23章）
- Foucault's Pendulum →《傅科钟》
- 语言名全保留：Lua、JavaScript、Python、Ruby、C#、Java、Dart。
- `var` / `let` / `foreach` / `for-of` / `for-in` 保留原文代码形式。

## 9. 设计说明（闭包捕获循环变量）

要覆盖 5 种语言（Lox 两种写法、JavaScript 三种、Python、Ruby 两段），
所有代码块语言标记 `js` / `python` / `ruby` 原样，**代码里的 `console.log`、`i++`、
`range(1, 3)`、`1..2`、`do |i| ... end` 一律不动**，只译外围散文。
`"objects are a poor man's closure"` →「对象是穷人版的闭包」。

## 10. 交付前自检

- [ ] aside 27 / span 27 / name 54 顺序一致
- [ ] `^code` 68 个名称+参数逐条一致
- [ ] 分段数 441、围栏 48
- [ ] 编号列表序列 `1,2,1,2,1,2,3,1,2,3` 与原文逐位相同
- [ ] 3 个 HTML 实体保留
- [ ] 2 个 `text` 代码块逐行原样
- [ ] 8 条链接定义（含两处 `[gc]`）与 8 张图齐备
- [ ] 正文斜体 = 0