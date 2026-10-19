# 第28章 方法与初始化器 — 译前分析

## 3.1 内容与作者

本章给 clox 补上「行为」这一半：方法、调用方法、初始化器、`this`，最后用一条
超级指令 `OP_INVOKE` 把方法调用加速 7.6 倍。

作者在这个位置想干什么：第27章刚把状态（类/实例/字段）做完，本章接上行为；
同时埋下两章的钩子——`this` 的实现方式被刻意做成「为 `super` 铺路」
（`currentClass` / `ClassCompiler`），章末的 `OP_INVOKE` 优化也直接引出第29章
`super` 调用。承接上一章：第27章的 `OP_GET_PROPERTY`、`bindMethod` 铺垫、
`k,lass,()` 命名梗；开头明说「第二趟 jlox 之旅」。

## 3.2 术语预判

| 英文 | 中文 | 备注 |
|---|---|---|
| method | 方法 | 已有 |
| bound method | 绑定方法（bound methods） | 术语表已有，第12章已定；本章首次出现补标英文 |
| initializer | 初始化器 | 已有 |
| receiver | 接收者 | **新增**，与 `this` 同指，术语表原缺 |
| constructor | 构造函数 | 已有 |
| arity | 参数个数（arity） | 已有 |
| superinstruction | **超级指令** | **新增** |
| calling convention | **调用约定** | **新增** |
| parse table | 解析表 | 已有用法 |
| prefix position | 前缀位置 | |
| lexically scoped | 词法作用域 | |
| string interning | 字符串驻留 | 已有 |
| root | 根 | 已有 |
| microbenchmark | 基准测试 | 与 glossary `benchmark` 一致 |
| novelty budget | **新意预算** | titles.zh.json 已有 `Novelty Budget: 新意预算` |
| strangeness budget | **怪异度预算** | Steve Klabnik 的说法 |
| idiosyncrasy credit | **异类信用** | 心理学概念，英文链接保留 |
| Monte Carlo algorithm | **蒙特卡洛算法** | |
| novelty | 新意 | |
| mixin / trait / multimethod | 混入 / 特质 / 多重方法 | 已有 |
| reflection | 反射 | **新增** |
| dependent types | 依赖类型 | **新增** |
| runtime metaprogramming | 运行时元编程 | 已有 元编程 |
| private school / public school (uniforms) | 寄宿私校 / 公立学校（校服） | 比喻 |

人名：Umberto Eco → 翁贝托·埃科（已有）；Steve Klabnik → **史蒂夫·克拉布尼克**（新增）。
TRS-80、BASIC 保留英文。

## 3.3 语域判断

偏动手。大量「我们现在发射一条新指令 → `^code` → 「我们来实现它」→ `^code`」的
往复循环，人称统一用省略主语或「我们」。幽默集中在：floppy disk 自嘲（L851）、
party hat 里程碑（L382）、<span name="pat">拍马屁</span>、设计说明里的
「我做的都是最古怪、最任性的语言设计决定」。

## 3.4 翻译难点清单

| 位置 | 类别 | 处理方式 |
|---|---|---|
| 题词 "When you are on the dancefloor, there is nothing to do but dance." | Figurative | interpret。查过上海译文《洛阿娜女王的神秘火焰》（王永年译，2023），未见此句中译，用口语直译：「一旦站上舞池，就只剩跳舞这一件事可做。」 |
| "bring its nascent objects to life" | Figurative | interpret + 保留意象：「让这些初生的对象活起来」 |
| "a familiar territory from our previous jlox interpreter" | Figurative | 呼应第2章 `territory`→「这片地」（已定），必须复用：「都是上一趟 jlox 之旅走过的那片熟地」 |
| "seven times faster than our baseline performance" | Structural | 精确：比基准快七倍以上（后文实测 7.6 倍，两处别打架） |
| "a **series** of instructions" / aside `series` | Structural | 强调落在「一连串」上，span 保留完整成分 |
| "shunt over to the runtime" | Figurative | 「转交给运行时」 |
| "knock the object model out first" | Figurative | 「这回我们先把对象模型搞定」 |
| "That's where slot zero in the new CallFrame will be." | Structural | 中文重排：「新建的调用帧里，槽位零就是那个位置」 |
| "the slot has no name, the function body never accesses it. You can guess where this is going." | Structural | 保留 Bob 的铺垫语气：「你能猜到这要通向哪里」 |
| "do some shenanigans" | Figurative | 「做些手脚」 |
| "It is as if the initializer is implicitly wrapped in a bundle of code like this" | Structural | 「就好像初始化器被隐式地裹进了这么一段代码」 |
| "Look carefully. See any bug waiting to happen?" | Figurative | 「仔细看。有没有哪个 bug 正在等着发生？」 |
| "That's *7.6 times faster*" | Structural | 强调用粗体，数字不动 |
| "We shouldn't pat ourselves on the back *too* firmly" | Figurative | span `pat` + 配图，「我们不该太使劲地拍自己的马屁」——配图是拍胸脯动作，措辞要贴 |
| "Thou shalt not break correctness." | Figurative | 保留戏谑的「诫命」口气：「你不可破坏正确性。」（呼应十诫） |
| "have to play the game we're given" | Figurative | 「只能打我们手里拿到的这副牌」 |
| "cost of decoding and dispatching" | Structural | 「解码与分派的固定开销」 |
| "Every new superinstruction claims an opcode" | Structural | 「每加一条超级指令都要占用一个操作码」 |
| "design note" 通篇 | Structural | 口语化的语言设计自白，`scripting` 有 span 强调（旁注 dynamic 呼应），须保留 span 锚点位置 |
| "put on a new change of clothes" | Figurative | 「换一身新衣服」 |
| "radio-friendly pop bands" / "free jazz / drone metal" | Figurative | 「电台-friendly 的流行乐队」→ 直译「主流能上台的流行乐队」；自由爵士／drone metal → 「自由爵士或 drone metal」（后无中译，保留） |
| "perf in return" | Figurative | 「拿性能还给你」 |
| "blowing some of your novelty budget" | Structural | 「花掉一部分新意预算」——与后文「spend it wisely」呼应，全章用「花/预算」统一 |
| "They just can't *do* anything useful" | Structural | 强调落在「干点什么」，span `do` |
| "It's a lot of machinery under the hood" | Figurative | 「底下一堆机关」 |
| "three big steps" | Structural | 「三步」 |

结构硬指标：aside 20、span 15、`##` 18、`###` 11、`<img>` 6、代码围栏 26、
链接定义 8 条（`super` `jlox` `locals` `globals` `upvalues` `monte` `note` `idiosyncracy`）。
编号列表 9 条。
