# 第24章 函数（functions）译前分析

## 1. 章节定位

jlox 收官章：把表达式、语句、变量、控制流、词法作用域拼成**用户定义函数**，
并首次引入原生函数、`return`、闭包。本章是后面 clox 章节的对照基准。

## 2. 结构基线（脚本核对）

| 项 | 数量 |
|---|---|
| `<aside name=>` | 20 |
| `<span name=>` | 18 |
| `name="..."` 总数 | 38 |
| `<img>` | 7 |
| `^code` | 33 |
| `## ` | 7 |
| `### ` | 7 |
| `<div class=>` | 1 |
| 空行分段数 | 296 |

**19 个 name 各出现两次**（aside + span）：lambda、pascal、curry、call-ast、254、
callable、native、print、lisp-1、name、fun、fun-ast、env、hotel、return-ast、
exception、slow、closure。

**只有 aside 没有 span 的 2 个**：`while-true`、`in-order`。
所以「span 数 = 18」而不是 20——这两处不要硬造 span，也不要把 aside 写成有锚点的形式。

## 3. `^code` 清单（33 个，参数一字不改）

`call-expr (1 before, 1 after)`、`unary-call (3 before, 1 after)`、`call`、`finish-call`、
`check-max-arity (1 before, 1 after)`、`import-array-list (1 after)`、`visit-call`、
`callable`、`check-is-callable (2 before, 1 after)`、`check-arity (1 before, 1 after)`、
`callable-arity (1 before, 1 after)`、`global-environment (2 before, 2 after)`、
`interpreter-constructor (2 before, 1 after)`、`function-ast (1 before, 1 after)`、
`match-fun (1 before, 1 after)`、`parse-function`、`parse-parameters (1 before, 1 after)`、
`parse-body (1 before, 1 after)`、`lox-function`、`function-call`、`function-arity`、
`function-to-string`、`visit-function`、`return-ast (1 before, 1 after)`、
`match-return (1 before, 1 after)`、`parse-return-statement`、`visit-return`、
`return-exception`、`catch-return (3 before, 1 after)`、`closure-field (1 before, 1 after)`、
`closure-constructor (1 after)`、`visit-closure (1 before, 1 after)`、
`call-closure (1 before, 1 after)`

## 4. 链接（7 条定义，注意 `next chapter` 出现两次）

| 定义 | 目标 | 位置 |
|---|---|---|
| `[appendix-call]` | `appendix-ii.html#call-expression` | `call-ast` aside 内 |
| `[part iii]` | `a-bytecode-virtual-machine.html` | 「最大实参数」段末（独立成段） |
| `[appendix-fun]` | `appendix-ii.html#function-statement` | `fun-ast` aside 内 |
| `[statements]` | `statements-and-state.html` | 「函数对象」节末（独立成段） |
| `[next chapter]` | `resolving-and-binding.html` | **`env` aside 内一次 + 全文末尾一次** |
| `[appendix-return]` | `appendix-ii.html#return-statement` | `return-ast` aside 内 |

**两处 `[next chapter]` 定义重复出现，必须都保留**，不要合并。

正文引用写法：`[Part III][]`、`[Part III][part iii]`（原文混用两种，都照抄）、
`[the chapter on statements and state][statements]`、`[next chapter][]`、
`[Appendix II][appendix-call]`。

## 5. 图片（7 张）

`lambda.png`（在 `lambda` aside 内）、`foreign.png`（在 `native` aside 内，带
`class="above"` 属性，属性原样保留）、`recursion.png`、`binding.png`、`global.png`、
`body.png`、`closure.png`。alt 译中文，src 与 class 属性一字不动。

## 6. 强调清单（34 处斜体 + 15 处粗体）

斜体逐条（行号 → 译法）：
`high precedence`→`**优先级**高`；`is`→`**就是**`；`other`→`**另**一个`；
`at least`→`**至少**`；`no more than`→`**不超过**`；`4`（在 `25*4*` 里）→`25**4**`；
`reports`→`**报告**`；`throw`→`**抛出**`；`could`→`**完全可以**`；`user`→`**用户**`；
`own`→`**自己**`（2 处）；`current`→`**当前**`；`declaration statement`→`**声明语句**`；
`encapsulates`→`**封装**`；`call`→`**调用**`（2 处）；`declaration`→`**声明**`；
`code`→`**代码**`；`invocation`→`**调用**`；`syntax node`→`**语法节点**`；
`also`→`**也**`；`out`→`**出**来`；`something`→`**某样东西**`；
`present`→`**存在**`；`absent`→`**不存在**`；`parent`→`**父**`；
`anywhere`→`**任何地方**`；`declared`→`**声明**`；`called`→`**调用**`；
`same`→`**同一个**`；`should`→`**应该**`。

粗体：`callee`、`currying`、`arity`、`native functions`、`primitives`、
`external functions`、`foreign functions`、`foreign function interface`、`FFI`、
`native extension`、`native interface`、`benchmarks`、`local functions`、
`closure`、`anonymous functions`、`lambdas`。

**注意 `native functions` 同时出现在一个跨行 span 里**（`<span\nname="native">**native functions**</span>`），
中文写作 `<span name="native">**原生函数**</span>`，锚点文字保留。

## 7. 必须逐字保留的代码

- `lox`：`average(1, 2);`、`getCallback()();`、`"totally not a function"();`、
  `fun add(a, b, c) {...}`、`add(1, 2, 3, 4); // Too many.`、
  `add(1, 2);       // Too few.`（**注释要译**：「太多了。」「太少了。」，
  但对齐空格保留）、`var add = fun (a, b) {...};`、`fun procedure() {...}`、
  `print result; // ?`、`return nil;`、`fun count(n)` 递归例、`fun fib(n)` 例、
  `fun sayHi(...)` 例（输出串 `"Hi, " + first + " " + last + "!"` 保留）、
  `print add; // "<fn add>".`、makeCounter 例（注释 `"1".` `"2".` 保留）、
  挑战里的 `thrice(fn)` 与 `fun () {};`。
- `ebnf`：6 个代码块（unary/call、arguments、declaration、funDecl/function、
  parameters、statement/returnStmt）。箭头 `→`、`|`、引号、分号、`*`、`?` 全不动，
  右侧无中文说明，只译正文散文。
- `text`：Java 调用栈 8 行，**一字不改**（`Interpreter.visitReturnStmt()` 等）。
- `// See if...` 之类注释：仅 lox 块里的 `// Too many.` 等需要译。

## 8. 术语与人名

沿用 `glossary.zh.json` 既有译法：

- arity → 元数（arity）；parameter → 形参；argument → 实参；closure → 闭包；
  native function → 原生函数；benchmark → 基准测试；namespace → 命名空间；
  precedence → 优先级；side effect → 副作用；FFI → 外部函数接口；
  currying → 柯里化（currying）；anonymous function → 匿名函数；identifier → 标识符。
- receiver → 接收者；callee → 被调用者；caller → 调用方；callee 粗体保留。
- syntactic sugar → 语法糖；primary expression → 基本表达式；
  infix / postfix operator → 中缀 / 后缀运算符；first-class value → 一等值；
  unwind → 退栈；stack trace → 堆栈跟踪；dynamic scoping → 动态作用域；
  microbenchmark → 微基准测试；Lisp-1 / Lisp-2 保留。

人名首次出现用「中文（English）」：
Douglas R. Hofstadter → 道格拉斯·霍夫施塔特；I Am a Strange Loop → 《我是一个奇异的环》；
Haskell Curry → 哈斯克尔·柯里；Richard P. Gabriel → 理查德·加布里埃尔；
Kent Pitman → 肯特·皮特曼；Peter J. Landin → 彼得·兰丁。

语言名一律保留：C、Java、JavaScript、Python、Lisp、Scheme、Common Lisp、
Pascal、ML、Smalltalk、Lox、jlox、clox。

## 9. 翻译难点

1. **`25*4* arguments`**：`4` 带斜体强调 → 写 `25**4** 个实参`，不要写成 `25×4`。
2. **curry aside**：Haskell Curry 的名字被拿来命名「柯里化」，而他的**名**又出现在
   另一门函数式语言的名字里（the *other* well-known functional language = Haskell）。
   `other` 带强调 → `**另**一个`。译时要让读者看得出这是双关。
3. **Methods are too classy to have fun.**：双关（classy / fun）。译
   「方法太有腔调了，玩不起 fun。」保留 `fun` 与 `classy` 的联系。
4. **The Hotel California of data.**：`hotel` span + 「数据的加州旅馆」。
5. **`fun()` 拼贴**：`<span name="fun">\`fun\`</span>` 锚点在「不以 `fun` 开头」处。
6. **fibonacci 递归示例**：行末 `// <--` 注释保留原样（指向 `return n` 的箭头）。
7. **`throws` vs `reports`**：第 5 节讲 `check-max-arity` 时区分 `*reports*` 与 `*throw*`，
   中文必须分别用「报告」和「抛出」，这是全章的一个考点。
8. **jumped the gun**：原文没写，别加。原文用 `start off first with...`、`oddly familiar`。

## 10. 交付前自检

- [ ] 20 aside / 18 span / 38 个 name 且顺序一致
- [ ] `while-true`、`in-order` 两个 aside 无 span
- [ ] 33 个 `^code` 名称+参数一致
- [ ] 7 张图 src（含 `class="above"`）不变、alt 已译
- [ ] 7 条链接定义全在，`[next chapter]` 两处重复定义都保留
- [ ] `text` 代码块 8 行未改
- [ ] 34 斜体 + 15 粗体全部落为 `**`
- [ ] 段落数 296 与原文一致