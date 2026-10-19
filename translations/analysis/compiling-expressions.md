# 第17章《编译表达式》译前分析

## 3.1 内容与作者

- **讲什么**：clox 的编译器（compiler 模块）——把「扫描 → 编译 → 执行」流水线补全。
  单遍编译思想；解析词法单元（advance/consume/错误上报 + panic 模式）；发射字节码
  （emitByte/emitConstant/常量表）；前缀表达式（number、grouping、unary）；
  中缀表达式（binary）；核心 **Pratt 解析器**（parsePrecedence、ParseRule 表、getRule）；
  最后加 `--print-code` 转储字节码。
- **作者意图**：本章是全书「三个理由」的爽点：补全流水线、写一个真正的编译器、
  展示作者最爱的 Pratt 算法。为后续所有「往表里塞新解析函数」的章节立骨架。
- **钩子**：开头承接第16章的临时 dump-tokens 脚手架（拆掉）；结尾「我们现在有了一个
  极其过度设计的算术计算器」，预告后面加语言特性。设计说明《说到底就是解析》表达
  「解析不重要，错误信息才重要」的观点。

## 3.2 术语预判（对照 glossary）

| 英文 | 定译 | 备注 |
|---|---|---|
| single-pass compilation / pass | 单遍编译 / 遍 | 新增 |
| code generator | 代码生成器 | 新增 |
| top-down operator precedence parsing | 自顶向下运算符优先级解析 | 新增（Pratt 算法全称）|
| Pratt parser | Pratt 解析器 | 已有 |
| prefix / infix / postfix / mixfix expression | 前缀 / 中缀 / 后缀 / 混合（mixfix）表达式 | 新增 |
| precedence | 优先级 | 已有 |
| associativity / left-associative | 结合性 / 左结合 | 已有 |
| function pointer | 函数指针 | 新增 |
| typedef | typedef（保留） | keep_english |
| designated initializer | 指定初始化器 | 新增 |
| forward declaration | 前置声明 | 新增 |
| panic mode / error recovery | panic 模式 / 错误恢复 | 已有 |
| cascaded errors | 连锁错误 | 已有 |
| sentinel / EOF token | 哨兵值 / EOF 词法单元 | 已有 |
| peephole | 窥孔式 | 新增 |
| parser generator / compiler-compiler | 语法解析器生成器 / 编译器-编译器 | 已有/新增 |
| parser combinators / packrat parser | 解析器组合子 / 记忆化解析（packrat parsing） | 已有 |
| over-engineered | 过度设计 | 已有 |
| compile / compiler / emit | 编译 / 编译器 / 发射 | 已有/「emit」新增译「发射」|
| constant table | 常量表 | 已有 |
| ParseRule / ParseFn / Parser | 保留原样，正常字体 | style guide |
| LALR / ANTLR / Bison / Yacc / PDP-11 | 保留 | 工具/机型 |

人名音译：Dante Alighieri→但丁·阿利吉耶里；Niklaus Wirth→尼克劳斯·维尔特（已有）；
Vaughan Pratt→沃恩·普拉特（已有）。
书名：*Inferno* →《地狱篇》。

## 3.3 语域判断

**动手为主 + 强叙述**，`^code` 45 处；章首「三个理由」和 Pratt 算法段是全书最热情的文字之一。
幽默/比喻密集：

- L6–29「三个理由」开场；「货真价实的编译器」「真正的语言黑客」
- L20 旁注：Wirth 的「江湖地位」
- L33–40 旁注：Pratt 算法在业界「口耳相传」的段子（"Oh, I worked on this compiler years ago…"）
- L44「先吃蔬菜，才轮到甜点」
- L125 旁注：passes 排序「介于公开研究领域和玄学之间」
- L232 旁注：setjmp 会让人「倒霉透顶」
- L276「难以相信伟大的东西会流经这么简单的函数」
- L338「四则运算的天启四骑士」
- L716 旁注：rules 表是「一头怪兽」
- L764 旁注：「把虚拟机写在为 PDP-11 编译的 C 里就会这样」
- L926–935 旁注：编译器人的锤子/钉子；「让我们写个编译器来写编译器」
- 结尾「极其过度设计的算术计算器」

## 3.4 翻译难点清单

| 类别 | 原文 | 处理 |
|---|---|---|
| 引用 | 但丁《地狱篇》开篇 | 多个中译（王维克等），无法核对确切字句→忠于所给英译直译；见下 |
| 比喻 | `eat your vegetables before dessert` | retain：先吃蔬菜，才轮到甜点 |
| 比喻 | `honest-to-God compiler` | 货真价实的编译器 |
| 习语 | `street cred` | 江湖地位 |
| 比喻 | `primes the pump` | interpret：给扫描器「引了引水」 |
| 比喻 | `peephole view` | 窥孔式的局部视角 |
| 比喻 | `smoke and mirrors` | 障眼法 |
| 成语 | `when all you have is a hammer…` | substitute：手里只有锤子，看什么都像钉子 |
| 比喻 | `go off in the weeds` | 跑到草丛里迷失方向 |
| 习语 | `keep on trucking` | 沿用 ch6：继续一路开下去 |
| 习语 | `Very Bad Day` | 倒霉透顶的一天 |
| 习语 | `oral tradition` | 口耳相传的传统 |
| 习语 | `mind meld` | 心心相印/与……神交：和沃恩·普拉特神交 |
| 双关/文化 | `Four Horsemen of the Arithmetic` | interpret：四则运算的「天启四骑士」 |
| 词 | `*-fix*` / `mixfix` | 保留「-fix」；混合表达式（mixfix） |
| 结构 | 程序输出、`print -` 多行示例 | 代码/输出不动 |
| 结构 | `<img>` alt 全译 | 含 aside 内 calls/points-to 两个箭头图 |
| 结构 | ASCII 数字 `256` 作 span name | 原样保留 |

## 3.5 结构基线（待机器校验）

- asides：wirth / pratt / blog / passes / lox / setjmp / 256 / recursive / line / useful /
  higher / prefix / typedef / big / forward / connections / yacc = **17**
- spans：同上去掉 big = **16**
- img：pipeline / keyhole / mystery / connections / calls / points-to = **6**
- `^code` **45**；`## ` **9**（含设计说明）、`### ` **5**；challenges + design-note 两个 div
- 链接：globals / bytecode / next / blog / 无其它外链（多为 Wikipedia 无）
