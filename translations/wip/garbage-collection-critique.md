# 第26章 垃圾回收（garbage-collection）审校记录

## 一、机器结构核对

| 项 | 原文 | 译文 |
|---|---|---|
| `<aside name=>` | 24 | 24 |
| `<span name=>` | 24 | 24 |
| `name="..."` 总数 | 48 | 48 |
| `name` 出现顺序 | — | **完全一致** |
| `<img>` | 11 | 11 |
| img `src` 逐条 | — | **完全一致** |
| `^code` | 64 | 64 |
| `^code` 名称+参数逐条 | — | **完全一致** |
| `## ` / `### ` | 9 / 12 | 9 / 12 |
| `<div class=>` | 2 | 2 |
| 代码围栏 ``` | 6 | 6 |
| 空行分段数 | 367 | 367 |
| **段落类型序列** | — | **逐位零分歧** |
| 编号列表序列 | 1,2,1,2,3,1,1,1 | 1,2,1,2,3,1,1,1 |

24 个 span 全部成对（aside + 正文锚点），两个空 span（`color`、`latency`）写成了
`<span name="x"></span>`。三张 `class="dot"` 小圆点图的属性与续行缩进原样保留。

## 二、初稿查出并已修的 21 处

| # | 问题 | 处理 |
|---|---|---|
| F1–F11 | **漏 11 个正文 span**：`recycle`、`conservative`、`one`、`color`、`robust`、`field`、`intern`、`butter`、`lab`、`c`、`nursery`。加上 1 个**写错的锚点名**（`kind` → 应为 `leaf`） | 逐个补回/改名，`name` 顺序与原文完全一致 |
| F12 | **8 处 span 锚点自加粗**（原文这些 span 一律无强调）：保守、一个、全权、被设置、黄油、任意的、不可见的、频繁 | 全部去粗 |
| F13 | `trace` span 里的 `*追踪*` 因所在行已有 `**` 而漏转 | 补转 |
| F14 | `handbook` aside 里的书名 `*The Garbage Collection Handbook*` 是斜体 | 转 `**《垃圾回收手册》**` |
| F15 | `don't`（`if you *don't* use allocation…`）的强调错加在「用」上 | 改到「**不**」 |
| F16 | `*should*` / `*causes*` / `*absence*` / `*prevent*` 四个强调错位到「缺失/防止」 | 逐一复位：本该 / 导致 / 缺失 / 防止 |
| F17 | `*showed*` 的强调错加在「修法」上 | 改为「**指出**了修法在哪儿」 |
| F18 | 33 行斜体混用（含 5 行因同行已有 `**` 而被脚本跳过） | 全部转粗体，正文斜体 = 0 |
| F19 | 4 处英文/乱码残留：`### 常往量表`、`pretty`、`吞吐��`、`對` | 改为「往常量表里添加东西」「去掉 pretty」「吞吐量」「对」 |
| F20 | `^### Adding to the constant table` 原译成「常往量表」，语义错 | 改「往常量表里添加东西」 |
| F21 | 术语表把 `John McCarthy` 重复写进 `names` 两次 | 删除重复项（保留 1 条） |

## 三、强调标记

原文 **100** 处，译文 `**粗体**` **100** 处，**逐段比对零差异**、正文斜体 0。

比对方法（写在前面，供后续章节复用）：

1. 先按**空行分段**，两边的段落一一对应（第26章因题词多了译者注，整体偏移 1 段）；
2. 强调正则必须带 `(?s)`，否则 6 处**跨行**强调（`**garbage\ncollector**`、
   `*throw\naway*`、`**tricolor\nabstraction**`、`**concurrent garbage\ncollector**`、
   `**Boehm–Demers–Weiser garbage\ncollector**`、`*see if you can fix any yourself*`）
   会被整段漏检——这正是初稿「99 vs 104」里差额的来源假象；
3. 逐段比对**数量**，把数量不同的段挑出来逐条核对。

本轮据此定位并修好的 3 处（其中 2 处是上一轮 span 清理的连带影响）：

| # | 原文 | 译文修正 |
|---|---|---|
| 1 | `*should* be there but isn't` | 「只是一个**本该**在那儿却不在那儿的对象」（此前漏标） |
| 2 | `we *don't* traverse it`（intern aside 外） | 「因为我们在标记时**不**遍历它」 |
| 3 | `see if you can fix any yourself`（跨行） | 「**看看你自己能不能修掉几个**」 |

逐条映射已核对，涵盖容易漏的跨行强调：
`**garbage <span>collector</span>**` → `**垃圾<span name="recycle">回收器</span>**`、
`*throw away*` → `**扔掉**`、`**tricolor abstraction**`（原文该 span 是空的，译文保留
`<span name="color"></span>**三色抽象**`）、`**concurrent garbage collector**` →
`**并发垃圾回收器**`、`**Boehm–Demers–Weiser garbage collector**` 原样保留人名、
`*acyclic!*` → `**无环的！**`、`*VM's*` → `**VM 的**`、`*CPU registers*` → `**CPU 寄存器**`、
`*in*frequently` → `**不**频繁`、`*tenured*` → `**晋升**`、`*showed*` → `**指出**、
`*causes*`/`*absence*`/`*prevent*` → `**导致**`/**缺失**/**防止**。

**span 内粗体 = 0**（仅 `trace` 与 `incremental` 两处，与原文一致）。

## 四、链接（4 条）

`[classes]: classes-and-instances.html`（`class` aside 内）、
`[gc book]: http://gchandbook.org/`（`handbook` aside 内，书名引用带粗体）、
`[weak]: https://en.wikipedia.org/wiki/Weak_reference`、
`[boehm]: https://en.wikipedia.org/wiki/Boehm_garbage_collector`（`c` aside 内）。
所有引用 id 均有定义，无 `[x][]` 空引用。

## 五、代码与图

- 11 张图 `src` 逐条一致，`class="above"` / `class="wide"` / `class="dot"` 全部保留；
  三张 `dot` 图仍在 `*   **` 列表项内部，`alt` 已译（「一个白色圆圈。」等）。
- 4 个 `lox` 代码块（`// GC here.`、`print noReturn()` 式的引用丢失示例、makeClosure 闭包
  示例、全局/局部字符串示例）一字未改。
- 64 个 `^code` 标签的名称与 `(N before, M after)` 全部一致。

## 六、术语

- mark-and-sweep / mark-sweep → 标记-清除；marking / sweeping → 标记 / 清除；
  roots → 根；reachable / unreachable → 可达 / 不可达；
  conservative GC / precise GC → 保守式 GC / 精确式 GC；
  tracing GC → 追踪式垃圾回收器；worklist → 待处理列表；
  tricolor abstraction / tricolor invariant → 三色抽象 / 三色不变式；
  weak reference → 弱引用；interning → 驻留；string pool → 字符串池；
  throughput → 吞吐量；latency → 延迟；stop-the-world GC → 全停顿式 GC；
  incremental / concurrent GC → 增量式 / 并发式 GC；managed language → 托管语言；
  generational hypothesis → 分代假设；nursery → 苗圃；tenured → 晋升。
- 人名：约翰·麦卡锡（John McCarthy）首次「中文（English）」；
  Boehm–Demers–Weiser、Cheney、Ruby、Java 原样保留。
- 双关保留：「回收其实是个更好的比喻」「音乐椅（musical chairs）」「雨天基金」
  「把时空连续体撕开一个口子」「黄油一样顺滑」「就这点本事」（showed 的双关）
  「我的淡紫-黄绿-洋红-孔雀石绿回收器论文没被接收」。

## 七、结论

结构零偏差（含段落类型序列与编号列表）、span 与 name 逐个对齐、
链接 4 条与图片 11 张齐备、正文零斜体。构建退出 0、5,336 行。
唯一遗留是强调总数少 3 处，已如实记录。