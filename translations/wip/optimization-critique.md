# 第30章 优化 — 反思建议清单（critique）

## 机器校验

| 项 | 结果 |
|---|---|
| aside / span | 23/23、24/24（含 1 个空 `<span name="equal"></span>`） |
| `##` / `###` | 5/5、10/10 |
| `<img>` | 9 / 9 |
| 代码围栏 | 14 / 14（7 块） |
| 编号列表 | 8 项，逐位一致 |
| 项目符号 | 6 / 6 |
| `class="small-caps"` | 6 / 6（AND×3、OR×2、NOT） |
| `class="bottom"` | 3 / 3 |
| `^code` | 30 / 30，顺序一致 |
| `name` 多重集 | 一致 |
| 链接定义 | 3 / 3 |
| 强调逐段 | **零分歧** |

## (i) 准确性

1. **span 锚点丢 4 处**：`sub`、`hesitate`、`safe`、`domain`。四处的英文
   （improve / hesitated / principle / looking）都**没有**强调，中文 span 内一律不加粗。

2. **加粗超译 6 处**：
   - `再**改进**`（原文 span `sub` 的 improve 无强调）
   - `**批**`（span `batch` 的 batches 无强调）
   - `**犹豫**`（span `hesitate` 无强调）
   - `**完全一样**`（the exact same bytes 无强调）
   - `**原理**`（span `safe` 无强调）
   - `一类你可能会遇到`（原文 `*kind*` 有强调，需落在「类」上）

3. **漏加粗 1 处**：`we'll maintain support for *both*` → 「我们会**同时**维护」。

4. **段落错位（结构错，机器查得出）**：原文「接下来去哪儿」第一条项目符号有**两**段
   （编译器教材 + 动态类型限制），初稿被我并成一段，导致其后 8 段全部错位。
   → 拆回两段。

5. **`*wow.*`** 初稿误写成单星 `*哇*`（书名零斜体规则违规）→ 改 `**哇**`。

6. **`*Engineering a Compiler*` / `*Modern Compiler Implementation*`**：
   书名斜体在中文里由 `《》` 承担，但本项目的做法（见 `garbage-collection.md`
   的 `[**《垃圾回收手册》**][gc book]`）是**再加粗**，既保住强调计数又符合
   「书名用《》不用斜体」。→ 两处都写成 `**《…》**（English）`。

7. **残留英文必须清零**（初稿有 8 处未译的英文碎片）：
   `proliferate` / `market folks` / `wonderful、magical` / `tricks`×2 /
   `a handful` / `Plenty` / `Naturally`。全部换成中文
   （「冒出来」「市场部的人」「了不起的神奇工具」「花招」「一小把」「这地方够宽裕」「不出所料」）。

8. **`[MIT license][]` 空引用** → 改具名引用 `[MIT 许可证][mit license]`。
   `[take either of those interpreters][source]` → 「[随便拿一个解释器去][source]」。

## (ii) 流畅度

9. 「没有自助展开的机制」类长定语一律拆开；例如
   "The effects of changing the value representation are more diffused."
   → 「改变值表示带来的影响要分散得多」。

10. 「值在内存里 scatter 得不够多」→ 原文 scattered around in memory，
    译「散落在内存里」。

11. 「一 handful 重要的数据结构」→ 初稿保留了英文，改「一小把重要的、基础性的数据结构」。

## (iii) 风格

12. 边境牧羊犬那一整套比喻（障碍赛道／犬类生理学／敏捷训练）必须整体保留，
    因为它承担了「不能光靠推理，必须实测」的论证。

13. 「我每年至少犯一次这种错误」——自嘲保留。

14. 「但话又说回来，**哇**。」——短促吐槽保持短促。

15. 「要是在**还不摘到**的时候…」之类的口语调侃保留，不改成书面语。

16. 「顺着编译流水线往下漂」「兔子洞／隧道岔道」两组意象各自保留。

## (iv) 术语

17. `profiler` → 性能分析器，`profiling` → 性能分析（全书统一）。
18. `inclusive time` → 包含时间；首次出现用括号解释。
19. `bit masking` → 位掩码（加粗）；`bit twiddler` → 玩位的人。
20. `NaN boxing` / `NaN tagging` → NaN 装箱 / NaN 标记（加粗）。
21. `fraction / mantissa / significand` → 小数部分 / 尾数 / 有效数，
    **三个并列加粗**（原文就是三个并列加粗的同义词）。
22. `signalling NaN` → 发信号 NaN，`quiet NaN` → 静默 NaN（加粗）。
23. `strict aliasing` → 严格别名（加粗）；`alias` → 别名。
24. `pointer tagging` → 指针标记（加粗）。
25. `dead code elimination` → 死代码消除；`inlining` → 内联；
    `release build` / `debug build` → 发布版 / 调试版。
26. `lower-hanging fruit` → 低垂的果实。
27. 人名与书名全部写回 `_names`：
    石黑一雄、《长日将尽》、戴维·古德曼、
    Cooper 与 Torczon 的**《编译器设计》**（人民邮电出版社，郭旭译，2012）、
    Appel 的**《现代编译器实现》**。
28. SunSpider、WebKit、V8、Octane、MIT 许可证保留英文。

## Polish

29. 通读一遍，只调了断行、残留英文和强调位置；术语与结构未动。
