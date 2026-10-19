# 第 1 章「导言」初译反思清单（只诊断，不改）

对照 `craftinginterpreters/book/introduction.md` 逐段过。四个维度 + 人称专项。

## (i) 准确性

| # | 行 | 问题 | 建议 |
|---|---|---|---|
| A1 | L19 | **漏字**：「As we build each piece of the system, I will introduce the history and concepts behind it.」译成「交代它背后的来龙去脉和相关概念」。`history` 译「来龙去脉」偏重「来龙去脉」而漏掉「历史」义。建议改「历史脉络和相关概念」 |
| A2 | L26 | **漏成分**：「You wouldn't believe how much some of them can drink.」`some of them` = 有些人（喝得多）。现译「其中有些人能喝多少」——OK。但 `You wouldn't believe` 语气是「你简直不敢相信」，现译「你都想不到」可，但更贴近原文的是「你不会相信」。轻微，可留 |
| A3 | L30-31 | **漏成分**：「Getting the language up and running」译「把这门语言跑起来」，OK。但「we're mostly going to spend our brain juice」的 `brain juice`（脑力/脑汁）现译「大部分脑力」——偏弱。建议「大半脑子都要花在…」 |
| A4 | L47-48 | **漏成分**：「a solid intuition」现译「扎实的直觉」OK；「the concepts there will firmly stick in your mind, adhered to this tangible substrate」现译「牢牢地刻在你脑子里——因为它们全都黏在这个摸得着的底子上」。`adhered to` 是「黏附于」，现译用了「黏」但改成「因为」引入了因果（原文没说是因果，只是比喻的延续）。建议改成「全都附着在这个摸得着的底子上」，去掉「因为」 |
| A5 | L53-54 | **语义偏移**：「such existential doubt」现译「怀疑起『它到底该不该存在』来」——把「存在性的怀疑」具体化成「该不该存在」。原文 Bob 的意思是「连「编程语言这门东西到底值不值得存在」的怀疑」。现译可接受，但丢了 `existential` 的「存在主义」味道。建议：「能招来这么大的**存在性**怀疑」 |
| A6 | L58 | **语义偏移**：「The designers of the world's widely used languages could fit in a Volkswagen bus」现译「它们的设计者塞进一辆大众面包车里都还有富余」。原文的 joke 是「**装得下**」（没有富余也装得下），「还有富余」是误加。建议改「挤得进一辆大众面包车」 |
| A7 | L64-66 | **漏成分**：「We used to call them "little languages"」现译「我们以前管它们叫「小语言」（little languages）」。原文的重点在「以前叫 A，现在叫 B」的**变迁**。现译有。但术语表规则要求首现「中文（English）」，现译 ✓。另外 `niche ones` 译「小众语言」——`niche` 在这里其实指「小众领域」，OK |
| A8 | L73 | **语气偏弱**：「A random selection of some little languages you might run into.」现译「你可能碰上的一些小语言，随手挑几门。」——把 `random`（随机）译成「随手」。「随手挑」偏主动，「随机挑几门」更贴原文。轻微 |
| A9 | L80 | **语义偏移**：「whip up a parser」现译「撸一个语法解析器」。`whip up` = 迅速随手做出来。「撸」有口语味，保留。但「撸」在本项目已译基准里没出现过。留着可以（有口语感），但要确认不是生造。可保留 |
| A10 | L88 | **漏成分**：「The code is complex and performance critical.」现译「代码复杂，而且性能上不能含糊」。`performance critical` = 对性能有关键要求。现译「性能上不能含糊」意思对但不是「关键要求」。建议：「而且性能是硬指标」 |
| A11 | L100 | **漏成分**：「the mixture of awe and terror on my college friends' faces when talking about their compilers class」——原文是「他们**大学同学**在谈他们编译器课时脸上的敬畏与恐惧**混杂**」。现译「我在大学同学谈起他们那门编译器课时，脸上那种敬畏与恐惧混杂的表情」——**主语含混**，「我在……脸上」读起来像我脸上有表情。必须改：「后来我注意到，我那些大学同学一谈起他们的编译器课，脸上的表情里混杂着敬畏与恐惧」 |
| A12 | L110 | **语义偏移**：「its practitioners don't hesitate to play up this image」现译「从业者一点也不客气，喜欢给这个形象加码」——OK。`Two of the seminal texts` = 两部开创性/奠基性著作。现译「奠基之作」OK |
| A13 | L121 | **漏成分**：「some parts are a little difficult. But not more difficult than other obstacles you've overcome.」现译完整 ✓ |
| A14 | L129 | **漏成分**：「It's a couple of chapters to get you oriented」现译「几章的篇幅，用来给你定位方位」。`oriented` 是「帮你认个方位」。OK |
| A15 | L135-136 | **漏成分**：「build on the previous chapters but require nothing from later ones」现译「每一块都建立在前几章之上，却不需要后面任何一章的东西」✓ |
| A16 | L143 | **人称误译**：「We're about *crafting* interpreters」——`crafting` 在这里是「手雕」（本书书名译法），且 `about` 是名词（我们要**开始手雕**解释器了）。现译「我们马上要开始**手雕**解释器了」✓ 但**丢了 span/强调以外的引号**。原文的 `*crafting*` 是 `*em*`，按规则译 `**粗体**`，现译 `**手雕**` ✓ |
| A17 | L146 | **漏成分**：「tools like [Lex][] and [Yacc][], so-called **compiler-compilers**, that automatically generate some of the source files」现译 ✓。但原文 `compiler-compilers` 是复数（类指多类工具），现译「**编译器-编译器**」单数。可接受 |
| A18 | L152 | **漏成分**：「a grammar file」现译「一份文法文件」✓（术语表 lexical grammar=词法文法，此处应是「文法」） |
| A19 | L163 | **语气**：「the language nerd sense of humor is an acquired taste」现译「语言书呆子的幽默感是后天培养出来的」✓ |
| A20 | L168 | **漏成分**：「I want to ensure there are no dark corners where magic and confusion can hide」现译「我不想留下任何阴暗角落，让魔法和困惑躲在里头」✓ |
| A21 | L175-177 | **漏成分**：「If I seem a little cavalier about, say, omitting `private` or declaring a global variable, understand I do so to keep the code easier on your eyes.」现译「如果我看上去对省略 `private`、或者声明一个全局变量这类事情有点吊儿郎当，请理解，我这么干是为了让代码看着更省力」✓ 但 `easier on your eyes` = 「对你的眼睛更轻松」，现译「看着更省力」——**省力 ≠ 省眼**。这是本书「页面比 IDE 窄」的核心理由。必须改：「是为了让代码看着不费眼睛」 |
| A22 | L179-180 | **漏成分**：「several paragraphs of honest-to-God prose」现译「好几段货真价实的散文」✓（`honest-to-God` = 货真价实） |
| A23 | L209 | **漏成分**：「If that blurb says "replace _ lines"」现译「如果那段说明写的是「替换 _ 行」」—— 原文的 `_` 是斜体占位符。md 里是 `"replace _ lines"`，是普通文本里的下划线占位。现译保留了 `_` ✓ |
| A24 | L216 | **漏成分**：「suggestions of other areas to explore」现译「另外一些值得探索的方向的提示」✓ |
| A25 | L228-230 | **漏成分**：「They will make you research other languages, figure out how to implement features, or otherwise get you out of your comfort zone.」现译 ✓ |
| A26 | L232-233 | **人称**：「stay inside the comfy confines of the tour bus」现译「想窝在游览车那圈舒适区里」✓ 但漏了 `Or skip them if you want to` 的「想」——现译有「想窝在」✓ |
| A27 | L244 | **漏成分**：原文「Most "programming language" books are strictly programming language *implementation* books.」现译「大多数「编程语言」书其实是地道的编程语言**实现**书」。`strictly` = 纯粹地/彻头彻尾地。现译「地道」尚可 |
| A28 | L265-267 | **漏成分**：「take these with a large pinch of salt」现译「请多加一大撮盐」✓；「That should make them tastier food for thought」现译「这样吃起来才是更有味道的思想食粮」✓（双关保留） |
| A29 | L271-273 | **漏成分**：「The focus is on *concepts*.」现译「重点放在**概念**上」✓；「honing our understanding of exactly how the language is supposed to behave」现译「打磨我们对「这门语言到底该怎么表现」的理解」✓ |
| A30 | L284-286 | **漏成分**：「there tends to be less complex machinery hiding under the hood」现译「它底下藏着的机械东西通常没那么复杂」✓ |
| A31 | L310-313 | **漏成分**：「If you aren't that familiar with Java, don't freak out.」现译「要是你对 Java 还不够熟，别慌」✓；「but that's about it as far as "advanced" features go」现译「但所谓「高级」特性也就用到这儿」✓ |
| A32 | L315-317 | **人称/漏成分**：「we are only able to accomplish that by building on the Java virtual machine's own runtime facilities. We want to learn how Java *itself* implements those things.」现译「靠的是站在 Java 虚拟机自己的运行时设施之上。我们想学的是，Java**自己**是怎么实现这些东西的。」✓ |
| A33 | L321-322 | **漏成分**：「C is the perfect language for understanding how an implementation *really* works, all the way down to the bytes in memory and the code flowing through the CPU.」现译 ✓ 但「all the way down」译成「一路下到……下到」，`all the way` 的递进略弱。可改为「一路下探到」 |
| A34 | L324 | **漏成分**：「A big reason that we're using C is so I can show you things C is particularly good at」现译「我们用 C 的一个重要原因，是我可以向你展示 C 特别擅长的东西」✓ |
| A35 | L327-329 | **漏成分**：「In return, you'll come away from this book an even stronger C programmer.」现译「作为回报，读完这本书你的 C 会更好」——「你的 C 会更好」表达不通顺，且丢了 `an even stronger C programmer`。必须改：「作为回报，读完这本书你会成为一个更强悍的 C 程序员」 |
| A36 | L342-345 | **漏成分**：「Our C interpreter will contain a compiler that translates Lox to an efficient bytecode representation (don't worry, I'll get into what that means soon), which it then executes.」现译「C 解释器里会装一个把 Lox 翻译成高效字节码表示的**编译器**（别担心，那是什么意思我很快就会讲），然后再去执行这个字节码」✓。但 `which it then executes` 的主语是解释器；现译「然后再去执行」省略了主语——符合项目人称规则 ✓ |
| A37 | L353-354 | **漏成分**：「able to keep up with other professional caliber implementations out there」现译「跟外面那些专业水准的实现掰手腕也不落下风」✓ |
| A38 | L360-361 | **漏成分**：「There are at least six domain-specific languages used in the little system I cobbled together to write and publish this book.」现译「用来撰写并出版这本书的[那套我七拼八凑搞出来的小系统][repo]，至少用到了六种领域特定语言」——`to write and publish` = 为了撰写并出版（本书）。现译「用来撰写并出版这本书」✓ |
| A39 | L392-394 | **漏成分**：「The designer of Nimrod ended up renaming his language to "Nim"」——注意：原文说的是 **Nimrod** 这门语言的设计者。译文「「尼姆罗德」（Nimrod）的设计者」✓。`Bugs Bunny` 保留英文——**这是 Bugs Bunny（角色名），读者会去查，应该译「兔八哥」**。项目规则 ②：读者会查就音译。Bugs Bunny 有公认中译「兔八哥」。而且我在同一句里写了「（Bugs 那是在反讽。）」——**两个不同的称呼指同一人，中文读者会分不清**。必须处理：既然保留 `Bugs Bunny` 英文，那 `Bugs` 也保留英文可以，但两者要能对上；或者全译。建议：「因为太多人还记得《兔八哥》里 Bugs Bunny（兔八哥）拿「尼姆罗德」当骂人的话。（Bugs 那会儿是在反讽。）」——或干脆统一：「太多人还记得 Bugs Bunny 在《兔八哥》里……」。**这一条必须改，报告里列出** |
| A40 | L396-398 | **漏成分**：「All you need is a reasonably unique token.」现译「你需要的不过是一个还算独特的记号」✓ |

## (ii) 流畅度

| # | 行 | 问题 | 建议 |
|---|---|---|---|
| B1 | L1 | 「童话不只是真实的」——`more than true` 直译「不只是真实的」有点生硬，且后面的「不是……而是……」形成三重转折。建议：「童话比真实更真：不是因为它们告诉我们龙存在，而是因为它们告诉我们，龙是可以打败的。」`can be beaten` 现译「可以被打败」——**是被动**，中文别扭。改「龙是能被战胜的」或「龙是可以打赢的」 |
| B2 | L5-7 | 「我真是兴奋得不行」——`excited` 的口语感 OK。但「我们就要一起走这趟了」+「我真是兴奋得不行」两句主语跳。通顺，可留 |
| B3 | L19 | 「理论比重比别家轻」——`lighter on theory than others` 指比**同类书**理论少。现译 OK |
| B4 | L21-22 | 「一屋子 PL（编程语言）研究者的鸡尾酒会」——「一屋子」是口语，好。但 `at a cocktail party full of PL researchers` 的 `full of` 修饰 cocktail party。现译结构对 ✓ |
| B5 | L30 | 「不过我们大部分脑力，还是要花在把这门语言跑起来上」——「大部分脑力」读着别扭（脑力是「花」的，不是「是」的）。见 A3 |
| B6 | L47-48 | 「我希望你能带着一个扎实的直觉离开」——「离开」缺宾语（离开这本书）。读者能补，但中文略生硬。建议「我希望你能带着一份扎实的直觉合上这本书」 |
| B7 | L53-54 | 「编程语言身上到底有什么，能让人怀疑起「它到底该不该存在」来」——「身上……有什么」+「怀疑起……来」叠用，口语但有点绕。可简化：「我始终想不明白，编程语言身上是哪儿出了什么问题，能让人产生这么大的存在性怀疑。」**但这会丢掉「不该存在」的直白**。二选一，需拍板 |
| B8 | L77-78 | 「可一旦把文档、调试器、编辑器支持、语法高亮，以及其他所有配套设施都算进来，自己动手造一个，要求可就太高了。」——「自己动手造一个」缺宾语（造一个语言）。见 A-list，建议补「自己动手造一门」 |
| B9 | L85-86 | 「等他们后来把这些负担卸下来，四肢变轻、空气富氧，相对而言那份轻松就让他们能跑得更远、更快。」——「四肢变轻、空气富氧」是两个并列项但句子结构没点明是并列的主语（人的变化 vs 环境的变化）。原句 `the new relative ease of light limbs and oxygen-rich air` 把两者合成一个名词短语。建议：「四肢变轻、空气富氧，这份「相对」的轻松劲儿就让他们能跑得更远更快。」 |
| B10 | L92-93 | 「你会变成一个更强的程序员」——`a stronger programmer` 直译「更强」在中文里对人不常用。基线章里也有类似（「更强的程序员」）。**基线章 a-map-of-the-territory 没有这句**。建议「更厉害的程序员」或「硬功夫更硬的程序员」。见报告 |
| B11 | L103 | 「这个形象很迷人，但它有阴暗的一面。」✓ |
| B12 | L118-119 | 「那就是代码，而玩语言的人，也就是普通人。」✓ 口语 |
| B13 | L129-130 | 「几章的篇幅，用来给你定位方位、教一点语言黑客说的行话，再把 Lox——也就是我们将要实现的那门语言——介绍给你。」——破折号嵌套太多。`the language we'll be implementing` 已有 `Lox` 这个名字，补注是译者加的。可保留（消歧），但读着累。建议简化 |
| B14 | L139 | 「除了大量激动人心的英文散文之外」——原文是自嘲（`scintillating English prose` 是英语课本里的套话）。中文没有对应的「英语散文」的矫揉造作感，「激动人心」不够准。建议加一点调侃：「除了那一大段一大段激动人心的英文散文之外」或保留但换词「除了海量的英文散文之外」。见报告 |
| B15 | L143 | 「所以这本书里是真的有代码」✓ |
| B16 | L146 | 「很多别的语言书和语言实现会用到 Lex 和 Yacc 这类工具」——「很多别的语言书和语言实现」读着别扭。建议「很多语言书和语言实现都用 Lex、Yacc 这类工具」 |
| B17 | L152 | 「吃进一份文法文件，吐出一个编译器用的源文件」✓ 很棒 |
| B18 | L175-177 | 「请理解，我这么干是为了让代码看着更省力。」见 A21。`easier on your eyes` 必须译出「眼睛」 |
| B19 | L179 | 「另外，代码里的注释不多。」✓ |
| B20 | L184 | 「我希望这本书像 XO 白兰地那样越陈越香，而不是后院私酿。」✓ 比喻保住了 |
| B21 | L188-189 | 「既然书里字面意义上包含了实现所需的每一行代码」——`literally` 的强调丢了。建议「既然书里可是实打实包含了……」 |
| B22 | L209-212 | 「中间是你要加进去的新代码。它上面或下面可能夹着几行淡掉的代码」✓ |
| B23 | L216-218 | 「<span name="joke">旁注</span>里放着人物小传」✓ |
| B24 | L228-230 | 「它们会把你从有人领路的路上推下来，逼你自己去探索。」✓ |
| B25 | L232 | 「也许还会蹭破几块皮」✓ `bumps and scrapes` 保留了 |
| B26 | L244-246 | 「我们这些程序员，似乎天生更亲近黑白分明的东西，更邻近一和零」——`ones and zeroes` 单独重复一次效果好，现译有 ✓ |
| B27 | L250-251 | 「你从他们门缝底下塞进去一份语言规范，等几个月，代码和基准测试结果就出来了。」✓ |
| B28 | L271-273 | 「这样既能让我们对基本手法熟悉起来，也能打磨我们对「这门语言到底该怎么表现」的理解。」✓ |
| B29 | L284-286 | 「Java 很适合干这事。」✓ |
| B30 | L310-313 | 「最后，Java 火得一塌糊涂。」✓ |
| B31 | L315-317 | 「到第二部分结束时，我们会有一个简单、好读的实现。」✓ |
| B32 | L327-329 | 见 A35，「你的 C 会更好」必须改 |
| B33 | L331-333 | 「Java 白送的那些东西，我们只能自己动手实现。」✓ |
| B34 | L353-354 | 「一本书加几千行代码，能做到这样，不赖吧。」✓ |
| B35 | L378 | 「我翻过了**好几页**候选名单」——原文 `*pages* of candidates` 是「好几**页**的候选名单」，量的是页。现译 ✓ |

## (iii) 风格

| # | 行 | 问题 | 建议 |
|---|---|---|---|
| C1 | L11 | 「献给我的朋友和家人：抱歉，我一直以来都这么心不在焉！」——原文是一句玩笑，`absentminded` 说的是「忘了这本书该献给谁」。现译保留了自嘲 ✓ |
| C2 | L51 | 「## 为什么要学这玩意儿？」——`stuff` 是口语的贬义。现译「玩意儿」✓ 对 |
| C3 | L62 | 「### 小语言无处不在」✓ |
| C4 | L95 | 「### 还有一个理由」✓ |
| C5 | L103-106 | 「**我**并不觉得自己像个巫师」+「把**我**关在了门外」——原文 `*I*` 和 `*me*` 两处斜体强调，现译都用了 `**` ✓ 重复效果保住 |
| C6 | L125 | 「总得有人来当这个人。」✓ 短促 |
| C7 | L143 | 「我们马上要开始**手雕**解释器了」✓ |
| C8 | L148 | 「有些人甚至说那是宗教信仰」✓ |
| C9 | L155-157 | 「名字是拿 Yacc 的读音「yak」（牦牛）玩的双关」✓ |
| C10 | L163-164 | 「那……嗯，也许语言书呆子的幽默感是后天培养出来的。」✓ |
| C11 | L222 | 「大多数旁注就是些傻笑话和业余画作。」✓ |
| C12 | L237-238 | 「一尘不染的（「没被习题糟蹋过」？）状态」✓ |
| C13 | L266-267 | 「请多加一大撮盐。这样吃起来才是更有味道的思想食粮」✓ 双关保留 |
| C14 | L349 | 「一份价钱两份货！」✓ |
| C15 | L363 | 「「Hello, world!」程序」——保留英文 ✓ |
| C16 | L366 | 「为了练练指针」✓ 口语 |
| C17 | 全章 | **人称专项**：本章不涉及代码运行行为，人称几乎无风险。检查「Java 白送」「我们戒掉它们」等——施动者是「Java」「我们」，不是「它」✓ |

## (iv) 术语

| # | 行 | 问题 | 建议 |
|---|---|---|---|
| D1 | L19-20 | `theory` 译「理论」✓ |
| D2 | L64 | `little languages` = 「小语言」✓（首现标 English ✓） |
| D3 | L66 | `domain-specific languages` = 「领域特定语言」✓ 首现标 English ✓ |
| D4 | L66 | `pidgins` = 「皮钦语」✓ |
| D5 | L88 | `dynamic arrays` = 「动态数组」✓ |
| D6 | L88 | `graphs` = 「图」✓ |
| D7 | L110-111 | `implementation` = 「实现」✓ |
| D8 | L132 | `implementation` ✓ |
| D9 | L152 | `grammar file` = 「文法文件」✓ |
| D10 | L165 | `source files` = 「源文件」✓ |
| D11 | L179 | `comments` = 「注释」✓ |
| D12 | L255 | `FORTRAN 77` 保留 ✓ |
| D13 | L271 | `jlox` 保留 ✓ |
| D14 | L315-316 | `runtime facilities` = 「运行时设施」✓ |
| D15 | L332 | `dynamic array` / `hash table` / `garbage collector` ✓ 全部表内 |
| D16 | L378 | `appellation` = 「名字」✓ |
| D17 | 全章 | **人名**：`G. K. Chesterton` 切斯特顿 ✓、`Neil Gaiman` 尼尔·盖曼 ✓、`Haskell Curry` 哈斯凯尔·柯里 ✓、`William Alvin Howard` 威廉·阿尔文·霍华德 ✓、`Dennis Ritchie` 丹尼斯·里奇 ✓。**`Bugs Bunny` 见 A39，须处理** |
| D18 | 全章 | **术语表**：本译稿新增术语（little language、domain-specific language、pidgin、compiler-compiler、self-hosting、bootstrapping、diamond operator、punched card、formal reasoning、type system、reference counting）**尚未写入** glossary，需补 |

## 中英夹杂专项扫描

| 行 | 片段 | 判断 |
|---|---|---|
| L98 | 「BASIC 自己」 | BASIC 专名 ✓ |
| L129 | 「Lox」 | ✓ |
| L146 | 「Lex」「Yacc」 | ✓ |
| L183 | 「Makefile」「IDE」 | ✓ |
| L292-293 | 「GCC」「LLVM」「C++」「JavaScript」 | ✓ |
| L311 | 「Java 7」「C#」「C++」 | ✓ |
| L328 | 「Lua」「CPython」「Ruby 的 MRI」 | ✓ |
| L344 | 「PHP」 | ✓ |
| L363 | 「Makefile」「IDE」 | ✓ |
| L392-393 | 「Nimrod」「Nim」「Bugs Bunny」 | Nimrod/Nim 是语言名 ✓；**Bugs Bunny 见 A39** |

## 汇总：必须改的 8 条

1. A11 —— L100 主语含混（「我在大学同学……脸上」）
2. A21 —— L177 `easier on your eyes` 误译成「省力」
3. A35 —— L327-329 「你的 C 会更好」
4. A39 —— L392-394 Bugs Bunny 中英混用、两个称呼指同一人
5. A6 —— L58 「还有富余」误加
6. A4 —— L47-48 「因为」引入因果
7. A1 —— L19 「来龙去脉」漏「历史」
8. B1 —— L1 引文「不只是真实的」「可以被打败」

## 拿不准、留待报告的

- A5/B7 `existential doubt` 的处理（存在性怀疑 vs 该不该存在）
- A26 `strictly` 的译法
- B10 `a stronger programmer`
- B14 `scintillating English prose` 的调侃感
- D18 新术语是否全部进术语表