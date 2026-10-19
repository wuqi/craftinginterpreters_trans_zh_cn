# 第 13 章「继承」译前分析

## 1. 内容与作者意图

- **讲什么**：给 Lox 的类加上**单继承**——声明超类、继承方法、用 `super` 调用被覆盖的超类方法、
  以及静态检查 `super` 的非法用法。这是 Part II（树遍历解释器）的**最后一章**。
- **核心论点**：继承让子类复用超类的行为；`super` 的查找必须从**包含 `super` 表达式的那个类**的
  超类开始，而非 `this` 的超类。实现上复用环境/闭包机制（与上一章 `this` 一脉相承）。
- **作者在干什么**：收尾。开头点明「这是 Part II 的最后一章」，结尾有一整页回顾清单
  （从词法单元到继承），带明显的里程碑情绪。
- **钩子**：指向 Part III `a-bytecode-virtual-machine.html`（clox）。

## 2. 术语预判

| 英文 | 译法 | 状态 |
|---|---|---|
| inheritance | 继承 | 表内 |
| superclass | 超类 | 表内 |
| subclass | 子类 | **缺，本章定** |
| override / overriding | 覆盖 | **缺，本章定** |
| single inheritance | 单继承 | **缺，本章定** |
| base / derived class | 基类 / 派生类 | **缺，本章定** |
| Liskov substitution principle | 里氏替换原则 | **缺，本章定** |
| super / this / inner | `super` / `this` / `inner`（保留代码） | 代码标识符 |
| mixin / trait / multiple inheritance | mixin / trait / 多重继承（混入等保留英文） | **缺，本章定** |
| virtual inheritance | 虚继承 | **缺，本章定** |
| extension method | 扩展方法 | **缺，本章定** |
| subset / superset | 子集 / 超集 | 通用 |
| type theory | 类型论 | 通用 |
| Doughnut / BostonCream / Cruller / Eclair | 保留英文（代码类名） | 代码标识符 |

人名：Terry Pratchett→特里·普拉切特；Kristen Nygaard→克里斯滕·尼加德；
Ole-Johan Dahl→奥勒-约翰·达尔；C. A. R. Hoare→C. A. R. 霍尔（托尼·霍尔）；
Barbara Liskov→芭芭拉·利斯科夫。

## 3. 语域判断

- **偏设计讨论 + 收尾**，`^code` 24 个，机制推导集中在 Semantics 一节（`super` 的环境链）。
- 幽默/自嘲：
  - 旁注 inherited：「You could say all those other languages *inherited* it from Simula.
    Hey-ooo! I'll, uh, see myself out.」——冷笑话 + 讪讪离场
  - 旁注 rhetorical：「Does anyone even like rhetorical questions?」——反问自嘲
  - 旁注 elegant：「…can't hide the hacks by leaving them as an 'exercise for the reader'.」
  - 「Alack and alas」
  - 结尾「Take a break.」里程碑口吻
  - 旁注 superhero 的 alt「You, being your bad self.」

## 4. 翻译难点清单

### 4.1 Comprehension gaps

| 位置 | 落差 | 处理 |
|---|---|---|
| `super` 从「包含它的那个类」的超类开始查找 | 反直觉，辅以 A/B/C 例 | 照译，保留 `A`/`B`/`C` 代码 |
| 环境链布局：`this` 的环境恰在 `super` 环境内侧 | 依赖上一章闭包机制 | 保留图注、照译 |
| Liskov 替换原则 | 简述 | 首现标英文+链接 |
| BETA 的 `inner`（习题） | 冷门语言 | 保留 `inner`、BETA |

### 4.2 Figurative language

| 原文 | 机制 | 处理 | 译法 |
|---|---|---|---|
| *inherited* it from Simula. Hey-ooo! | 用「继承」自嘲式谐音冷笑话 | interpret | 「都是从 Simula 那里**继承**来的。哟——！」 |
| I'll, uh, see myself out. | 讲完冷笑话讪讪退场 | interpret | 「我，呃，自己出去。」 |
| Alack and alas | 古雅叹词 | interpret | 「唉，悲哉」 |
| rhetorical questions? | 反问自嘲 | retain | 「反问句到底有谁喜欢啊？」 |
| "exercise for the reader" | 教科书套路 | retain | 「留给读者当练习」 |
| bad self | 俚语（了不起的自己） | interpret | alt 里「神气活现的你」 |
| Hey-ooo / bad self 接受损失 | — | — | 记录 |

### 4.3 Structural challenges

| 位置 | 难点 | 处理 |
|---|---|---|
| 全章 | 8 组 span/aside 全是 x2（同名 span+aside） | 名字集合一致即可 |
| 第 582 行 `<span name="superhero">accomplishment</span>` | 强调 + 旁注 | 粗体 + span |
| 结尾回顾清单 | 一组 `* [...]` 列表 + `[4]`..`[12]` 引用 | 数量与原文一致 |
| `*not*` / `*have*` / `*which*` 等 em | 一律粗体 | skill 第 7 节 |
| 书名 | A Hat Full of Sky 无中译 | 自造《满帽子的天空》 |
| 代码注释 | `// General doughnut stuff...` 等 | 翻译；`// Syntax error.` 译；`// ?!` 保留 |

### 4.4 处理策略

- 人称：不以「它」指代代码作主语。
- 强调：一律中文粗体。
- 链接：具名引用原样保留；中文链接文本须用 `[文本][key]`。
- 新术语当场写回 glossary：子类、覆盖、单继承、基类/派生类、里氏替换原则、
  mixin/trait、虚继承、扩展方法。
