# 第29章 超类 — 译前分析

## 3.1 内容与作者

本章给 clox 补上继承：`OP_INHERIT`（复制下沉）、把超类存成名叫 `super` 的隐藏局部变量、
`OP_GET_SUPER` / `OP_SUPER_INVOKE`。作者同时在做收尾：开头明说「最后一章加新功能」，
结尾回顾整个 clox 并推销下一章。

承接第28章：`OP_INVOKE` 的优化模板、`namedVariable()`、`invokeFromClass()`、`currentClass`、
`ClassCompiler`（第28章末尾搭的架子，这里正好用来存 `hasSuperclass`）。
埋钩子：结尾「还有一章」直接指向第30章。

## 3.2 术语预判

| 英文 | 中文 | 备注 |
|---|---|---|
| superclass / subclass | 超类 / 子类 | 已有 |
| override / overriding method | 覆盖（覆盖方法） | 沿用第13章 inheritance.md 的「覆盖」 |
| copy-down inheritance | **复制下沉继承** | **新增**，本章核心概念 |
| monkey patching | **猴子补丁（monkey patching）** | **新增**，中文有通行说法 |
| duck punching | **鸭子重拳（duck punching）** | **新增**，自造对仗 |
| delegation / delegate to | 委托 / 委托给 | 已有（第12章 classes.md 用「委托」） |
| prototype-based | 基于原型的 | 已有 |
| invariant(s) | 不变量 | **新增** |
| synthetic token | 合成词法单元 | **新增** |
| constant string | 常量字符串 | 与「常量表」区分 |
| tenet | 信条 | 第28章已定 |
| dynamic dispatch | 多态分派 | 第12章已用 |
| harcyon days | 太平盛世 / 黄金时代 | 习语 |
| DeLorean | 德劳瑞安 | 时间机器那辆车，读者会查 |
| Harper Lee | 哈珀·李 | **新增** |
| To Kill a Mockingbird | 《杀死一只知更鸟》 | 上海译文有中译 |
| BETA / inner | BETA / `inner` | 语言名与关键字保留英文 |

## 3.3 语域判断

偏动手，但比第28章更「回顾性」。幽默集中在：本章开头对 `only` 的辩解、
「复制下沉继承」当成败将军、monkey/duck 的双关、「这条格外**超级**的超级指令」自嘲道歉、
`super` 词法单元那个「假设性问题」、结尾掀引擎盖的比喻。

## 3.4 翻译难点清单

| 位置 | 类别 | 处理方式 |
|---|---|---|
| 题词（Scout 的方言口吻） | Figurative | 查过中译本《杀死一只知更鸟》，用口语直译并保留「选不了家人」的转折与自嘲：「你若不认，就会显得傻透了」 |
| "This is the very last chapter where we add new functionality" | Structural | 呼应「加功能的最后一章」，要突出 |
| "better performance over jlox" | Figurative | 「在性能上碾压 jlox」 |
| "the whole purpose of our entire second virtual machine" | Structural | 「我们这整个第二台虚拟机的全部目的」 |
| "a deranged nuclear physicist and a very heavily modified DeLorean" | Figurative | 保留荒谬感：「一个疯了的核物理学家和一台被重度改装过的德劳瑞安」 |
| "Nothing prevents a user from inheriting from an object that isn't a class" | Structural | 「没有任何东西能阻止用户从一个根本不是类的对象继承」 |
| "let the user know what we think of them and their code" | Figurative | 保留火气：「让用户知道我们怎么看他和他的代码」 |
| "We don't need to keep a handle on the superclass, so we don't." | Structural | 短促收尾，中文要同样短：「我们不需要攥着超类的把手，所以就不攥。」 |
| "halcyon days of jlox" | Figurative | 「jlox 的太平盛世」 |
| "unbecoming / even less decorous" | Structural | 递进要保住：「不够体面」「更不体面的」 |
| "copy-down inheritance" | Structural | 「复制下沉继承」；后文统一用「复制下沉」 |
| "super *super* superinstruction" | Figurative | 保留三重词：「格外**超级**的超级指令」，道歉照译 |
| "Drifting down the compilation pipeline" | Figurative | 「顺着编译流水线往下漂」 |
| "the pipeline dumps us into the interpreter" | Figurative | 「流水线把我们直接倒进了解释器里」——与「漂」「倒」同一意象 |
| "This handful of code" | Structural | 「这 handful 代码」→「这 handful 行代码」→「就这么多代码」 |
| "invariants" | Structural | 「不变量」 |
| "so I may as well give our future selves a hand" | Figurative | 「顺手给未来的自己帮个忙」 |
| "pop the hood and repair the engine too" | Figurative | 「掀开机盖、自己修引擎」 |
| `[BETA][]` 空引用 | Structural | **必须**改具名引用 `[BETA][beta]`，否则中文链接失效 |
| challenges 里的 `1./2./3.` 编号、嵌套项目符号、内嵌 ```text 代码块 | Structural | 逐位照抄，缩进 4 空格 |

结构硬指标：aside 10、span 10、`##` 5、`###` 5、`<img>` 6、代码围栏 14（7 块）、
编号列表项 6、嵌套项目符号 2、链接定义 6。
强调：原文 3 个 `**strong**` + 34 个 `*em*` = **37 组**，译文必须是 37 组 `**`，全部落在
span 外（原文 10 个 span 里没有一个带强调）。
