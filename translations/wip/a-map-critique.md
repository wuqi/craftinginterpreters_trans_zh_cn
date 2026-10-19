# 第2章 critique（只诊断，不改稿）

对象：`book/a-map-of-the-territory.md`
原文：`craftinginterpreters/book/a-map-of-the-territory.md`
基线：构建 5336 行；aside 34/34、span 34/34、name 34/34、img 10/10、链接 26/26。

## 一、准确性

1. **L25 `海军中将`**：Rear Admiral 是美国海军少将（O-8），不是中将（Vice Admiral）。
2. **L236、L238 `尼克劳斯·沃思`**：术语表 `Niklaus Wirth` 定为「尼克劳斯·维尔特」，
   且 `chunks-of-bytecode.md`、`compiling-expressions.md` 均已用「维尔特」。本章漂移，须统一。
3. **L322–324 前向声明逻辑反了**：原文是「不能在该函数定义之前调用它」，
   译文「不能调用在它上方定义的函数」意思相反（定义在上方本来就可以调用）。
4. **L363 `要算计算机科学界的悲剧英雄，他是第一个`**：原文 `a tragic hero ... if there
   ever was one` 是「绝对算得上一个」，不是「他是第一个」。
5. **L367–368 漏译 + 误译**：`Kris Kristofferson-esque look sported by dashing bearded
   dudes in the '80s` 被压成「风度翩翩的络腮胡的样子」。丢了克里斯托弗森这个具体参照，
   也把「留胡子的帅哥」写成了「胡子的样子」。
6. **L443 漏译**：`on the other hand`、`plant-based foods`、`as far as I can tell`
   三层意思都没了，只剩「既不是水果也不是蔬菜」。
7. **L208 `代码生成器`**：原文 `code gen` 是 `code generation` 的简称，不是「生成器」这个工具。
8. **L287–288 `` `instanceof` ``**：原文是带引号的 `"instance of" tests`，不是代码标识符；
   用代码字体并写成 `instanceof`（Java 关键字）不准确。
9. **L31 `CS 论文里零引用的那些巷子`**：原文是「零引用 CS 论文构成的死胡同」，
   译文把「论文」和「巷子」的修饰关系弄反了。
10. **L339 `Koichi Sasada`**：读者可检索人名应音译（笹田耕一），且全书没有保留英文的先例。
11. **L75、84、85、88、90、307、462、466**：`解析` / `解析器` 单用，未按术语表写成
    `语法解析` / `语法解析器`，与全书冲突（parse ≠ resolve）。
12. **L9 `立个简写`**：`establish a shorthand` 是「约定一个简写」，`立` 搭配不成立。
13. **L74 `一副文法`**：量词应为「一部文法」。
14. **L129 `威廉·沃尔夫一行人`**：`and company` 是「等人」，`一行人` 指同行旅客，误用。
15. **L169 `充分理由`**：`another big reason` 是「另一个重要原因」，不是「充分理由」。
16. **L305 `产出输出代码`**：语义重复；原文是 `produce output code directly in the parser`。
17. **L246–247 `没有芯片说那种字节码的语言`**：`speaks that bytecode` 的拟人没落地，
    中文读着像「芯片说一种语言」，建议「没有哪块芯片懂那种字节码」。
18. **L273–274**：`physically allocate` 的 `physically` 丢了；「拥有一台自己服务器」缺「的」。
19. **L114 `俯瞰用户的程序`**：原文 `a sweeping view` 的全景感被压掉，可补「尽收眼底」。
20. **L6–7 `前人踏勘过`**：原文限定是 `previous language implementers`，「前人」过泛。

## 二、流畅度 / 风格

1. **L52–54**：`也叫词法分析（lexing），或者（如果你想唬住谁）词法分析（lexical
   analysis）` 三个名字在中文里撞成两个「词法分析」。括号标英文后已能读懂，但句子仍绕；
   可断成两句：「也叫**词法分析**（lexing）；想唬住谁，就说**lexical analysis**（还是词法分析）。」
2. **L266–267 `把你的 VM 用比如 C 实现`**：典型翻译腔，改「用 C 之类的语言实现你的 VM」。
3. **L31**：三个「那些/那些」堆叠，读着拖；顺一下即可。
4. **L322–324**：句子本身太长，修逻辑时一并拆短。

## 三、术语 / 结构

- `parse tree` 本章与第5章都处理成「语法树（parse tree）」，保持现状，不单独改。
- 强调标记：本轮已按原文逐段对齐；剩余差异只有书名/外文词的斜体（《魔戒》等），
  按既定决策不转粗体。
- 结构数字无差异，无需改动。

## 四、处理顺序

先改准确性 1–20，再顺流畅度 1–4；改完重跑结构校验与强调逐段比对，最后通读润色。
