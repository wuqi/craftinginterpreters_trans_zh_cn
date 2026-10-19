# Crafting Interpreters 简体中文译本

> 在线阅读：<https://wuqi.github.io/craftinginterpreters_trans_zh_cn/>

这是 Bob Nystrom 的《Crafting Interpreters》的**非官方简体中文译本**。全书 40 个章节、
两套完整解释器（jlox / clox）以及附录均已译出，并沿用原书构建工具生成与英文原版同结构的
HTML 页面。

本仓库只包含 `book-zh` 工作区，不包含英文原稿仓库，也不包含社区中文译本仓库。

## 原始项目

本译本基于以下两个仓库：

1. **英文原书与构建系统**（作者 Bob Nystrom）  
   <https://github.com/munificent/craftinginterpreters>  
   在线阅读：<https://craftinginterpreters.com/>

2. **社区中文译本**（术语与译法参考）  
   <https://github.com/GuoYaxiang/craftinginterpreters_zh>  
   本项目的译文为独立重译，仅参考其术语与既有译法，未直接复用其正文。

## 声明与许可

- 原书正文、插图与站点设计的著作权归 **Robert Nystrom** 所有。
- 原仓库采用双许可：`.c` / `.dart` / `.h` / `.java` / `.lox` 等代码文件为 **MIT**；
  正文 `.md`、图片、HTML、样式等为 **CC BY-NC-ND 4.0**。
- 本译本是爱好者制作的非官方衍生译本，**仅供学习交流，不得用于商业用途**。
  若原作者或权利人认为本仓库不妥，请联系删除。
- 本仓库中的代码片段来自原书配套源码，遵循原仓库的 MIT 许可；译文与排版遵循上述
  CC BY-NC-ND 4.0 的精神，不提供任何形式的商业使用授权。

## 目录

```
.
├─ book/            译文 Markdown（40 个文件）
├─ translations/    标题映射、术语表、双关清单、译前分析与过程稿
├─ tool/            Dart 构建器（在原版基础上汉化）
├─ asset/           SCSS 与 Mustache 模板
├─ java/ c/         原书配套源码（代码注释已汉化）
├─ site/            构建产物（即 gh-pages 分支内容）
├─ util/            字体子集化等辅助脚本
├─ LICENSE          原仓库许可说明
└─ Makefile
```

## 本地构建

需要 **Dart 2.x**（工具链尚未迁移到空安全，Dart 3.x 无法编译）。

```powershell
cd book-zh
cd tool
dart pub get
cd ..
dart tool/bin/build.dart          # 生成 site/
dart tool/bin/build.dart --serve  # 本地预览 http://localhost:8000
```

构建成功的标志是输出 `5,336 lines of code`，与英文原版一致。

## 翻译说明

- 正文为纯中文，术语以 `translations/glossary.zh.json` 为准，首次出现标注英文。
- 人名按「读者可能检索者一律音译」处理；代码标识符与私有称呼保留原文。
- 原文的强调一律转为中文粗体，全书不使用斜体；书名用《》。
- 代码不手工翻译：`^code` 标记由构建器从 `java/`、`c/` 源码抽取。
- 双关与口语优先保留效果，必要时造词；处理记录见术语表的 `_puns` 字段。

## 致谢

感谢 Bob Nystrom 写出并免费公开这本书，感谢原书仓库提供的构建系统与源码，
也感谢社区中文译本在术语与译法上提供的参考。

## 反馈

译文难免有疏漏。欢迎通过 Issue 指出错译、漏译或排版问题。
