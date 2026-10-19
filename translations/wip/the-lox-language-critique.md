# 第 3 章「Lox 语言」初译反思清单（只诊断，不改）

对照 `craftinginterpreters/book/the-lox-language.md` 逐段过。

## (i) 准确性

| # | 行 | 问题 | 建议 |
|---|---|---|---|
| A1 | L399 | **中英夹杂**：`its behaving like you would expect` → 「它的 behaving 跟你在 C 或 Java 里养成的预期一样」。`behaving` 漏译 | 改「多数情况下，跟你在 C 或 Java 里养成的预期一样」 |
| A2 | L580 | **中英夹杂**：`now that lots of languages` → 「如今 Lots of 语言」 | 改「如今这么多语言」 |
| A3 | L605-606 | **中英夹杂**：`it's about halfway to being a functional language` → 「差一半的distance」 | 改「差一半」 |
| A4 | L614 | **中英夹杂**：`it's not cool to like them` → 「liking 它们已经不时髦了」 | 改「嘴上说喜欢它们已经不时髦了」 |
| A5 | L617 | **中英夹杂**：`the "all inheritance all the time" binge` → 「「Inheritance 全都要」的暴食」 | 改「「继承全都要」的暴食」 |
| A6 | L70 | **措辞**：`is heavily indebted to Lua's implementation` → 「大量欠了 Lua 那套实现的债」。中文「欠债」带负面 | 改「大量借鉴自 Lua 那套干净高效的实现」 |
| A7 | L239-240 | **梗丢失**：`Ye Olde Comparison Operators`。`Ye Olde` 是仿中世纪拼写的视觉笑话，现译「那套古老的比较运算符」只剩意思 | 保留「Ye Olde」或在报告里说明损失 |
| A8 | L619 | **语域偏差**：`Likely a majority of working programmers today` → 「今天在岗的程序猿里」。「在岗」是当代中国职场话术，Bob 不是这个意思 | 改「如今在干活的程序员里」 |
| A9 | L899-900 | **漏译**：`evaluates to whichever case is picked` → 「求值成被选中的那个 case」。`case` 是代码关键字，此处指「分支/情形」 | 改「求值成被选中的那个分支」 |
| A10 | L143-145 | **核验**：`Boolean variables are the only data type in Lox named after a person` — 原文说「变量」不是「类型」。现译「布尔变量是 Lox 里唯一一个用人名命名的数据类型」——「变量」+「数据类型」两个主语混了 | 理顺：「Lox 里唯一以人名命名的数据类型，是布尔值——因为它来自乔治·布尔」 |
| A11 | L350-351 | **核验**：`This is called (imaginatively enough), an expression statement.` 现译「这东西被叫作（名字起得够有想象力的）**表达式语句**」✓ |
| A12 | L405 | **核验**：`we're going to spend a surprising amount of time in later chapters mapping every square inch of the rules` 现译「花惊人的时间来把那些规则一寸一寸地测绘一遍」✓ |
| A13 | L605-607 | **核验**：`about halfway to being a functional language` / `also about halfway to being an object-oriented language` — 两个「一半」要呼应。现译「它离成为一门函数式语言大概也就差一半。但正如你会看到的，它离成为一门面向对象语言，也差不多是差一半。」✓ |
| A14 | L687 | **梗丢失**：`Prototypes *are* simpler... (Classic? Classy?)` — `Classic/Classy` 是双关（classic=经典/classy=时髦），中文无对应。保留英文，并在报告说明 |
| A15 | L705-706 | **梗丢失**：`a constellation of features` / `the brightest stars` — 星座比喻。中文「一大群特征」只留了「最亮的几颗星」的呼应 | 可接受；报告说明 |
| A16 | L762-763 | **核验**：`If you want to access a field or method on the current object from within a method, you use good old `this`.` 现译「如果你想在方法里访问当前对象的某个字段或方法，就用那个老可靠的 `this`」✓ |
| A17 | L859 | **核验**：`goes beyond minimalism and veers close to outright nihilism` 现译「已经不只是极简主义，简直近乎**虚无主义**」✓ |
| A18 | L878 | **核验**：`you can use the implementations of Lox in my repository` 现译「你可以用[我的仓库][repo]里的 Lox 实现」✓ |
| A19 | L40 | **核验**：`As that // line comment and the trailing semicolon imply` 现译「那条 `//` 行注释和结尾的分号已经说明」✓ |
| A20 | L58 | **核验**：`What C-like syntax has instead is something you'll often find more valuable in a language: *familiarity*.` 现译 ✓ |

## (ii) 流畅度

| # | 行 | 问题 | 建议 |
|---|---|---|---|
| B1 | L1 | 引文「对一个人来说，还有什么事能比给他做顿早餐更美的呢？」——「更美的」修饰「事」不通（事情不美）。 | 改「对一个人来说，还有什么事能比给他做顿早餐更让人开心的呢？」或「……比他给你做顿早餐更好的呢？」 |
| B2 | L8 | 「在你还没碰到你的文本编辑器之前」——「碰到编辑器」别扭 | 改「在你还没摸到你的文本编辑器之前」 |
| B3 | L29 | 「Lox 还有另外一层意思，就是那种腌渍的冷熏三文鱼。」——原文 `the cured, cold-smoked salmon`。`cured` = 腌渍 ✓ |
| B4 | L96-99 | 「喜欢静态类型的理由有一大把」✓ 口语 |
| B5 | L110-111 | 「没人会迎着清晨的太阳起床」——原文 `rises and greets the morning sun` 是夸张（把人写成迎接太阳的诗歌角色）。现译保留了这个夸张 ✓ |
| B6 | L113-116 | 「管理内存主要有两种办法」——span 包住「种」，读作「两 种 办法」，span 断开中文双音词是本书既有做法（a-map 有 `<span name="shotgun">**继续扫描**</span>`），可接受 |
| B7 | L121 | 「写屏障眯起眼睛看也有点像 retain 调用」✓ `if you squint` 译出 |
| B8 | L135 | 「组成万物的原子」——原文 `the atoms that make up all matter` ✓ |
| B9 | L176-177 | 「那串看着人畜无害的字符里，藏着相当多的复杂性」✓ `innocuous` |
| B10 | L191-192 | 「空指针错误是我们这行的祸根」✓ `the scourge of our industry` |
| B11 | L279-280 | 「判断两个值**是否都**为真」✓ |
| B12 | L304-306 | 「反过来说（用逆否命题的方式讲？）」✓ Bob 自问自答的味道保住了 |
| B13 | L317-319 | 「运算符动物园」✓ `operator menagerie` |
| B14 | L335 | 「一条 `print` 语句对单个表达式求值」✓ |
| B15 | L398-399 | 见 A1 |
| B16 | L477-478 | 「那个名字就不**调用**函数，只是指代它。」✓ |
| B17 | L496-497 | **术语不一致**：见下方 D1 |
| B18 | L535-536 | 「说白了就是它们是真正的值」✓ |
| B19 | L582-585 | 「必须「抓住」它用到的每一个外层变量的引用」✓ `hold on` |
| B20 | L599-601 | 「你可以想象，实现这些东西会添上一些复杂度」✓ |
| B21 | L614-615 | 见 A4 |
| B22 | L625-626 | **指代模糊**：`prefix all of our functions with the name of the data type they operate on` → 「给我们所有的函数都缀上「它操作的是哪种数据类型」」——「它」指代函数 = 指代代码，违反硬规则 | 改「不用再给每个函数名前面都缀上它所操作的数据类型名」 |
| B23 | L649-651 | 「要在实例上调用一个方法，总归要绕一层间接。」✓ |
| B24 | L663-665 | 「（用原型那一套行话说是「delegate to」）」——**中英夹杂**。`delegate to` 是原型术语 | 改「（用原型那套行话叫「委托给」）」 |
| B25 | L679 | 「它们实现起来非常漂亮」✓ `really neat to implement` |
| B26 | L682 | 「不过我看过的原型式语言代码**多了**去了」——「多了去了」略怪 | 改「我翻过的原型式语言代码**实在太多**了」 |
| B27 | L688-689 | **span 覆盖不足**：`<span name="waterbed">把</span>复杂度**推**给用户`。原文 span 包住 `pushing`，span 只包「把」把宾语甩在外面 | 改 `<span name="waterbed">把复杂度推给</span>用户` |
| B28 | L705 | 「类是一大群特征的集合」✓ |
| B29 | L756 | 「给一个字段赋值，如果它还不存在，就会把它创建出来。」✓ |
| B30 | L759 | 「就用那个老可靠的 `this`」✓ `good old` |
| B31 | L846 | 「我尽量把这个特性集保持在最小。」✓ |
| B32 | L866 | 「然后……就没了。我知道，是吧？挺难堪的。」✓ `It's embarrassing` |
| B33 | L897 | **「它」指代**：`you need to decide what value it evaluates to` ——「它」指「构造」。虽非代码，但读着别扭 | 改「就得为语言里每一个「像语句」的构造决定：求值成什么值。」 |
| B34 | L932 | 「我给它留了语句，理由很俗。」✓ `for prosaic reasons` |
| B35 | L110 | 「没什么能比这更烦人」——`what could be more tedious` 用反问。中文「还有什么能比这更烦人？」缺问号感 | 微调 |

## (iii) 风格

| # | 行 | 问题 | 建议 |
|---|---|---|---|
| C1 | L5-6 | 「一上来就让你埋头给解释器写代码、连我们要造的东西长什么样都不给你看上一眼」✓ 口语 |
| C2 | L43 | 「要是再往北欧家具式的极简走一步」✓ IKEA 梗 |
| C3 | L76-78 | 「但布伦丹·艾奇当初是花**十天**把第一个 JS 解释器硬塞进 Netscape Navigator 的」✓ `*ten days*` → 粗体 |
| C4 | L80 | 「跟一集《百战天龙》（MacGyver）差不多」✓ |
| C5 | L109-111 | 「没人会迎着清晨的太阳起床，然后喊「我等不及要去弄清楚……」」✓ |
| C6 | L129-131 | 「会让你梦里都在看十六进制转储」✓ `seeing hex dumps in your dreams` |
| C7 | L138-139 | 「这次远征我们可能是在凑合着过，但我可不是**野蛮人**」✓ `this expedition` / `*savages*` |
| C8 | L217 | 「C 一族的那个「条件」运算符，或者叫「三目」运算符」✓ |
| C9 | L298 | 「总觉得哪里不对」✓ |
| C10 | L317 | 「由于它们在技术上实在没什么意思」✓ |
| C11 | L439 | 「这是你的派对。」✓ `It's your party.` |
| C12 | L453 | 「Lox 保持基本款。」✓ `Lox keeps it basic` |
| C13 | L486 | 「`funct`、`functi`，或者 `functio`」✓ |
| C14 | L498 | 「把最细的绒毛一根根劈开来辨语义」✓ `splitting the finest of downy hairs` |
| C15 | L529 | 「我早说了 `nil` 会趁我们没留意的时候偷偷溜进来」✓ |
| C16 | L580 | 「这合规吗？」✓ `kosher` |
| C17 | L589 | 「编程语言里几乎一半的术语都是他发明的」✓ `damn near half` |
| C18 | L595 | 「是因为它把自己需要的变量**关**在里面」✓ `closes over` 双关 |
| C19 | L615 | 「那不是跟用八轨磁带发唱片一样吗？」✓ 8-track |
| C20 | L620 | 「他们不可能**全都**错得那么离谱。」✓ |
| C21 | L663 | 「把这两个概念揉到了一起」✓ `merge` |
| C22 | L683 | 「……他们用它们来重新发明类。」✓ |
| C23 | L609 | 「既然类一直因为「没活吹」挨骂」✓ `not living up to their hype` |
| C24 | L634 | 「一个这么普及的范式，被这样漏掉，我挺难过的。」✓ |
| C25 | L636 | 「这世界似乎可以稍微补一点关于怎么**造**一门这样的语言的资料」✓ |
| C26 | L682 | 「包括[我自己设计的一些][finch]」✓ |
| C27 | L726 | 「不过它们一样好玩。」✓ `They are still just as fun` |
| C28 | L859 | 「近乎**虚无主义**」✓ |
| C29 | L866 | 「我知道，是吧？」✓ `I know, right?` |
| C30 | L869 | 「网络、哎呀，甚至**从用户那里读输入**」✓ `heck` |
| C31 | L616 | 「那场「继承全都要」的暴食」——见 A5 |
| C32 | 全章 | **人称专项**：本章讲语言不写实现，「我们造的 Lox」这类施动者是「我们」或「Lox」，无「它」指代代码的句子（B22/B33 是仅有的两处，都已列出） |

## (iv) 术语

| # | 行 | 问题 | 建议 |
|---|---|---|---|
| D1 | L496-497 | **术语自相矛盾**：正文写「有些人对「参数（parameter）」和「实参（argument）」这两个词混用」，但下面的定义把 parameter 定义成**形参**。同一章里 parameter 既是「参数」又是「形参」 | 正文改「有些人对「形参（parameter）」和「实参（argument）」这两个词混用」 |
| D2 | L96 | `static types` = 「静态类型」✓ 术语表有 |
| D3 | L113 | `reference counting` = 「引用计数」✓；`tracing garbage collection` = 「追踪式垃圾回收」✓；`garbage collection` = 「垃圾回收」✓ |
| D4 | L113 | `techniques` 被 span 包住，原译成「两**种**办法」——span 包的是一个普通名词，不是术语。不算错 |
| D5 | L209 | `operands` = 「操作数」✓；`binary` = 「二元」✓ |
| D6 | L211 | `infix/prefix/postfix` = 「中缀/前缀/后缀」✓ |
| D7 | L223 | `mixfix` = 「混缀（mixfix）」✓ 首现标英文 |
| D8 | L304 | `short-circuit` = 「短路」✓ |
| D9 | L353 | `block` = 「块」✓ |
| D10 | L500-504 | `argument/actual parameter` = 「实参/实际参数」✓；`parameter/formal parameters/formals` = 「形参/形式参数/formals」✓ |
| D11 | L535 | `first class` = 「一等公民」✓ |
| D12 | L583 | `closure` = 「闭包」✓ |
| D13 | L655-657 | `static dispatch/dynamic dispatch` = 「静态派发/动态派发」✓ |
| D14 | L693 | `waterbed theory` = 「水床理论」✓ |
| D15 | L815 | `derived class/base class/subclass/superclass` = 「派生类/基类/子类/超类」✓ |
| D16 | L924 | `implicit returns` = 「隐式返回」✓ |
| D17 | L909 | `precedence table` = 「优先级表」✓ |
| D18 | 全章 | **人名**：Anthony Bourdain 安东尼·伯丁 ✓、Dennis Ritchie 丹尼斯·里奇 ✓、Brendan Eich 布伦丹·艾奇 ✓、Peter J. Landin 彼得·兰丁 ✓、Larry Wall 拉里·沃尔 ✓、George Boole 乔治·布尔 ✓。全部音译 ✓ |
| D19 | 全章 | **`_keep_english` 缺项**：本译稿保留了 SML、Racket、CoffeeScript、Netscape Navigator、JavaScript、Scheme、Lua、Ruby、Smalltalk、Racket、Nim… **Racket / SML / CoffeeScript / Smalltalk 未在术语表 `_keep_english` 里**，需补 |
| D20 | 全章 | **术语表待补**：little language / domain-specific language / pidgin / compiler-compiler / self-hosting / bootstrapping / diamond operator / punched card / formal reasoning / type system / reference counting / tracing GC / mixfix / fixity / block scope / lexical scope / first class / prototype / dispatch / metaprogramming / implicit return / grapheme cluster / waterbed theory |
| D21 | L501 | `Sometimes you hear actual parameter used for these.` — `actual parameter` 在中文里也是「实参」，和 argument 同义。译「实际参数」✓ 保留了差异 |

## 中英夹杂专项扫描（扫 `[一-龥]\s+[a-z]{4,}`）

已全部列出并处理：A1–A5（behaving / Lots of / distance / liking / Inheritance）、B24（delegate to）。
其余全部是专名或代码标识符（Lox、Java、C、JavaScript、Scheme、Lua、Perl、PHP、Python、JS、
Netscape Navigator、Racket、Ruby、Smalltalk、CoffeeScript、Lisp、Haskell、C++、C#、Java、OOP、
GC、retain、Nim、formals、BREAKFAST、Bacon、PDF、ASCII、Unicode）。

## 汇总：必须改的 12 条

1. A1 —— L399 `behaving`
2. A2 —— L580 `Lots of`
3. A3 —— L606 `distance`
4. A4 —— L614 `liking`
5. A5 —— L617 `Inheritance 全都要`
6. B22 —— L625-626 「它」指代函数
7. B24 —— L665 `delegate to`
8. B27 —— L688 span 覆盖不足
9. D1 —— L496 parameter 术语自相矛盾
10. A9 —— L900 `case` 未译
11. A10 —— L143 「布尔变量是…数据类型」主语混乱
12. **代码注释未译**（用户明确要求：注释、输出说明要译）

## 代码块处理清单（用户明确要求）

| 行 | 原文 | 性质 | 处理 |
|---|---|---|---|
| L35 | `// Your first Lox program!` | 注释 | **译** |
| L152 | `true;  // Not false.` | 注释 | **译**（`false` 保留代码字体） |
| L153 | `false; // Not *not* false.` | 注释 | **译**（`*` 是代码块内字面量，不动） |
| L163 | `// An integer.` | 注释 | **译** |
| L164 | `// A decimal number.` | 注释 | **译** |
| L172 | `// The empty string.` | 注释 | **译** |
| L173 | `// This is a string, not a number.` | 注释 | **译** |
| L387 / L389 | `// "bagels".` `// "beignets".` | **程序输出** | 不译 |
| L547 | `// Prints "3".` | 输出的**说明** | **译** |
| L731 | `// Store it in variables.` | 注释 | **译** |
| L734 | `// Pass it to functions.` | 注释 | **译** |
| L743 | `// "Breakfast instance".` | **程序输出** | 不译 |
| L787 | `// "Enjoy your bacon and toast, Dear Reader."` | **程序输出** | 不译 |
| L767 / L782 | `// ...` | 占位省略号 | 不译 |
| 全部字符串字面量 | `"Hello, world!"` `"I am a string"` `"One statement."` … | **Lox 程序内容** | 不译 |

## 拿不准、留待报告的

- A7 `Ye Olde Comparison Operators` 的处理
- A14 `Classic? / Classy?` 双关
- A15 星座比喻（constellation / brightest stars）
- B1 Bourdain 引文的最终措辞
- D19/D20 术语表补录
- 《百战天龙》是否为 MacGyver 的通行中译名