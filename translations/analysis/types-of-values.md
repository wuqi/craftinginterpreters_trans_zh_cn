# 第 18 章「值的类型」译前分析

## 1. 内容与作者意图

- **讲什么**：给 clox 换一套值表示。clox 原本把 `Value` 当 `double` 用，现在改成
  带标签的联合体，并配套一批 `NUMBER_VAL` / `AS_NUMBER` / `IS_NUMBER` 宏，
  再顺带加上 `true` / `false` / `nil` 三个类型。
- **核心论点**：值表示要同时满足「知道自己是什么类型」和「装得下真正的数据」，
  还得为性能留余地（这里留了 16 字节的亏，第 30 章再优化）。
- **作者在干什么**：这是全书从"能跑"转向"像个正经语言"的转折点。前面 14 章虚拟机
  只有数字，这一章开始有类型系统。**Bob 明说了这是他不打算展开的章节**——
  "This is one of those sections of the book that isn't exactly mind-blowing,
  but I promised I'd show you every single line of code"。
- **承接**：接第 17 章（编译表达式）产出的字节码流。
- **钩子**：末尾把字符串留给下一章，"That tiny difference turns out to have
  implications so large that we give strings their very own chapter."

## 2. 术语预判

| 英文 | 译法 | 状态 |
|---|---|---|
| value | 值 | 表内 |
| tagged union | 带标签联合体 | 表内 |
| union / struct | 联合体 / 结构体 | 表内 |
| padding | 填充 | 表内 |
| lexeme | 词素 | 表内 |
| operand | 操作数 | 表内 |
| falsy / falsiness | 假值 / 假值(falsiness) | 表内，需区分 |
| disassembler | 反汇编器 | 表内 |
| unityped | 单一类型 | 表内 |
| naive/desugar | 直译 | **缺**，desugaring 常译「脱糖」 |
| tombstone | 墓碑 | 表内（哈希表章） |
| implicit conversion | 隐式转换 | 旁注内 |
| type punning | 类型双关 | 旁注内 |
| product/sum type | 积类型/和类型 | 旁注内 |
| registry（无） | — | — |

**缺口**：desugaring 没定。本章 `same` 旁注用到（"our desugaring assumes"）。

## 3. 语域判断

- 这一章**偏动手**（大量代码），但作者在**自嘲式地解释**为什么这章很枯燥。
- 幽默集中在：开头引文、union 旁注（"saw your fingers off"）、
  宏旁注（"Now you do!"）、二进制运算符（"yank the ejection seat lever"）、
  short-circuit 处（"we aren't ready for them yet"）、结尾（"Earth-shattering program"）。
- 自嘲集中在 L180 附近和 "Yeah, I realize that's a monster of a macro."、
  "This is pretty self-explanatory."、"You wouldn't believe how much pain I went through"。

## 4. 翻译难点清单

### 4.1 Comprehension gaps（理解落差）

| 位置 | 落差 | 处理 |
|---|---|---|
| L171 universe 旁注的图 | 图是英文标注的（C 的穹顶 / Lox 的天穹） | **retain**，图不改；正文用中文解释配合 |
| `IEEE 754` / NaN | 中文书读者未必知道 NaN 比较的性质 | retain 术语，旁注里已有解释 |
| `tombstone` 墓碑 | 哈希表概念 | substitute，中文「墓碑」是既有说法 |
| `as` 字段命名 | 原文说像 cast | 正文解释即可 |

### 4.2 Figurative language（比喻习语）

| 原文 | 机制 | 处理 | 译法 |
|---|---|---|---|
| A Bear of Very Little Brain 引文 | Think/Thing/Thingish 三词同源 + 反复的 wordplay | **retain 英文词 + substitute 中文表达** | 已查证无公认中译。用「像回事／不是那么回事」让「回事」在中文里自然重复形成呼应 |
| **unityped** | un-typed 的造词（un- → uni-） | **interpret**（用户已定：意译，不要造词） | 单一类型（unityped） |
| "lift a C value into the heavens" | 宗教意象，与 Lox 的命名无关，是作者故意的调侃 | **retain 意象** | 升上天堂／放回人间 |
| "portal to the Shadow Realm, smoldering" | 夸张，暗示 UB 的可怕 | **interpret** | 开了一扇通往影界的门，正熊熊燃烧 |
| "yank the ejection seat lever" | 程序员写错代码 = 自寻死路 | **interpret** | 拉一下弹射座椅的拉杆 |
| "saw your fingers off" | C 的危险，夸张 | **interpret** | 心平气和地把你的手指锯下来 |
| "Earth-shattering program" | 夸张（就一行 `true`） | **interpret** | 「撼动地球」的程序 |
| "Lovecraftian eldritch god" | 夸张贬低 PHP | **interpret** | 洛夫克拉夫丁式的远古邪神 |
| "paranoia"（paranoid runtime type checks） | 自嘲代码冗余 | **interpret** | 疑神疑鬼式的类型检查 |
| "a monster of a macro" | 自嘲宏太长 | **interpret** | 这宏长得有点吓人 |
| "the coda to today's aria" | 音乐比喻 | **retain** | 今天这出戏的尾声 |
| "gutting it"（没有） | — | — | — |

### 4.3 Structural challenges（结构难点）

| 位置 | 难点 | 处理 |
|---|---|---|
| L88 "these two parts" | 指代刚讲完的 struct 和 union | **明确化**，不能让读者回翻 |
| L108 "which only needs to represent" | which 指的是 type tag | 明确化 |
| L152 `The "right type" part is important!` | 中文凑不出「这四个字」 | 删凑数，增译要避免 |
| L327 `it's gratuitous -- and slow! --` | 破折号夹在词中间，中文要用句号断开 | 拆成两句 |
| L427 "The rule for how other types are handled is called falsiness" | falsiness 是**规则名**不是值本身 | 加英文标注区分 falsey / falsiness |
| 全章 | 英文靠 we/it 区分人和代码，中文无此对立 | 见 skill 第 5 节，硬规则：不以「它」指代代码 |
| 全章 | 中文无斜体，原文 *em* 一律译粗体 | 见 skill 第 7 节 |

### 4.4 处理策略汇总

- 引文：查过了，无公认中译，用 substitute 落中文自洽
- 所有夸张／调侃：interpret 保留语气，不稀释
- 所有术语：interact 首现标英文，之后纯中文
- 人称：一律省略主语或以代码名作主语，绝不写「它」指代代码