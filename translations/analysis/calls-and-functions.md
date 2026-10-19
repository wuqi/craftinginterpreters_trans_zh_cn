# 第24章 调用和函数（calls-and-functions）译前分析

> 注意：本书章节编号以 `site/contents.html` 为准（不计 `welcome.md` 与两个分隔页）。
> 本章 = **第24章**，文件 `calls-and-functions.md`。
> 上一版把 `functions.md`（第10章）误标为第24章，已在 `PROGRESS.md` 更正。

## 1. 结构基线（脚本核对）

| 项 | 数量 |
|---|---|
| `<aside name=>` | 27 |
| `<span name=>` | 24 |
| `name="..."` 总数 | 51 |
| `<img>` | 7 |
| `^code` | 81 |
| `## ` / `### ` | 8 / 10 |
| `<div class=>` | 1 |
| 代码围栏 ``` | 20 |
| 空行分段数 | 412 |

27 个 aside 的 `name`：eat、name、free-name、wrap、current、null、closure、debug、
static、fortran、imagine、return、heap、plenty、local、fun、**no-end-scope**、
nested、compiler、useful、lua、**switch**、**minus**、top、worst、worry、faster。

加粗的三个（`no-end-scope`、`switch`、`minus`）**只有 aside 没有 span**，
所以 span 数是 24 而不是 27。其余 24 个各出现两次。

## 2. 本章特有的四个坑

1. **24 个 span 无一带强调**。第22–26章我有个习惯：把 span 锚点文字加粗。
   本章原文里 span 内容全是纯文本（如 `<span name="eat">meal</span>`、
   `<span name="current">chapters</span>`），所以**一个都不能加粗**。
   这是本章最容易整体性出错的地方。
2. **中文删虚词会让 span 变成段首**（"The `<span>release</span>`…" →
   「「<span>发布</span>时…」），脚本按 `^\<span` 分类段落时会误判，必须单独核对。
3. **段落顺序错位会「一进一出」抵消总数**，只比 412=412 发现不了。
   必须做「段落类型序列逐位比对」（第26章已加上，本章沿用）。
4. **挑战区段落结构不对称**：挑战 3 是两段、挑战 4 是一段，其余各一段。

## 3. `^code` 清单（81 个）

分五段：函数对象 10 个、编译成函数对象 15 个、调用帧 15 个、
函数声明 11 个、函数调用 16 个、原生函数 14 个。
带 `(N before, M after)` 的重点：
`obj-function (2 before, 2 after)`、`new-function-h (3 before, 1 after)`、
`obj-type-function (1 before, 2 after)`、`current-chunk (1 before, 2 after)`、
`call-end-compiler (4 before, 1 after)`、`call-frame (1 before, 2 after)`、
`frame-max (2 before, 2 after)`、`enclosing-field (2 before, 1 after)`、
`init-function-name (1 before, 2 after)`、`obj-native (1 before, 2 after)`、
`obj-type-native (2 before, 2 after)`、`vm-include-time (1 before, 2 after)`。

## 4. 链接（6 条定义，`[gc]` 重复两次）

`[gc]: garbage-collection.html`（`free-name` aside 内 + `worry` aside 内，**两处都要保留**）、
`[closures]: closures.html`、`[cont]`、`[stage]: local-variables.html#another-scope-edge-case`、
`[inverted pyramid]`。

id 与显示文字不同的：`[stage]`、`[inverted pyramid]`、`[gc]`、`[closures]`、
`[cont]` —— **一律保留英文 id**，只译显示文字，否则断链。

## 5. 术语

call frame → 调用帧；frame pointer → 帧指针；base pointer → 基址指针；
return address → 返回地址；stack trace → 堆栈跟踪；stack window → 栈窗口；
value stack → 值栈；stack semantics → 栈语义；arity → 元数；
native function → 原生函数；recursive descent → 递归下降；
continuation → 延续；metadata → 元数据；inverted pyramid → 倒金字塔。
`register`、`typedef` 等 C 关键字保留原文。

## 6. 必须逐字保留

- `text` 块：示例栈跟踪 5 行（`Expected 0 arguments but got 2.` 等）——程序输出，不译。
- 8 个 `lox` 块，含坏代码 `var notAFunction = 123; notAFunction();`、
  `noReturn()` 里的 `// No return here.`、`print noReturn(); // ???`、
  `c("too", "many");`、`return "What?!";`。
- 图 alt 里的记号：`Stack: 4, fn sum, 5, 6, 7.`、`frame-&gt;slots`（HTML 实体）。

## 7. 人名

David Wheeler → 大卫·惠勒（David Wheeler）。语言名 C、Lua、Fortran、Ruby、Python、
C#、JavaScript 全保留。

## 8. 双关清单

「swallow the whole meal」「Eating — consumption — is a weird metaphor」
「poor man's object orientation」「hair thin between genius and madness」
「kind of a let down」「It almost looks like we know what we're doing」
「I'm going to make a dumb joke about the `fun` keyword every time」。

## 9. 交付前自检

- [ ] aside 27 / span 24 / name 51 顺序一致，三个「只有 aside」的 name 没有 span
- [ ] `^code` 81 个名称+参数逐条一致
- [ ] 分段 412 且段落类型序列零分歧
- [ ] 编号列表 1,2,3,4
- [ ] **span 内粗体 = 0**
- [ ] 正文斜体 = 0
- [ ] 强调总数 = 38（含跨行 1 处）
- [ ] 6 条链接定义齐全、引用 id 全部可解析
- [ ] 7 张图 src 未变、alt 已译