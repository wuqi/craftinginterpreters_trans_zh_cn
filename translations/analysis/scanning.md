# 第 4 章「扫描」译前分析

## 1. 内容与作者意图

- **讲什么**：从零搭一个词法扫描器，把字符流切成词素，再打包成词法单元。顺带搭
  jlox 的骨架（主类、REPL、错误报告），再一路做完整形语言的全部词法。
- **核心论点**：扫描器本身不难（一个有点野心的 switch），但它是理解"词法单元
  为什么这样切"的入口——maximal munch、lookahead、正则语言这些都是概念。
- **作者在干什么**：这是**第一个真正的章节**，所以花大量篇幅搭脚手架，并且在代码之间
  反复插科打诨，替读者调节节奏（"baby steps, you know?"）。
- **承接**：接导言。本章产出 Scanner，下一章接解析器。
- **钩子**：Design Note 讲隐式分号——Bob 认为该书不适合塞这段，单独拎出来。

## 2. 术语预判

| 英文 | 译法 | 状态 |
|---|---|---|
| scanner | 扫描器 | 表内 |
| scanning / lexing | 扫描 / 词法分析 | 表内 |
| token | 词法单元 | 表内 |
| lexeme | 词素 | 表内 |
| maximal munch | **最长匹配(maximal munch)** | 表内新增 |
| lookahead | **前瞻(lookahead)** | 表内新增 |
| reserved word | **保留字** | 表内新增 |
| identifier | **标识符** | 表内新增 |
| lexical grammar | **词法文法** | 表内新增 |
| regular language | **正则语言** | 表内新增 |
| regular expression | 正则表达式 | 表内已有 |
| finite-state machine | **有限状态机** | 表内新增 |
| automatic semicolon insertion | **自动分号插入** | 表内新增 |
| statement terminator | **语句终止符** | 表内新增 |
| exit code | **退出码** | 表内新增 |
| whitespace | **空白** | 表内新增 |
| escape sequence | **转义序列** | 表内新增 |
| over-engineered | **过度设计** | 表内新增 |
| bare bones | **最简版 / 骨架** | 表内新增 |
| plenary（无） | — | — |

**保留不译**：REPL、Lex、Flex、Java、IDE、Makefile、sysexits.h、Devanagari、Lua、Go、
Python、JavaScript、CoffeeScript、BASIC、Eric Schmidt、Chomsky、dragon book

## 3. 语域判断

- 偏动手，但**闲聊密度全书最高**的一章。脚手架部分（第 33–190 行）几乎每段都在调侃。
- 幽默密集区：
  - L26-31 "a `switch` statement with delusions of grandeur"
  - L51-52 "Stick that in a text file... I'll be right here when you're ready. Good? OK!"
  - L91-93 "baby steps, you know?"
  - L116 "there's only so much ink in the pen"
  - L142-146 "please do as I say and not as I do"
  - L284-285 "eating characters and, occasionally, uh, excreting tokens"
  - L287-295 lexigator 鳄鱼梗
  - L338-341 Eric Schmidt 亿万富豪梗
  - L348-349 "We're about handcrafted goods"（about 是名词）
  - L433-434 "Syntax error Whac-A-Mole"
  - L439-446 shotgun 梗
- 自嘲/吐槽：L614-617 Devanagari 数字、L652-653 面试复习、L885-889 "design diatribe"

## 4. 翻译难点清单

### 4.1 Comprehension gaps

| 位置 | 落差 | 处理 |
|---|---|---|
| L41-49 `sysexits.h` | UNIX 退出码约定，中文读者未必见过 | retain 头文件名，正文说明「UNIX 里的 sysexits.h」 |
| L62-77 REPL 旁注 | 缩写怎么来的 | retain REPL，旁注解释 Read-Evaluate-Print-Loop |
| L287-295 lexigator | 造词梗，图里是鳄鱼吃字符 | **retain** 英文 + 中文保留鳄鱼意象 |
| L615-621 Devanagari | 天城文数字 | retain「天城文（Devanagari）数字」，比生造词清楚 |
| L675-710 maximal munch | 概念本身 | substitute「最长匹配」，首现标英文 |

### 4.2 Figurative language（比喻 / 双关）

| 原文 | 机制 | 处理 | 译法 |
|---|---|---|---|
| "a `switch` statement with delusions of grandeur" | switch 想当大人物 | interpret | 一个有点**妄图**宏大的 `switch` 语句 |
| "Stick that in a text file... Good? OK!" | 老师布置完作业催你 | interpret | 把它扔进一个文本文件，然后……我就坐在这儿等你了。好了吗？好！ |
| "baby steps, you know?" | 学步 | interpret | 一步一步来嘛，你知道的？ |
| "only so much ink in the pen" | 谚语，篇幅有限 | interpret | 笔墨就那么多 |
| "do as I say and not as I do" | 言行不一 | interpret | 请照我说的做，别照我做的做 |
| "eating characters and, occasionally, uh, excreting tokens" | 拟人化的排泄梗 | retain 幽默 | 吞字符，偶尔，呃，拉出词法单元 |
| **lexigator** | lexer + alligator 造词，图是鳄鱼 | **retain** | 保留词并注明是玩笑 |
| "we can count at least one mega billionaire among us" | Eric Schmidt 玩梗 | interpret | 我们中间至少能数出一位亿万富豪 |
| "**We're about** handcrafted goods" | **about 是名词**（手工货），不是介词 | **retain 双关** | 我们这是要卖**手工货**了 |
| "Syntax error Whac-A-Mole" | 打地鼠游戏 | interpret | 语法错误打地鼠 |
| "this shotguns the user with a blast of errors" | 霰弹枪 | interpret | 一把霰弹枪把用户轰个满脸 |
| "syntactic lichen" | 地衣（长在代码上的寄生物） | **retain 意象** | 语法上的地衣 |
| "as passé as ALL CAPS KEYWORDS" | 过时 | interpret | 和全大写关键字一样过时 |
| "design diatribe" | 长篇大论 | interpret | 设计长文 |
| "bare bones" | 光骨架 | interpret | 光剩骨架 |

### 4.3 Structural challenges

| 位置 | 难点 | 处理 |
|---|---|---|
| L686-708 maximal munch 演示 | `---a` / `- --a` / `-- -a` 三种切法必须一字不差 | **代码原样保留**，正文把差异讲清楚 |
| L774 `## Design Note: Implicit Semicolons` | 工具靠 `Design Note:` 前缀识别设计说明 | 改成 `## 设计说明：隐式分号`（工具已配中文前缀） |
| L790-895 设计说明 | 四种语言对比，嵌套代码块 + 列表 | 保留原有的列表/缩进结构 |
| L869 `<span name="lambda">statement</span>` | span 在括号嵌套深处，跨行 | 保持 name 不变 |
| L19 span 跨行 `</span>` 写法 | 原文 `<span` 与 `name=` 分两行 | 合并成一行，工具不依赖换行 |
| 全章 | 英文靠 we/it 区分人和代码 | 硬规则：不以「它」指代代码 |
| 全章 | 中文无斜体 | 原文 `*em*` 一律译粗体 |

### 4.4 处理策略

- 全部双关走 **interpret / retain**，**不造新词**
- lexigator 与 `We're about` 保留原文双关，因为中文造不出同等笑点
- 设计说明是全书唯一的"课外阅读"，语气比其他章更松，允许更长的句子