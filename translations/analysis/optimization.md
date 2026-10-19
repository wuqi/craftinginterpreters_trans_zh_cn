# 第30章 优化 — 译前分析

## 3.1 内容与作者

全书技术正文最后一章。两项优化：用位掩码替掉取模（哈希表探测），NaN 装箱（值表示）。
外加一章「方法论」：基准测试、性能分析器、怎样评估优化效果。

作者在这里的角色变了——从「手把手带你实现」切换成「告诉你我当年怎么干活」，
有大量第一人称经验陈述（SunSpider、Octane、我自己的基准测试）。这是全书唯一的「元」章节，
结尾还要给职业建议。语气必须比前面章节更松、更像博客长文。

承接第29章：哈希表（第20章）、NaN（第18章）、类型双关（第18章）、`memcpy` 手法。
收尾：全书完结，并指向 backmatter / 附录。

## 3.2 术语预判

| 英文 | 中文 | 备注 |
|---|---|---|
| lagniappe | **lagniappe**（新奥尔良方言：白送的小赠品） | 读者会查，首现标英文 |
| profiler / profiling | **性能分析器 / 性能分析** | **新增** |
| benchmark | 基准测试 | 已有 |
| hotspot | 热点 | 已有 |
| inclusive time | **包含时间** | 新增，含被调用者的总时间 |
| modulo operator | 取模运算符 | |
| bit masking | **位掩码** | 新增，原文加粗 |
| bit twiddler(s) | **玩位的人** | 新增，自造 |
| linear probing | 线性探测 | 已有 |
| tombstone | 墓碑 | 已有 |
| cache miss | 缓存未命中 | 已有 cache line |
| dead code elimination | 死代码消除 | 新增 |
| microbenchmark | 基准测试 | 统一 |
| NaN boxing / NaN tagging | **NaN 装箱 / NaN 标记** | 新增，加粗术语 |
| fraction / mantissa / significand | **小数部分 / 尾数 / 有效数** | 原文三个并列加粗（同一物三名），中文也要三个并列加粗 |
| exponent | 指数 | 加粗 |
| sign bit | 符号位 | 加粗，在 span `sign` 内 |
| signalling NaN | **发信号 NaN（signalling NaN）** | 加粗 |
| quiet NaN | **静默 NaN（quiet NaN）** | 加粗 |
| type punning | 类型双关 | 第18章已定 |
| strict aliasing | **严格别名** | 新增，加粗 |
| alias | 别名 | |
| pointer tagging | **指针标记** | 新增，加粗 |
| release build / debug build | 发布版 / 调试版 | 新增 |
| inlining | 内联 | |
| lower-hanging fruit | **低垂的果实** | 习语 |
| rabbit hole | 兔子洞 | |
| border collie | 边境牧羊犬 | |
| dog agility training | 狗狗敏捷训练 | |
| obstacle course | 障碍赛 | |
| sinkhole / pothole | 坑 | |

人名：Kazuo Ishiguro → 石黑一雄；The Remains of the Day → 《长日将尽》；
David Gudeman → 戴维·古德曼；Keith D. Cooper → 基思·D. 库珀；
Linda Torczon → 琳达·托尔松；Andrew Appel → 安德鲁·艾佩尔。
书：Engineering a Compiler → 《编译器设计》（人民邮电出版社，郭旭译，2012，图灵教育）；
Modern Compiler Implementation → 《现代编译器实现》。
产品/基准名 SunSpider、WebKit、V8、Octane、MIT 许可证 保留英文。

## 3.3 语域判断

比前 29 章更松。最长的散文段落在「性能分析」和「接下来去哪儿」两节，作者在讲自己的
经验、判断和偏好。幽默：边境牧羊犬的比喻、「要是它祖母的拳」（NaN boxing 的名字）、
「我不是数学家，证明不了给你看」、「bell bottoms and 8-tracks」、
「Go to town」、「戴上你的营销帽去**卖**」。

## 3.4 翻译难点清单

| 位置 | 类别 | 处理方式 |
|---|---|---|
| 题词 | Structural | 「一天里最好的时段是傍晚……」 |
| "lagniappe" | Structural | 保留原词 + 一句解释；新奥尔良特有词，中文无对应 |
| "printf 和屏幕上出现问候语之间的技术栈 perilously tall" | Figurative | 保留「高得吓人」的夸张 |
| border collie / obstacle course / canine physiology | Figurative | 整套比喻保留：VM = 正在硬件障碍赛道上冲刺的边境牧羊犬；不能光坐着琢磨犬类生理学，要**观察** |
| agility training 是「某条狗在某条赛道专属」 | Structural | 保留这个类比来引出「不能假定对所有程序所有硬件都更快」 |
| "ticking the code paths" | Figurative | 「戳中你关心的那些代码路径」 |
| SunSpider / browser wars | Structural | 保留产品名，叙述译出 |
| "penalize complex JIT" | Structural | 「让复杂的 JIT 吃亏」 |
| "I seem to make that mistake at least once a year" | Figurative | 保留自嘲 |
| "one line" 的 70% | Structural | 强调落在「**一行**」 |
| "*wow.*" | Figurative | 短促吐槽，译「不过，*哇*。」——注意英文的句点在强调内部，中文感叹号放粗体内 |
| "bit twiddlers" | Structural | 「玩位的人」 |
| "shave off the highest two bits" | Figurative | 「把最高两位削掉」 |
| "bell bottoms and 8-tracks" | Figurative | 「喇叭裤和八轨道磁带」 |
| "It would suck if..." | Figurative | 「要是因为……我们虚拟机就彻底不支持某种架构，那可太难受了」 |
| "pointer tagging" | Structural | 「指针标记」 |
| "This paragraph is dubious" | Figurative | 「这段话站不住脚」 |
| "you can never be totally sure" | Structural | 保留不确定 |
| "Go to town" | Figurative | 「随便折腾吧」 |
| "lower-hanging fruit" | Figurative | 「低垂的果实」 |
| "rabbit hole / branches in the tunnel" | Figurative | 保留「兔子洞／隧道里的岔道」这组意象 |
| "upload knowledge into your head" / wetware | Structural | 与第28章「上传进湿件」呼应，用「搬进脑子里」 |
| "as far as I know ... I haven't seen it happen" | Structural | 保留不确定语气，不译成断言 |
| `[MIT license][]` 空引用 | Structural | **必须**改具名引用 `[MIT 许可证][mit license]` |
| `<span class="small-caps">AND/OR/NOT</span>` ×6 | Structural | 保留英文（对应 C 运算符），小写字母样式不动 |
| 「接下来去哪儿」里的项目符号 + 内嵌 aside（缩进 4 空格） | Structural | 缩进逐字照抄 |
| 数据不译 | Structural | `printf("Hello, world!")`、两个 IEEE 754 数字、`0/0` 程序输出、`<img alt>` 都要按规则处理 |

结构硬指标：aside 23、span 24（其中 1 个空 `<span name="equal"></span>`）、`##` 5、
`###` 10、`<img>` 9、代码围栏 14（7 块）、编号列表项 8、项目符号 6、
`class="small-caps"` 6、`class="bottom"` 3、链接定义 3。
强调：原文 18 个 `**strong**` + 78 个 `*em*`（含代码块内误配的 `Entry*`），
译文按空行分段逐段比对，要求零分歧。
