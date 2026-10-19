# 第19章《字符串》译前分析

## 3.1 内容与作者

- **讲什么**：把字符串加进 clox。两级值表示（Value + 堆上 Obj）；用**结构体继承**让
  ObjString「是」一个 Obj；`copyString`/`allocateString`/`takeString` 三件套；
  字符串打印、值相等、`+` 拼接；最后用**侵入式链表**登记所有 Obj 并在退出时全部释放。
- **作者意图**：字符串是「大小可变、堆分配」的第一种类型，本章为后面所有堆对象
  （实例、函数、闭包）立起内存管理骨架，并为第20章哈希表铺路。
- **钩子**：开头承接第18章值类型；结尾「哈希表……那是下一章的事」。设计说明讲字符串编码。

## 3.2 术语预判（对照 glossary）

| 英文 | 定译 | 备注 |
|---|---|---|
| heap | 堆 | 新增 |
| dynamic allocation | 动态分配 | 新增 |
| struct inheritance | 结构体继承 | 新增 |
| type punning | 类型双关 | 已有（链接文本）|
| intrusive list | 侵入式链表 | 新增 |
| flexible array members | 柔性数组成员 | 新增 |
| concatenation / concatenate | 拼接 | 新增 |
| memory leak | 内存泄漏 | 新增 |
| code point | 码点 | 新增 |
| combining characters | 组合字符 | 新增 |
| extended grapheme cluster | 扩展字形簇 | 新增 |
| surrogate pairs | 代理对 | 新增 |
| crosscutting concern | 横切关注点 | 新增 |
| payload / tagged union / downcast | 载荷 / 带标签联合体 / 向下转型 | 已有 |
| garbage collector | 垃圾回收器 | 已有 |
| Obj / ObjString / Value / ValueType | 保留原样，正常字体 | style guide |
| ASCII / Unicode / UTF-8/16/32 | 保留 | keep_english |

人名音译：Tad Williams→泰德·威廉姆斯。
书名：*The Dragonbone Chair* →《龙骨椅》（Tad Williams《回忆、悲伤与荆棘》卷一）。

## 3.3 语域判断

**动手为主**，`^code` 47 处。幽默集中：

- `natch`（of course 的口语）→「当然啦」
- 旁注：`objs` 怎么念都不对
- 旁注：`Voilà` vs `viola`（作者自曝花两小时画中提琴）
- 旁注：终止符「我跟你说过会用得上的」
- 设计说明：`Gruyère`/`Mötley Crüe`「不值得用的语言」；💩 PILE OF POO

## 3.4 翻译难点清单

| 类别 | 原文 | 处理 |
|---|---|---|
| 引用 | 章首 Tad Williams | 无通行中译本→直译（《龙骨椅》）|
| 引用 | C99 规范 §6.7.2.1 段 | 无权威中译可核→忠实直译，保留题号 |
| 双关 | `Voilà` / `viola` | retain 原文拼写 + 解释（法语「瞧，成了」/ 中提琴）|
| 口语 | `natch` | 「当然啦」|
| 比喻 | `you get the idea` | 「你懂的」|
| 比喻 | `sea of helper functions` | 「一大堆辅助函数」|
| 比喻 | `living on borrowed time` | 「活在借来的时间里」|
| 比喻 | `squirrel away a reference` | 「把引用藏起来」|
| 比喻 | `Behold this innocuous-seeming expression` | 「瞧瞧这个看似人畜无害的表达式」|
| 习语 | `barf on the new value type` | 「遇到新值类型时不至于吐出来」|
| 结构 | 字节码清单、C 代码、`OP_ADD` | 原样保留 |
| 结构 | `<span name="viola">*Voilà*</span>` | →`**Voilà**`（保留法语）|
| 结构 | `<img>` alt 全译（含 viola、stack）| |

## 3.5 结构基线（待机器校验）

- asides 15：pascal/short/objs/spec/escape/terminator/factored/viola/term-2/convert/
  stack/borrowed/free/gruyere/python（名值各 x2，与 span 一一对应）
- spans 15、img 5（pstring/value/obj/viola/stack）、`^code` 47、
  `## ` 7（含设计说明）、`### ` 1、challenges + design-note 两个 div
- 链接：gc / pun / hash / vm / ascii / unicode / wren / flexible array members / hash table

## 3.6 字形提醒

本章新增生僻字与符号：💩、ä、¨、ü、é、ï、ñ、Gruyère、Mötley、naïve 等拉丁扩展字符，
以及「俩」等。子集化脚本在章节构建**之后**重跑，以确保覆盖（`util/subset_fonts.py`）。
