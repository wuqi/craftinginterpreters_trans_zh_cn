# 第26章 垃圾回收（garbage-collection）译前分析

> 本章 = **第26章**，文件 `garbage-collection.md`（第24章 `calls-and-functions.md` 已完成）。

## 1. 结构基线（脚本核对）

| 项 | 数量 |
|---|---|
| `<aside name=>` | 24 |
| `<span name=>` | 24 |
| `name="..."` 总数 | 48 |
| `<img>` | 11 |
| `^code` | 64 |
| `## ` / `### ` | 9 / 12 |
| `<div class=>` | 2 |
| 代码围栏 ``` | 6 |
| 空行分段数 | 367 |

24 个 name 全部**成对**（aside + 正文锚点），无「只有 aside」的特例。
两个 span 是空的：`color`（`<span name="color"></span>**tricolor abstraction**`，
粗体在 span **外面**）和 `latency`（`<span name="latency"></span>`，独立成段）。

## 2. 本章的坑

1. **11 个 span 锚点在原文里无一带强调**——第24章已经确认过这个规律，本章沿用：
   一律不加粗。只有 `trace`（`*trace*`）、`incremental`（`**stop-the-world GC**`）
   两处 span 内有强调，`recycle` 的粗体包在 span **外面**。
2. **7 处粗体跨行**（`*throw\naway*`、`**tricolor\nabstraction**`、
   `**concurrent garbage\ncollector**`、`**Boehm–Demers–Weiser garbage\ncollector**`
   等）。按行统计强调会漏，必须先把换行替换成空格再统计。
3. **三张 `class="dot"` 小图在 `*   ` 列表项内部**，且 `class` 属性写在续行：
   ```
   *   **<img src="..." alt="A white circle."
       class="dot" /> White:** ...
   ```
   缩进与属性位置必须照抄。
4. **编号列表有嵌套**：三色标记步骤 `3.` 下面还有缩进 4 空格的 `1.` `2.`。
   `(?m)^(\d+)\.\s` 只匹配顶格项，所以序列是 `1,2 | 1,2,3 | 1,1,1`（共 8 项）。

## 3. `^code` 清单（64 个）

分七段：收集垃圾 10、调试日志 6、标记根 19、追踪引用 5、灰色对象处理 14、
清除未使用对象 6、字符串与弱引用 4。
带参数的共 34 个，重点：
`call-mark-roots (3 before, 2 after)`、`mark-open-upvalues (3 before, 2 after)`、
`free-gray-stack (2 before, 1 after)`、`exit-gray-stack (2 before, 1 after)`、
`table-remove-white-h (2 before, 2 after)`、`collect-on-next (2 before, 1 after)`、
`chunk-include-vm (1 before, 2 after)`、`concatenate-peek (1 before, 2 after)`。

## 4. 链接（4 条）

`[classes]`（`class` aside 内）、`[gc book]`（`handbook` aside 内）、
`[weak]`、`[boehm]`（`c` aside 内）。全部是英文 id，保留。

## 5. 术语

mark-and-sweep → 标记-清除；root → 根；reachable/unreachable → 可达/不可达；
conservative/precise GC → 保守式/精确式 GC；worklist → 待处理列表；
tricolor abstraction/invariant → 三色抽象/三色不变式；weak reference → 弱引用；
interning → 驻留；throughput → 吞吐量；latency → 延迟；
stop-the-world GC → 全停顿式 GC；incremental/concurrent GC → 增量式/并发式 GC；
managed language → 托管语言；generational hypothesis → 分代假设；
nursery → 苗圃；tenured → 晋升。`gray stack` → 灰栈。

## 6. 人名与语言

John McCarthy → 约翰·麦卡锡（John McCarthy）；Boehm–Demers–Weiser、Cheney、
Lisp、Ruby、Java、Fortran、Dart 原样保留。

## 7. 题词

The Whip,《Trash》——歌词已译（「我想当垃圾。」），乐队名保留英文。

## 8. 交付前自检

- [ ] aside 24 / span 24 / name 48 顺序一致，两个空 span 写成 `<span name="x"></span>`
- [ ] `^code` 64 个名称+参数逐条一致
- [ ] 分段 367 且段落类型序列零分歧
- [ ] 编号列表序列 `1,2,1,2,3,1,1,1`
- [ ] 三张 `class="dot"` 图的续行缩进原样
- [ ] **span 内粗体仅 2 处**（`trace`、`incremental`）
- [ ] 正文斜体 = 0
- [ ] 4 条链接定义齐全