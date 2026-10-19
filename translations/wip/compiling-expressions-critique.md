# 第17章 critique（只诊断，首轮）

## (i) 准确性 / 漏字

- 「连汗都不出一滴」略生硬，改「连一滴汗都不用出」。
- 其余逐段对照原文，未见漏译（Three reasons、honest-to-God、Four Horsemen、
  peephole、smoke and mirrors、bog-standard 等均有对应）。

## (ii) 流畅度 / 人称（第 5 条硬规则：无「它」作主语指代代码）

- 「它会调用这个：」（指 endCompiler 代码片段，无先行词）→「里面会调用这个：」
- 「它调用的 `expression()`」→「`unary()` 调用的 `expression()`」
- 「它就会错误地把 `-`…」→「`expression()` 就会错误地把…」
- 「它一跑，产出的值就会落在栈上」→「那段代码一跑…」
- 「它只是返回给定下标处的规则」（getRule 函数）→「这个函数只是返回…」
- 「它消费掉它需要的其他词法单元」（中缀解析器）→「中缀解析器消费掉…」

（`advance()`、`consume()`、`emitByte()` 段中的「它」因先行词为紧邻的「这个函数」，
判定可接受，保留。）

## (iii) 风格

- 调侃/比喻均保留：先吃蔬菜、江湖地位、口耳相传、天启四骑士、障眼法、
  手里只有锤子看什么都像钉子、编译器-编译器的递归玩笑、巨兽、PDP-11、其貌不扬。
- 强调标记全为 `**粗体**`，无斜体；`*three*`→**三个**、`*compiler*`→**编译器**、
  `*mixfix*`→**mixfix**、`*-fix*`→**-fix**、`*prefix*`/`*infix*` 等均正确。

## (iv) 术语 / 结构

- 结构数字全部与原文一致：aside 17/17、span 16/16、img 6/6、`## ` 9/9、
  `### ` 5/5、div 2/2、`^code` 45/45 行逐字一致、`name` 值集合一致。
- 链接：`[globals]`、`[bytecode]`、`[next]`、`[blog]` 均在；中文链接文本
  `[几章之后加上语句][globals]`、`[前面某一章][bytecode]`、`[下一章][next]` 用具名引用。
- `--` 均已转 `——`；省略号用 `……`。
- `<aside name="typedef" class="bottom">` 的 `class` 属性、connections aside 内
  两支 `class="arrow"` 箭头图，均原样保留。
