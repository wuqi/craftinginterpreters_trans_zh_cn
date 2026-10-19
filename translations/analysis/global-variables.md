# 第21章《全局变量》译前分析

## 3.1 内容与作者

- **讲什么**：给 clox 加上变量支持（先只做全局）。为新编译器补上语句（`print`、表达式语句）、
  错误同步（panic 模式落地）；变量声明（`var`、常量表存名字、`OP_DEFINE_GLOBAL`）、
  读取（`OP_GET_GLOBAL`）、赋值（`OP_SET_GLOBAL`）；末尾用优先级标志 `canAssign`
  修掉「`a * b = c + d` 被误解析」的坑，并给所有解析函数加参数。
- **作者意图**：接续第20章哈希表，把「按名字查值」真正用起来；为第22章局部变量铺路
  （本章特意指出局部可用更高效的策略）。章首明说本章「没那么多智识架子，只是一把工程活」。
- **钩子**：开头承接哈希表、预告局部变量；结尾「像真有门真实语言的代码了」。

## 3.2 术语预判（对照 glossary）

| 英文 | 定译 | 备注 |
|---|---|---|
| global variable | 全局变量 | 已有 |
| local variable | 局部变量 | 已有 |
| late bound | 晚绑定 | 新增 |
| statement | 语句 | 已有 |
| declaration | 声明 | 已有 |
| expression statement | 表达式语句 | 已有 |
| variable declaration | 变量声明 | 已有 |
| stack effect | 栈效应 | 新增 |
| panic mode | panic 模式 | 已有 |
| synchronization | 同步 | 已有 |
| cascaded compile errors | 连锁编译错误 | 已有（连锁错误）|
| desugar | 脱糖 | 已有 |
| implicit variable declaration | 隐式变量声明 | 已有 |
| constant table | 常量表 | 已有 |
| assignment | 赋值 | 已有 |
| getter / setter | getter / set 表达式 | 沿用 ch17 约定 |
| lookahead | 前瞻 | 已有 |
| precedence | 优先级 | 已有 |
| mutually recursive | 相互递归 | 新增 |
| meta-strategy | 元策略 | 新增 |
| zombie value | 僵尸值 | 新增 |
| l-value 无关 | — | |

人名音译：Daphne du Maurier→达芙妮·杜穆里埃。
书名：*Rebecca* →《蝴蝶梦》（通译）。

## 3.3 语域判断

**动手为主 + 叙述**，`^code` 54 处。幽默/比喻：

- 章首「这一章没那么多智识架子」
- 旁注：`helpers all the way down`「一层套一层，全是 helper」
- 旁注：`short verb-named functions` 让解析器更好读
- 「让语言在编程语言**展览会**上得奖」（4H 农场展览会的脑补：一排排铺草的展位，
  小语言们互相 `moo`、`baa`）
- 旁注：`a * b` 当赋值目标的脑补，「那大概率是个糟糕的主意」
- 「一堆苦力活」（grunt work）
- 「是不是开始像一门真实语言的代码了」

## 3.4 翻译难点清单

| 类别 | 原文 | 处理 |
|---|---|---|
| 引用 | 章首 du Maurier | 有通译→《蝴蝶梦》，直译引文 |
| 比喻 | `helpers all the way down` | retain：一层套一层，全是 helper |
| 比喻 | `earns its keep` | 「对得起自己的存在」|
| 比喻 | `language fair / 4H` | retain 意象：编程语言的「展览会」；`moo`/`baa` 拟声保留 |
| 习语 | `arm ... at the fair` | 让语言在展览会上得奖 |
| 习语 | `grunt work` | 苦力活 |
| 习语 | `a dash of` | 撒一把 |
| 习语 | `take a gander` | 瞧一眼 |
| 比喻 | `road to a fast VM` | 通向快虚拟机的路 |
| 代码注释 | `// Error.`（lox 块内） | 译「// 错误。」（沿用 ch15 手写块注释译法）|
| 结构 | `ast-good`/`ast-bad`/`setter` 图 | alt 翻译 |
| 结构 | `class="bottom"`（nil）、`build` 无关 | 保留属性 |

## 3.5 结构基线（待机器校验）

- asides 16：different/parens/turtles/read/effect/return/majority/fair/nil/helper/pop/
  tear/jlox/delete/do/index（delete 仅 aside，无 span）
- spans 15、img 4（stack-effect/setter/ast-good/ast-bad）、`^code` 54、
  `## ` 5、`### ` 3、div 1
- 链接：hash / next chapter / functions / errors / implicit
