# 第22章 critique（首轮，发现并已修）

## (i) 准确性

- 逐段对照原文，未见漏译：栈表示、locals 数组与 scope depth、块语句、声明/定义两阶段、
  `OP_GET_LOCAL`/`OP_SET_LOCAL`、调试器问题、静态类型作趋势例证。
- 数字（256、BCPL、Algol 60/58）与专名（Shakespeare / Lox / Rust / Scheme 等）核对无误。

## (ii) 流畅度 / 人称（第 5 条硬规则）

- 检查无「它」作主语指代代码的情形；必要处已改为「编译器/这个函数/我们」。

## (iii) 风格

- 调侃全保留：「立足全球，眼观局部」冷笑话、「快得美味」、多线程下全局变量是「**坏**主意」、
  Algol 58 的「语句括号」、煤渣方块、变量像幽灵赖着不走、「连 Scheme 都不是」、
  「优化器工具箱里最大的锤子之一」、「一长串皱褶」。

## (iv) 结构（本轮重点：初稿漏了 8 个 aside）

初稿把 `harmony`（span 侧误用粗体）、`thread`、`rust`、`negative`、`hash`、`pop`、
`slot`、`debug`、`elegant`、`static` 这些旁注的内容误当正文内联，或丢了 `<aside>` 包裹，
导致 aside 17≠18、span 失配。已在 revision 全部修复：

- `**相安无事**`→`<span name="harmony">`，`**原则**`→`<span name="thread">`，
  `**优雅**`→`<span name="elegant">`，`**趋势**`→`<span name="static">`（还原 span 锚点）
- `rust` / `negative` / `hash` / `pop` / `elegant` / `debug` / `slot` / `static`
  八处恢复 `<aside name=...>` 包裹
- `slot` 旁注内的 `[reg]` 链接定义随之回到旁注内（符合 TRANSLATION_SKILL 第②条）

修复后：aside 18/18、span 15/15、`name` 值集合完全一致、`^code` 33/33 逐字一致、
img 5/5、`## ` 5/5、`### ` 2/2、div 1/1；链接定义 `last chapter`/`functions`/`reg`/`shadow`
各 1 处，无半角省略号/`--`。
