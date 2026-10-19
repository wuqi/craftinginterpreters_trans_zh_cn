# 第19章 critique（只诊断，首轮）

## (i) 准确性 / 漏字

- 诸段逐句对照原文，未见漏译：两级表示、结构体继承、`+1/-2` 削引号、
  `copyString`/`takeString` 所有权语义、侵入式链表、编码权衡四条，均有对应。
- C99 规范引文、字节码清单、程序输出原样保留。

## (ii) 流畅度 / 人称（第 5 条硬规则：无「它」作主语指代代码）

- 「它从这个值里取出 Obj 指针」→「这个宏从这个值里取出…」（asObj）
- 「它拿一个光秃秃的 Obj 指针」→「这个宏拿…」（OBJ_VAL）
- 「它接收的是一个 Value…它依赖这个内联函数」→「这个宏接收的是…并依赖…」（IS_STRING）
- 「它就会从栈上弹出两个值！」→「结果就会从栈上弹出两个值！」
- 「它在堆上新建一个 ObjString」→「这个函数在堆上新建…」（allocateString）
- 「它存在主要是为了…」→「这个宏存在主要是…」（ALLOCATE_OBJ）
- 「它在堆上分配一个给定大小的对象」→「这个函数在堆上分配…」（allocateObject）
- 「然后它初始化 Obj 状态」→「然后初始化 Obj 状态」
- 「它相当冗长」→「这个函数相当冗长」（concatenate）
- 「它是 `reallocate()` 外面薄薄的…」→「这个宏是 `reallocate()` 外面薄薄的…」（FREE）
- `<span name="factored">跟</span>上一个宏一样` → 让 span 覆盖完整短语「跟上一个宏一样」

## (iii) 风格

- 调侃全部保留：`natch`→当然啦；旁注 objs 怎么念；`Voilà`/`viola` 自曝画中提琴；
  终止符「我跟你说过有用」；「人畜无害的表达式」；「活在借来的时间里」；
  Gruyère/Mötley Crüe「不值得用的语言」；💩 PILE OF POO。
- 强调标记全为 `**粗体**`：`*type punning*`→**[类型双关]**、`*pointer*`→**指针**、
  `*Voilà*`→**Voilà**、`*cannot*`→**不能**、`*free*`→**释放**、`*leaking*`→**泄漏** 等。

## (iv) 术语 / 结构

- 结构数字全对：aside 15/15、span 15/15、img 5/5、`## ` 7/7、`### ` 1/1、div 2/2、
  `^code` 47/47 行逐字一致、`name` 值集合一致。
- 链接：`[gc]`、`[pun]`、`[hash]`、`[vm]`、`[ascii]`、`[unicode]`、`[wren]`、
  `[hash table]`、`[flexible array members]` 均在；中文链接文本用具名引用。
- `-- `→`——`；省略号 `……`；`<aside name="terminator" class="bottom">`、
  `<aside name="convert" class="bottom">`、`<img ... class="wide">`、`class="above"` 均保留。
