# 第20章《哈希表》译前分析

## 3.1 内容与作者

- **讲什么**：为变量查表而实现哈希表。从「桶数组」这个柏拉图式理想出发，逐步引入
  负载因子、冲突、**分离链接法** vs **开放寻址法**、**线性探测**、**哈希函数**（FNV-1a）、
  插入/查找/删除（**墓碑**）、动态扩容与再哈希；最后用**字符串驻留**让 `==` 指针比较成立。
- **作者意图**：第21章「全局变量」需要按名字查值，第22章起大量用到；本章为全书后续
  铺出最核心的数据结构。删除与墓碑讲得细，是作者特意强调的完整性。
- **钩子**：开头承接第19章字符串（需要按名字查值）；结尾「这套哈希表可用来跟踪变量、
  实例或任何键值对」，指向第21章全局变量。

## 3.2 术语预判（对照 glossary）

| 英文 | 定译 | 备注 |
|---|---|---|
| hash table | 哈希表 | 已有 |
| hash function | 哈希函数 | 新增 |
| hash code | 哈希码 | 新增 |
| bucket | 桶 | 新增 |
| entry | 条目（`Entry` 类型名保留）| 新增 |
| key / value | 键 / 值 | 新增 |
| collision | 冲突 | 新增 |
| load factor | 负载因子 | 新增 |
| separate chaining | 分离链接法（separate chaining）| 新增 |
| open addressing | 开放寻址法（open addressing）| 新增 |
| closed hashing | 封闭哈希（closed hashing）| 新增 |
| probing / probe sequence | 探测 / 探测序列 | 新增 |
| linear probing | 线性探测 | 新增 |
| clustering | 聚集 | 新增 |
| tombstone | 墓碑 | 已有 |
| sentinel | 哨兵值 | 已有 |
| string interning / intern | 字符串驻留 / 驻留 | 新增 |
| symbol | 符号 | 新增 |
| birthday paradox | 生日悖论 | 新增 |
| pigeonhole principle | 鸽巢原理 | 新增 |
| deterministic / uniform | 确定性 / 均匀 | 新增 |
| cache line / amortized | 缓存行 / 摊还 | 已有 |
| hash set | 哈希集合 | 新增 |
| FNV-1a / BASIC / Rolodex | FNV-1a 保留；BASIC 保留；Rolodex→旋转名片盒 | |

人名音译：Ambrose Bierce→安布罗斯·比尔斯。
书名：*The Unabridged Devil's Dictionary* →《魔鬼辞典（未删节版）》。
机构：Dartmouth→达特茅斯；Intel 保留。语言：Lua/Lisp/Scheme/Smalltalk/Ruby/Java/C#/Python/C++ 保留。

## 3.3 语域判断

**叙述 + 动手**并重，`^code` 43 处，图 15 张。幽默/比喻：

- 章首比尔斯对「hash」的定义
- 名片堆 / 二分查找 / 旋转名片盒
- BASIC 单字母变量、早期 C 链接器只看前六字符（`strncmp()` 的吐槽、电传打字机）
- 295,148 PB 的数组、「骇人听闻地浪费」
- 旁注：鸽巢原理 + 鸽子的生日 → 26 只鸽子 50% 撞盒
- 旁注：开放/封闭命名的反直觉
- 旁注：`jam` 既是示例键又是「心头好」（hash 函数是某些人的 jam）
- 旁注：墓碑的墓志铭
- 旁注：三者排序「等等，那不是我唯一的理由」

## 3.4 翻译难点清单

| 类别 | 原文 | 处理 |
|---|---|---|
| 引用 | 章首 Bierce | 无通行中译可核→直译 |
| 双关 | `their jam`（呼应示例键 "jam"）| interpret「简直就是他们的心头好」，接受损失 |
| 习语 | `dead simple` | 简单得要命 |
| 习语 | `click into place` | 豁然贯通 |
| 习语 | `bona fide` | 货真价实 |
| 习语 | `happy path` | 走在「快乐路径」上 |
| 习语 | `wrap your head around` | 想明白 |
| 习语 | `losing game` | 必输的买卖 |
| 比喻 | `Platonic ideal data structure` | 柏拉图式的理想数据结构 |
| 比喻 | `folds the larger numeric range onto itself` | 把大的数值范围折叠到自身 |
| 比喻 | `threaded through the bucket array` | 穿在桶数组里 |
| 结构 | 大量 `insert-N`/`delete-N` 图、字节码/C 代码 | 原样保留，alt 翻译 |
| 结构 | `<img ... class="wide">` | 保留 class |

## 3.5 结构基线（待机器校验）

- asides 21：constant/rolodex/basic/bucket/six/power-of-two/pigeon/node/open/probe/
  crypto/scatter/thing/string/75/equal/delete/tombstone/hash-collision/intern/publish
- spans 21（同上，一一对应）、img 15、`^code` 43、`## ` 6、`### ` 9、div 1
- 链接：birthday / pigeon / fnv-1a / equals（strings.html#operations-on-strings）
