# 第16章《按需扫描》译前分析

## 3.1 内容与作者

- **讲什么**：clox 前端的起步。把 `main()` 改造成 REPL + 脚本加载；新增 `scanner`、`compiler`
  两个模块骨架；讲解按需扫描（一次一个词法单元）的设计动机；完整的字符扫描（单/双字符标点、
  空白、注释、数字、字符串、标识符）；最后用嵌套 switch + 字典树思路识别关键字。
- **作者意图**：先完成「扫 → 编译 → 执行」这条流水线的第一环（扫描），为第17章编译表达式铺路。
  章首明说本章「不是最激动人心」，但暗藏几处与 jlox 的差异（按值返回词法单元、错误词法单元、
  不转换字面量）。
- **钩子**：开头承接第14–15章的 chunk/VM（「从接近末尾的地方起步，现在跳回开头」）；
  结尾「我们的扫描器完成了」，下一章用编译器把两头接上。

## 3.2 术语预判（对照 glossary）

| 英文 | 定译 | 备注 |
|---|---|---|
| scanner | 扫描器 | 已有 |
| token | 词法单元 | 已有 |
| lexeme | 词素 | 已有 |
| scanning | 扫描 | 已有 |
| lexical grammar | 词法文法 | 已有 |
| lookahead | 前瞻 | 已有 |
| reserved word | 保留字 | 已有 |
| identifier | 标识符 | 已有 |
| whitespace | 空白 | 已有 |
| exit code | 退出码 | 已有 |
| sentinel | 哨兵值 | 已有 |
| hash table | 哈希表 | 已有 |
| regular expression | 正则表达式 | 已有 |
| trie | **字典树（trie）** | 新增。读音梗的一段保留英文 "Trie" |
| deterministic finite automaton / DFA | 确定性有限自动机（DFA） | 新增 |
| finite state machine | 有限状态机 | 已有 |
| state machine | 状态机 | 新增 |
| syntax diagram / railroad diagram | 语法图 / 铁路图 | 新增 |
| string interpolation | 字符串插值 | 新增 |
| contextual keyword | 上下文关键字 | 新增 |
| compilation pipeline | 编译流水线 | 新增 |
| REPL | REPL | 保留英文（keep_english） |
| compile / compiler | 编译 / 编译器 | 已有 |
| bytecode chunk / VM | 字节码块 / 虚拟机 | 已有 |
| Token / Scanner / Value | 保留原样，正常字体 | style guide |

人名音译：Kurt Vonnegut→库尔特·冯内古特；Edward Fredkin→爱德华·弗雷德金。
书名：*Like Shaking Hands With God: A Conversation about Writing* →《与上帝握手：一场关于写作的对话》
（查过，无通行中译本，直译；`<em>` 按既有约定转《》、不加粗，见 ch15 先例）。

## 3.3 语域判断

**动手为主**，`^code` 46 处，叙述夹在代码之间。幽默/比喻集中处：

- 章首自嘲「这不是全书最激动人心的一章」
- 「把 REPL 支起来，让它 REPL 起来」（get the REPL up and REPL-ing）
- 「嗯——要寒酸一些」（more, ahem, austere）
- 「吃蔬菜、用牙线一样」（like eating our vegetables or flossing）
- 「穿到草丛里」（off in the weeds）
- 「老好人 printf() 都可能失败」
- 旁注：墨西哥钝口螈的照片（「这一段相当枯燥」）
- 「它算是一个独立的小型扫描器」
- 「那坨代码」（that blob of code）
- 结尾旁注：性能来自「少做点工作」

## 3.4 翻译难点清单

| 类别 | 原文 | 处理 |
|---|---|---|
| 双关/文字游戏 | `get the REPL up and REPL-ing` | 造词：把 REPL 支起来，让它 REPL 起来 |
| 比喻 | `like eating our vegetables or flossing` | retain：像吃蔬菜、用牙线一样 |
| 习语 | `off in the weeds` | interpret：钻得太深 |
| 比喻 | `chews through the user's source code` | retain：一路啃着源代码 |
| 比喻 | `runner crouched at the starting line` | retain：蹲在起跑线上的赛跑选手 |
| 习语 | `starting gun went off` | 发令枪一响 |
| 词 | `ahem, austere` | 嗯——寒酸（避免与 naive「朴素」撞车） |
| 拟声 | `blob of code` | 那坨代码 |
| 术语读音梗 | aside `Trie` 的 tree/try 读音段 | retain 英文 "Trie"，整段照译 |
| 结构 | L260–267 程序输出 `1 31 'print'…` | 程序输出**不译**，原样保留 |
| 结构 | `%.*s`、`WAKE_UP` 等代码段 | 代码不动 |
| 结构 | `<img>` alt 全部翻译 | |
| 长难句 | L82–85「readFile 花的力气比看起来多」 | 拆句 |
| 引用 | 章首冯内古特 | 无中译本，直译 + 出处 |

## 3.5 结构基线（待机器校验）

- asides：args / owner / one / printf / fields / token / outlive / axolotl / convert / hash /
  down / trie / railroad / regex / v8 / short = **16**
- spans：args / one / printf / fields / token / outlive / axolotl / convert / hash /
  down / trie / railroad / regex / v8 / short = **15**（其中 `fields`、`down`、`axolotl`、
  `railroad` 为空 span）
- img：pipeline / fields / axolotl / keywords / numbers = **5**
- challenges div：1；`^code` 标签 46（含 `dump-tokens`、`keywords`、`keyword-f`、`keyword-t`）
- 链接：chunks / vm / next chapter / global? / hash / dragon / v8 / trie / dfa / state /
  syntax diagram / lex / interp
