# 第28章 方法与初始化器 — 反思建议清单（critique）

> 只诊断，一个字都不许改。逐条改完后再回到结构校验，直到清单为空。

## 机器校验（改前跑）

| 项 | 结果 |
|---|---|
| aside | 20 / 20 |
| span | 19 / 19（源文件里 `verify` `return` `through` `floppy` 四个 span 标签跨行，按行统计会漏，须用跨行正则） |
| `##` / `###` | 7/7、11/11 |
| `<img>` | 6 / 6 |
| 代码围栏 | 26 / 26 |
| `^code` 标签 | 57 / 57，顺序一致 |
| `name` 值多重集 | 一致 |
| 链接定义 | 8 / 8 |

## (i) 准确性

1. **span 锚点丢失 3 处**（最严重）。源文件里这三个 `<span>` 标签跨行书写，
   按行统计会误判成「译文多了 span」，实际是**译文漏了**：
   - `<span name="verify">trusts</span>` —— 第 66 段，漏
   - `<span name="return">back</span>` —— 初始化器第 2 条，漏
   - `<span name="juggle">juggle</span>` —— `invoke-from-class` 后面那段，漏
   → 补回，且英文原文这三处没有 `*em*`，span 内**不加粗**。

2. **加粗超译 13 处**。原文这些位置的强调只在 span 内或根本没有强调，中文却加粗了。
   逐条去掉：
   - span `global`「**可能**」/ `load`「**调用**」/ `verify`「**信任**」/ `trace`「**确保**」
   - span `bound`「**「绑定方法」**」/ `through`「**通过**」/ `return`「**拿回来**」
   - span `floppy`「**软盘**」/ `super`「**全新的、专门的**」/ `juggle`「**耍杂技**」
   - span `designer`「**实现者**」
   - 正文自加的：`核心信条`（原文 the core tenets 无强调）、
     `从哪个实例`（[83]、[87] 两处，原文 accessed from 无强调）、
     `自己`（[179]，原文 which is, itself, 无强调）、
     `整个`（[255]，entire 无强调）、
     `下一条`（[258]，very next 无强调）、
     `之前`（[314]，`before` 是普通词，同句被强调的是 `*under*`）、
     `低`（[353]，原文 "a low threshold" 的 low 无强调）
   → 中文 span 内只有 span `series`（「**连串**」）和 span `do`（「**点什么**」）该加粗，
   因为原文那两处确实是 `*series*` / `*do*`。

3. **漏加粗 1 处**。原文 `[298]` `*too* firmly` → 「我们不该**太过**使劲地拍自己的马屁」。

4. **编号列表数字未与原文逐位对齐**。原文三处用 `1./2./3.`，译文全写成 `1.`。
   功能上 `package:markdown` 会自动编号、渲染结果一致，但为可对照，仍改回逐位一致。

## (ii) 流畅度

5. 「**每一份**信息」——原文 "every piece of information"，「每一份」偏公文，
   改「每一点信息」。

6. 「不知怎么地得把它们全查出来」——原文 Somehow the runtime needs to look up and bind
   all of them。中文「不知怎么地」是「无奈」的意思，误读。改「运行时总得想办法把它们
   全查出来并绑定」。

7. 「我们就知道它在哪里」——原文 we don't know，译文少了否定。已在上文发现，
   复核确认是「我们并不知道它在哪里」，保持。

8. 「它们都是在上一个 jlox 解释器里走过一遍的熟地」——「都是熟地」缺主语衔接，
   读着突兀。改「这一整套我们在上一个 jlox 解释器里就走过一遍，都是熟地」→ 再改
   「全都是上一趟 jlox 之旅走过的熟地」。

## (iii) 风格

9. 「那感觉就像拥有了超能力」——原文 It felt like a superpower，保留口语。

10. 「一个类构造函数的函数」——中文里「类构造函数的函数」太拗口且啰嗦。
    原文是 "The constructor-like function"。改「这个构造函数一般的函数」。

11. 「我们**不该太使劲**地」——已按 (i)3 加粗，语气保留。

12. 「别担心」——原文 Fear not，保留原文的调侃口吻。

13. 「把这些拼起来」——原文 Putting all of that together，保留。

14. 「正戏来了」——原文 Here is the good stuff，保留调侃。

15. 「还有**别的**任何东西」——原文 return anything *else*，粗体在 else 上，
    译文要落在「别的」而非整句。检查后正确。

## (iv) 术语

16. `receiver` 全章统一「接收者」，不与 `this` 混用；首次出现不标英文
    （第 28 章前 27 章语境已足）。写回 glossary。

17. `superinstruction` 定为「**超级指令**」；`calling convention` 定为「**调用约定**」；
    `novelty budget` 用 titles.zh.json 已有的「新意预算」；`strangeness budget`
    定为「怪异度预算」；`idiosyncrasy credit` 定为「异类信用」。全部写回 glossary。

18. Steve Klabnik 音译「史蒂夫·克拉布尼克」，写进 `_names`。

19. 强调标记全书零斜体：译后扫描 `*x*` 应为 0（脚本已验）。

20. 中文链接文本全部用具名引用，无空引用 `[]`（脚本已验）。

## 待复查（第 26 章方式：逐段零差异）

改完后重跑脚本，要求「mismatched paragraphs: 0」。
