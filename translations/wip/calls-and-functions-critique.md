# 第24章 调用和函数（calls-and-functions）审校记录

## 一、机器结构核对

| 项 | 原文 | 译文 |
|---|---|---|
| `<aside name=>` | 27 | 27 |
| `<span name=>` | 24 | 24 |
| `name="..."` 总数 | 51 | 51 |
| `name` 出现顺序 | — | **完全一致** |
| `<img>` / img `src` 逐条 | 7 | 7 / **完全一致** |
| `^code` | 81 | 81 |
| `^code` 名称+参数逐条 | — | **完全一致** |
| `## ` / `### ` | 8 / 10 | 8 / 10 |
| `<div class=>` | 1 | 1 |
| 代码围栏 ``` | 20 | 20 |
| 空行分段数 | 412 | 412 |
| **段落类型序列** | — | **逐位零分歧** |
| 编号列表序列 | 1,2,3,4 | 1,2,3,4 |

24 个 span 中只有 1 个是空的（`null`）；其余 23 个带锚点文字。
`no-end-scope`、`switch`、`minus` 三个 aside **没有对应 span**，译文也没给它们硬造锚点。

## 二、初稿查出并已修的 16 处

| # | 问题 | 处理 |
|---|---|---|
| F1–F6 | **漏 6 个 span**：`free-name`、`debug`、`static`、`nested`、`worry`、`faster`。中文删掉句首虚词后 span 变成段首，被漏掉 | 逐个补回 |
| F7 | 6 处 `*斜体*` 混用（跨 13 行） | 转 `**粗体**`，正文斜体 = 0 |
| F8 | 5 处英文残留在译文里：`实心��`、`thanks to`、`We'd`、`usefulness`、`conveniently` | 全部改中文（「同样因为递归」「理想情况下，我们会把」「也算不上多有用了」「又顺手把…存了下来」「一整块实心块」） |
| F9 | 挑战 4 被错误拆成两段，挑战 3 被错误并成一段（总数正好抵消，只数总数发现不了） | 改回：挑战 3 两段、挑战 4 一段 |
| F10 | 段落顺序错位同 F9，用「段落类型序列逐位比对」定位 | 分歧数 0 |
| F11 | ` We'd 会把 ` 被前一步替换时吃掉「把」字 → 「理想情况下，我们会 `ip` 放在…」 | 补回「把」 |
| F12 | 链接 id 断链：`[倒金字塔][]` 但定义是 `[inverted pyramid]` | 改为 `[倒金字塔][inverted pyramid]` |
| F13 | **span 锚点被系统性加粗**：本章 24 个 span 在原文里**无一带 `*` 强调**，初稿却给 21 处锚点加了粗体 | 全部去掉 |
| F14 | `**恰好**`（原「exactly the right order」无强调） | 去粗 |
| F15 | `*one*` 的强调错加在「看」上，且下一段多出一个 `**一个**`（原文无强调） | 改为「你确实得看**一个**」，删掉多余那个 |
| F16 | `**只**`（原文「we're going to add only one little native function」无强调） | 去粗 |

## 三、强调标记终态

原文 32 处斜体 + 6 处粗体 = **38 处**；译文 `**粗体**` **38 处**（含跨行的
`**返回\n地址**`，对应原文的 `**return address**`）。

逐条对应：

`already`→`**已经**`、`a *call* stack`→`**调用**栈`、`*is*`→`**确实**`、
`*runtime*`→`**运行时**`、`*declarations*`→`**声明**`、`*are*`→`**才是**`、
`*user*`→`**用户**`、`*where*`→`**哪里**`、`*within*`→`**内部**`、
`*relative*`→`**相对**`、`*Calling*`→`**调用**`、`*invocation*`→`**调用**`、
`*didn't*`→`**不**`、`*modify its own code*`→`**修改自己的代码**`、
`*not*`→`**不**`、`*guarantee*`→`**保证**`、`*have*`→`**还没有**`、
`*any*`→`**任何**`、`*surrounding*`→`**外围**`、`*typedef*`→`**typedef**`、
`*disjoint*`→`**互不重叠**`、`*caused*`→`**导致**`、`*first*`→`**最前面**`、
`*did*`→`**确实**`、`*do*`→`**任何**`、`*one*`→`**一个**`、`*calling*`→`**调用**`、
`*how*`→`**有多**`、`*require*`→`**强制**`、
`**call frame**`→`**调用帧**`、`**frame pointer**`→`**帧指针**`、
`**base pointer**`→`**基址指针**`、`**return address**`→`**返回地址**`、
`**stack trace**`→`**堆栈跟踪**`、`**native functions**`→`**原生函数**`。

span 内粗体 = 0。

## 四、链接（6 条定义 / 6 个被引用 id）

`[gc]: garbage-collection.html` **定义两次**（`free-name` aside 内 + `worry` aside 内），
照原文保留两处。`[closures]: closures.html`、`[cont]`（Wikipedia Continuation）、
`[stage]: local-variables.html#another-scope-edge-case`、`[inverted pyramid]`
（Wikipedia Inverted pyramid）各一条。

所有引用 id 都有定义，无 `[x][]` 空引用。

## 五、代码与图

- `text` 代码块（示例栈跟踪 5 行）**逐行原样**：`Expected 0 arguments but got 2.` 等
  全是程序输出，不译。
- 7 张图 `src` 逐条一致；alt 已译，其中 `argument-stack.png` 的 alt 是
  「Stack: 4, fn sum, 5, 6, 7.」保留图中的记号形式。
- `arithmetic.png` 的 alt 保留 `frame-&gt;slots` 实体。
- 8 个 `lox` 代码块（含坏调用示例 `var notAFunction = 123;`）一字未改。
- 81 个 `^code` 标签的名称与 `(N before, M after)` 全部一致。

## 六、术语

- **call frame** → 调用帧；**frame pointer** → 帧指针；**base pointer** → 基址指针；
  **return address** → 返回地址；**stack trace** → 堆栈跟踪；
  **stack window** → 栈窗口；**stack slot** → 栈槽位；**value stack** → 值栈；
  **stack semantics** → 栈语义。
- **native function** → 原生函数；**arity** → 元数；**recursive descent** → 递归下降；
  **metadata** → 元数据；**accessor** → 访问器；**continuation** → 延续；
  **inverted pyramid** → 倒金字塔；**register**（C 关键字）保留。
- 人名首次「中文（English）」：大卫·惠勒（David Wheeler）。
- 语言/运行时名保留：C、Lua、Fortran、Ruby、Python、C#、JavaScript、JVM。
- 双关保留：「吃——也就是『消耗』——用来比喻一个创造性的动作，本身就挺怪」、
  「穷人版的面向对象」、「天才与疯狂之间只隔着一根头发丝」、
  「差不多有点让人失望」、「看起来我们几乎像是知道自己在干什么」。

## 七、标题

`## 函数对象`、`## 编译成函数对象`、`### 在编译期创建函数`、`## 调用帧`、
`### 分配局部变量`、`### 返回地址`、`### 调用栈`、`## 函数声明`、
`### 一栈编译器`、`### 函数形参`、`## 函数调用`、`### 把实参绑定到形参`、
`### 运行时错误检查`、`### 打印堆栈跟踪`、`### 从函数返回`、`## Return 语句`、
`## 原生函数`、`## 挑战`。

## 八、结论

结构零偏差（含段落类型序列）、强调 38/38 精确对应、链接 id 全部可解析、
7 张图与 81 个代码标签齐备。可进入构建。