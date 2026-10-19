/// Loads the Chinese translation tables used for display strings.
///
/// The build tool keys everything off the original English titles: they
/// determine Markdown paths, HTML filenames, and anchors. Translating those
/// strings directly would silently break snippet extraction and cross-links, so
/// English stays as the internal key and Chinese is layered on top purely for
/// display via the `display_*` template variables.
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

class Translation {
  /// Path to the JSON file holding the translation tables.
  static final String _defaultPath = p.join("translations", "titles.zh.json");

  /// Page title (English) -> display title (Chinese).
  final Map<String, String> pageTitles;

  /// UI strings referenced by the mustache templates.
  final Map<String, String> ui;

  /// Header names that should be treated as the "Challenges" section.
  final Set<String> challengesHeaders;

  /// Prefixes that mark a header as a "Design Note" section.
  final List<String> designNotePrefixes;

  /// Design-note name (English, prefix stripped) -> Chinese display name.
  /// Used so the table of contents reads in Chinese before each chapter's
  /// Markdown has been translated. Once a chapter is translated its heading is
  /// already Chinese and this lookup simply passes it through.
  final Map<String, String> designNotes;

  Translation(this.pageTitles, this.ui, this.challengesHeaders,
      this.designNotePrefixes, this.designNotes);

  /// Loads the translation tables, falling back to an identity (English-only)
  /// translation if the file is missing so the book still builds.
  static Translation load([String path]) {
    path = path ?? _defaultPath;

    Map<String, String> empty = {};

    var file = File(path);
    if (!file.existsSync()) {
      return Translation(empty, empty, {"Challenges"},
          ["Design Note: ", "Design Note:"], empty);
    }

    var json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

    Map<String, String> stringMap(String key) {
      var result = <String, String>{};
      var value = json[key];
      if (value is! Map) return result;
      value.forEach((k, v) {
        if (v is String) result[k as String] = v;
      });
      return result;
    }

    var special = json["special_headers"] as Map<String, dynamic>;
    if (special == null) special = {};

    var challenges =
        (special["challenges"] as List ?? ["Challenges"]).cast<String>();
    var prefixes = (special["design_note_prefixes"] as List ??
            ["Design Note: ", "Design Note:"])
        .cast<String>();

    return Translation(stringMap("pages"), stringMap("ui"),
        challenges.toSet(), prefixes, stringMap("design_notes"));
  }

  /// Returns the Chinese display title for [english], or [english] itself if
  /// there is no translation.
  String title(String english) =>
      pageTitles[english] ?? designNotes[english] ?? english;

  /// Returns a UI string, falling back to [english] when untranslated.
  String uiText(String key, String english) => ui[key] ?? english;
}

/// The translation tables for this build. Loaded once, lazily.
Translation get translations => _translations ??= Translation.load();

Translation _translations;
