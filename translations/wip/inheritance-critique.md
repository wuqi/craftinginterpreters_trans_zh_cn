# 第 13 章「继承」自检记录（critique）

## 1. 漏字/缺字

- 逐句核对，形容词、副词、否定词、量词均有对应。
- `half of our inheritance features` → 「我们一半的继承特性」，数量词保留。
- `with no external dependencies or magic tools` → 「没有外部依赖，没有魔法工具」，两个否定都在。
- 数字、专有名词（Doughnut/BostonCream/Cruller/Eclair、`super`/`this`/`inner`、A/B/C）逐个核对无误。

## 2. 通顺

- `You could say all those other languages *inherited* it from Simula. Hey-ooo!` →
  「你可以说，所有别的语言都是从 Simula 那里**继承**来的。哟——！我，呃，自己出去。」冷笑话的
  断点保留，中文可读。
- `Alack and alas` → 「唉，悲哉」，古雅语气保留。
- `Some sort of like how variables in inner scopes shadow outer ones.` 译为「有点像内层作用域里的
  变量遮蔽外层那样」，自然。
- 全文通读无生硬处。

## 3. 强调标记

- 原文 em 32 处（含 2 处跨行：`*Liskov substitution principle*`、`*the class containing the
  super expression*`）+ strong 1 处 = **33 处**。
- 译文加粗 **33 处**，一一对应。
- 全文无斜体残留（代码块内 `*` 属乘法/通配，`*   ` 属列表标记，均保留）。

## 4. 结构完整

| 项 | 原文 | 译文 |
|---|---|---|
| `^code` 标签 | 24 | 24（顺序一致） |
| `<span name=>` | 8 | 8（名字集一致） |
| `<aside name=>` | 8 | 8（名字集一致） |
| `<img>` | 5 | 5 |
| `##` | 5 | 5 |
| `###` | 3 | 3 |
| 链接定义 | 19 | 19（集一致） |

- 空锚点 `<span name="flow"></span>` 原样保留。
- 结尾回顾清单 `* [..][4]`…`[12]`、习题里的 `*   ` 子项，结构与原文一致。
- `<div class="challenges">` 1，闭合一致；本章无 design-note。
- 链接：`[Simula][]`、`[BETA][]` 为英文链接文本的空引用，合法；无中文链接文本用空引用。

## 5. 术语一致

- 新术语写回 glossary：子类、覆盖、单继承、基类/派生类、里氏替换原则、混入（mixin）、
  特质（trait）、虚继承、扩展方法。
- 沿用先例：超类、继承、类型论相关用通用译法。
- 人名音译：特里·普拉切特、克里斯滕·尼加德、奥勒-约翰·达尔、C. A. R. 霍尔、芭芭拉·利斯科夫。
- 书名：A Hat Full of Sky →《帽子里的天空》（人民文学出版社 2005 版，已联网核实）。
