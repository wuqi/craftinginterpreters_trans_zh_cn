# 第24章 函数（functions）审校记录

## 一、机器结构核对（脚本比对）

| 项 | 原文 | 译文 |
|---|---|---|
| `<aside name=>` | 20 | 20 |
| `<span name=>` | 18 | 18 |
| `name="..."` 总数 | 38 | 38 |
| `name` 出现顺序 | — | **完全一致** |
| `<img>` | 7 | 7 |
| `^code` | 33 | 33 |
| `^code` 名称+参数逐条 | — | **完全一致** |
| `## ` / `### ` | 7 / 7 | 7 / 7 |
| `<div class=>` | 1 | 1 |
| 代码围栏 ``` | 44 | 44 |
| 空行分段数 | 296 | 296 |

## 二、初稿查出并已修的 3 处

| # | 问题 | 处理 |
|---|---|---|
| F1 | 漏了 `print` span。原文「a program that reads and `<span name="print">displays</span>` a file」里的 `displays` 被译成裸粗体，锚点丢失 | 补成 `<span name="print">**显示**</span>` |
| F2 | 漏了 `exception` span。原文 `for <span name="exception">control flow</span>` 的锚点丢失 | 补成 `用于<span name="exception">**控制流**</span>` |
| F3 | 首段出现 `< span` 多余空格；题词里给 `compounding` 加了原文没有的「（compound）」注释 | 一律修正 |

修完后 span 数 16→18、name 数 36→38，与原文完全对齐。

## 三、`while-true` 与 `in-order` 两个「只有 aside 没有 span」的特例

原文 `name=` 共 38 个，其中 `while-true`、`in-order` 各只出现 1 次（只有 aside），
其余 18 个 name 各出现 2 次。**这两处不能补 span**，否则 name 数会变成 40。
译文 span 数 18、name 数 38，与原文的「19 对 + 2 个单例」结构吻合。

## 四、强调标记

原文 34 处斜体 + 16 处粗体 = 50 处，译文粗体项 **50 个**，逐一对应：

`被调用者（callee）`、`优先级`、`就是`、`另`、`至少`、`不超过`、`25**4**`、`报告`、`抛出`、
`完全可以`、`用户`、`自己`、`自己`、`当前`、`声明语句`、`元数`、`柯里化（currying）`、
`原型函数`→`原生函数`、`primitive`、`external function`、`foreign function`、
`外部函数接口`、`FFI`、`原生扩展`、`原生接口`、`基准测试`、`当前`、`局部函数`、
`调用`、`声明`、`代码`、`调用`、`封装`、`语法节点`、`也`、`出`、`某样东西`、
`存在`、`不存在`、`父`、`任何地方`、`声明`、`调用`、`闭包`、`控制流`、`显示`、
`匿名函数`、`lambda`、`同一个`、`应该`。

译文中除 `**` 外无单星号残留（唯一的单星号是 curry aside 里的行内代码 `` `*` ``）。

## 五、链接（7 条定义 / 6 类引用）

| 引用处 | 定义 |
|---|---|
| `[附录二][appendix-call]` | `appendix-ii.html#call-expression`（在 `call-ast` aside 内） |
| `[第三部分][]` ×2 | `a-bytecode-virtual-machine.html`（独立成段） |
| `[附录二][appendix-fun]` | `appendix-ii.html#function-statement`（在 `fun-ast` aside 内） |
| `[讲语句和状态的那一章][statements]` | `statements-and-state.html`（独立成段） |
| `[下一章][]` ×3 | `resolving-and-binding.html`，**定义出现两次**：`env` aside 内一次 + 全文末尾一次，与原文一致 |
| `[附录二][appendix-return]` | `appendix-ii.html#return-statement`（在 `return-ast` aside 内） |

无 `[x][]` 空引用。

## 六、代码逐字核对

- `text` 代码块（Java 调用栈 8 行）**一字未改**，脚本已校验逐行匹配。
- 6 个 `ebnf` 块：`→`、`|`、`?`、`*`、`"..."`、`;`、缩进全部原样，无一处被"顺手修正"。
- `add(1, 2, 3, 4); // 太多了。` / `add(1, 2);       // 太少了。` ——散文注释译中文，
  **行内对齐空格保留**。
- 预期输出注释一律不译：`// "<fn add>".`、`// "1".`、`// "2".`、`// "3".`、`// ?`、
  `// <--`。
- `img` 标签 `class="above"` 属性保留（`foreign.png` 那一处）。
- 7 张图 alt 已译，src 全部未改。

## 七、术语与人名

沿用 `glossary.zh.json`：元数（arity）、形参、实参、闭包、原生函数、基准测试、
命名空间、优先级、副作用、外部函数接口、柯里化（currying）、匿名函数、标识符、绑定。

本章新增决定：

- **callee 首次出现给「被调用者（callee）」**，因为代码里会出现 `asLoxCallable(callee)`。
- **primitive / external function / foreign function 保留英文**。这三个是同一类东西的
  三种英文叫法；若全译成中文就分不出彼此，且随后的 `native` aside 专门讲
  native 与 foreign 的对立，保留英文才能对上。
- 「元数」而非「元」——`元` 单字在中文里不成词，且规则明令单字形容词/术语不能只译一字。
- 人名首次出现用「中文（English）」：道格拉斯·霍夫施塔特、哈斯克尔·柯里、
  理查德·加布里埃尔、肯特·皮特曼、彼得·兰丁。

## 八、双关与难点

- **柯里化**：哈斯克尔·柯里的**名**出现在 Haskell 这门语言里，原文 `*other*` 强调的
  就是这个「另」。译文保留了「就是那位名字出现在**另**一门著名函数式语言里的人物」，
  读者能看出双关。
- **Methods are too classy to have fun.** → 「方法太有腔调了，fun 不起。」保留 classy/fun
  的字面联系，锚点 `fun` 在前文的 `` `fun` `` 上。
- **The Hotel California of data.** → 「数据的加州旅馆。」锚点在「取**出**来」上，
  与原文明文一样，斜体 `*out*` 落在 span 内部。
- **`reports` vs `throw`**：第 5 节是全章考点，分别用「**报告**」和「**抛出**」，
  绝不含混。
- **`25*4*`**：只给 `4` 加粗，不能写成 `25×4`。
- **fib 例子行尾 `// <--`**：原样保留，它是指向 `return n` 的排版标记。

## 九、结论

结构零偏差（aside 20 / span 18 / name 38 顺序一致 / `^code` 33 全对 / 围栏 44 /
分段 296），3 处缺陷已修，50 处强调全数落位，7 条链接与 7 张图齐备。可进入构建。