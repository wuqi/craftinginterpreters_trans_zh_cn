# 第 11 章「作用域解析与绑定」译前分析

## 1. 内容与作者意图

- **讲什么**：修补闭包引入的一个作用域 bug。第 10 章加闭包时，函数捕获的是
  **可变的**环境对象引用，而不是声明时刻的**快照**，导致同一个 `print a` 在不同
  时间点打印出不同值。本章写一个**作用域解析器**（resolver），在语法解析之后、
  执行之前走一遍语法树，把每个局部变量的「跳跃层数」静态算出来存进 `locals` 表，
  运行时按固定距离直达环境，不再动态查找。
- **核心论点**：静态作用域（词法作用域）意味着一个变量用法**永远**指向同一个声明，
  仅靠读源码就能确定。既然静态可定，就不该每次运行时动态重算——既有 bug 又慢。
- **作者在干什么**：第一次引入「语义分析」这一概念。他把解析器与解释器之间的
  一个独立 pass（作用域解析）作为教学载体，顺带讲清「静态分析 vs 动态执行」的区别
  （无副作用、无控制流），并演示如何让程序**提前**在编译期报错（重复声明、顶层 return）。
- **承接**：直接接第 10 章末尾「让一丁点儿动态作用域漏进了解释器……下一章堵上」。
- **钩子**：把「解析属性、默认参数等更多语义检查」留给读者（习题），并预告
  clox 会把解析放进解析器本身（L362-364）。

## 2. 术语预判

| 英文 | 译法 | 状态 |
|---|---|---|
| resolving / resolver | 作用域解析 / 作用域解析器 | 表内（与 parse 拆开） |
| binding | 绑定 | 表内 |
| static scope / lexical scope | 静态作用域 / 词法作用域 | 表内 |
| semantic analysis | 语义分析 | **缺，本章定** |
| syntactic analysis | 语法分析 | **缺，本章定**（与语法解析区分） |
| persistent data structure | 持久化数据结构 | **缺，本章定** |
| side effect | 副作用 | 表内 |
| scope map | 作用域表 | 暂定，正文自然表达 |
| declare / define | 声明 / 定义 | 表内（variable declaration） |
| initializer | 初始化器 | 表内 |
| shadowing | 遮蔽 | 表内 |
| hoisting | 提升 | **缺，本章定**（旁注 JavaScript `var`） |
| environment | 环境 | 表内 |
| closure | 闭包 | 表内 |
| block scope | 块作用域 | 表内 |
| control flow | 控制流 | 表内 |
| short-circuit | 短路 | 表内 |
| side table | 侧表 | **缺，本章定**（旁注自嘲） |

冲突：`parse`→语法解析、`resolve`→作用域解析，全章严格区分。
`analysis` 一词：`semantic analysis`→语义分析；`syntactic analysis`（原文 *syntactic*
analysis）→语法分析，正文里与 parse（语法解析）区分，注意 context。

## 3. 语域判断

- **偏动手**（大量代码块 + `^code` 46 个），但作者用**故事**开头：漏水、钻进的洞。
- 引文：Thor Heyerdahl《Kon-Tiki》——讲「不知不觉陷入怪境，回头惊觉」，
  完美呼应本章「一个看似正常的程序，莫名打印出两个值」。
- 幽默/比喻集中：
  - L8-13 开头「船在漏水」「神圣誓言」夸张
  - L152 旁注「病态、生造的程序」「你得在语言圈混久了」
  - L230「Boo.」（拆台）
  - L273-288 持久化数据结构
  - L553「It's alive!」（科学怪人梗）
  - L628 旁注 boring「我没说它们都有趣」
  - L701「喝口水、打个盹」
  - L726-728 side table「一搜就搜到家具」
  - L799-804 旁注 coupled「摸黑开车」「手把手踩过的 bug」
- 自嘲：boring 旁注、side table 旁注。

## 4. 翻译难点清单

### 4.1 Comprehension gaps（理解落差）

| 位置 | 落差 | 处理 |
|---|---|---|
| *semantic analysis* vs *syntactic analysis* | 两者都含 analysis，中文要能区分 | 语义分析 / 语法分析，段内点明对比 |
| hoisting 旁注 JS `var` | 中文读者未必熟悉 | retain 术语「提升」，旁注内解释清楚 |
| persistent data structure | 中文易与「持久存储」混 | 定译「持久化数据结构」，旁注点明「不可变」 |
| side table | 直译「侧表」生硬 | 首现标英文，正文说清「与对象分开存的表」 |
| `<img>` alt 文本 | 机器/图注，但 alt 是给人读的 | 翻译 alt（按 skill 判断规则） |
| `faux pas`（L394） | 法语借词 | interpret「出洋相/丢人」 |

### 4.2 Figurative language（比喻习语）

| 原文 | 机制 | 处理 | 译法 |
|---|---|---|---|
| "taking on water" / "a hole opened in our formerly waterproof interpreter" | 船漏水的比喻，贯穿开头 | **retain 意象** | 在进水／曾经滴水不漏的解释器破了个洞 |
| "our good friend shadowing" | 拟人调侃 | interpret | 我们的老朋友——遮蔽 |
| "Boo." | 拆台 | interpret | 「呸。」/「嘘。」→ 选「嘘。」 |
| "It's alive!" | 《弗兰肯斯坦》梗 | retain（读者能识） | 「它活了！」 |
| "flying blind" | 无照飞行比喻 | interpret | 像在盲飞 |
| "mucking around" | 俚语 | interpret | 去折腾 |
| "the foliage of the syntax tree" | 树冠枝叶比喻 | retain | 语法树的枝枝叶叶里 |
| "piggyback on the JVM" | 搭便车 | interpret | 顺搭 JVM 的便车 |
| "stitches everything together" | 缝接 | interpret | 把一切缝合起来的主类 |
| "prime time"（ready for prime time） | 电视梗 | interpret | 正式上场 |
| "scouring each one" | 搜寻 | interpret | 挨个翻找 |
| "shady shenanigans"（L56） |  shady shenanigans | interpret | 见不得光的勾当 |
| "sacred vow"（L12） | 夸张 | retain | 立下神圣誓言 |
| "bad boy"（L849） | 调侃 | interpret | 瞧瞧这个坏家伙 |
| "neat, right?" | 口语 | interpret | 「不错吧？」 |

### 4.3 Structural challenges（结构难点）

| 位置 | 难点 | 处理 |
|---|---|---|
| 全章 | we/it 对立，中文无 | 硬规则：不以「它」指代代码 |
| 全章 | 原文 *em* 一律译 `**粗体**` | 见 skill 第 7 节 |
| L43-44 `<span name="precision">` 跨行 | 锚点保持 | 原样保留 span 结构 |
| L60 `**A variable usage refers to...**` | 整句加粗的定义句 | 整句加粗，不拆 |
| `### Scopes and mutable environments` | 小标题 keep english? 标题要显示中文 | 见第 5 节标题规则 → 中文 |
| L553 "It's alive! " 尾部有空格 | 无关 | 保留句意即可 |
| 脚注/链接定义 | 本章无脚注，仅 intro 两个链接 | 保留具名引用 |

### 4.4 处理策略汇总

- 引文《Kon-Tiki》：查证——无通行中译，直译并给出处（Thor Heyerdahl，《Kon-Tiki》）。
- 术语缺项当场写回 glossary：semantic analysis / syntactic analysis /
  persistent data structure / hoisting / side table。
- 人称：一律省略主语或以代码名作主语，绝不写「它」指代代码。
- 强调：原文 *em* / **strong** 一律中文粗体。
- 代码块注释：`^code` 由构建器从源码抽取；md 内手写 Lox 块无注释需译。
