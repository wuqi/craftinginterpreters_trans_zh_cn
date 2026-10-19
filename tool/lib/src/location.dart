/// The context in which a line of code appears. The chain of types and
/// functions it's in.
class Location {
  final Location parent;
  final String kind;
  String _name;
  final String signature;

  /// If [kind] is "method" or "function" then this tracks where we are
  /// declaring or defining the function.
  final bool isFunctionDeclaration;

  Location(this.parent, this.kind, this._name,
      {this.signature, this.isFunctionDeclaration = false});

  String get name => _name;

  set name(String value) {
    // Can only set the name if it's an unnamed typedef.
    assert(_name == null);
    _name = value;
  }

  bool get isFile => kind == "file";

  bool get isFunction =>
      const {"constructor", "function", "method"}.contains(kind);

  int get depth {
    var current = this;
    var result = 0;
    while (current != null) {
      result++;
      current = current.parent;
    }
    return result;
  }

  String toString() {
    var result = "$kind $name";
    if (signature != null) result += "($signature)";
    if (parent != null) result = "$parent > $result";
    return result;
  }

  /// Chinese display name for a source location kind.
  String kindName(String kind) {
    switch (kind) {
      case "class":
        return "类";
      case "enum":
        return "枚举";
      case "function":
        return "函数";
      case "interface":
        return "接口";
      case "struct":
        return "结构体";
      case "variable":
        return "变量";
      default:
        return kind;
    }
  }

  /// Generates a string of HTML that describes a snippet at this location,
  /// when following the [preceding] location.
  String toHtml(Location preceding, List<String> removed) {
    if (kind == "new") return "新建文件";
    if (kind == "top") return "加到文件开头";

    // Note: The order of these is highly significant.
    if (kind == "class" && parent?.kind == "class") {
      return "嵌套在类 <em>${parent.name}</em> 里";
    }

    if (isFunction && preceding == this) {
      //  Hack. There's one place where we add a new overload and that shouldn't
      //  be treated as in the same function. But we can't always look at the
      //  signature because there's another place where a change signature would
      //  confuse the build script. So just check for the one-off case here.
      if (name == "resolve" && signature == "Expr expr") {
        return "加在 <em>${preceding.name}</em>(${preceding.signature}) 之后";
      }

      // We're still inside a function.
      return "在 <em>$name</em>() 内";
    }

    if (isFunction && removed.isNotEmpty) {
      // Hack. We don't appear to be in the middle of a function, but we are
      // replacing lines, so assume we're replacing the entire function.
      return "在${kindName(kind)} <em>$name</em>() 内";
    }

    if (parent == preceding && !preceding.isFile) {
      // We're nested inside a type.
      return "在${kindName(preceding.kind)} <em>${preceding.name}</em> 内";
    }

    if (preceding == this && !isFile) {
      // We're still inside a type.
      return "在${kindName(kind)} <em>$name</em> 内";
    }

    if (preceding.isFunction) {
      // We aren't inside a function, but we do know the preceding one.
      return "加在 <em>${preceding.name}</em>() 之后";
    }

    if (!preceding.isFile) {
      // We aren't inside any function, but we do know what we follow.
      return "加在${kindName(preceding.kind)} <em>${preceding.name}</em> 之后";
    }

    // If we get here, there isn't a useful location to show. The snippet will
    // have enough surrounding context to make it clear. This is usually stuff
    // like imports or includes near the top of the file.
    return null;
  }

  /// Generates a string of InDesign XML that describes a snippet at this
  /// location, when following the [preceding] location.
  ///
  /// This is similar to [toHtml] but uses different tags and places the
  /// signatures inside the tags instead of outside.
  String toXml(Location preceding, List<String> removed) {
    if (kind == "new") return "新建文件";
    if (kind == "top") return "加到文件开头";

    // Note: The order of these is highly significant.
    if (kind == "class" && parent?.kind == "class") {
      return "嵌套在类 <location-type>${parent.name}</location-type> 里";
    }

    if (isFunction && preceding == this) {
      //  Hack. There's one place where we add a new overload and that shouldn't
      //  be treated as in the same function. But we can't always look at the
      //  signature because there's another place where a change signature would
      //  confuse the build script. So just check for the one-off case here.
      if (name == "resolve" && signature == "Expr expr") {
        return "加在 <location-fn>${preceding.name}"
            "(${preceding.signature})</location-fn> 之后";
      }

      // We're still inside a function.
      return "在 <location-fn>$name()</location-fn> 内";
    }

    if (isFunction && removed.isNotEmpty) {
      // Hack. We don't appear to be in the middle of a function, but we are
      // replacing lines, so assume we're replacing the entire function.
      return "在${kindName(kind)} <location-fn>$name()</location-fn> 内";
    }

    if (parent == preceding && !preceding.isFile) {
      // We're nested inside a type.
      return "在${kindName(preceding.kind)} "
          "<location-type>${preceding.name}</location-type> 内";
    }

    if (preceding == this && !isFile) {
      // We're still inside a type.
      return "在${kindName(kind)} <location-type>$name</location-type> 内";
    }

    if (preceding.isFunction) {
      // We aren't inside a function, but we do know the preceding one.
      return "加在 <location-fn>${preceding.name}()</location-fn> 之后";
    }

    if (!preceding.isFile) {
      // We aren't inside any function, but we do know what we follow.
      if (preceding.isFunction) {
        return "加在${kindName(preceding.kind)} "
            "<location-fn>${preceding.name}()</location-fn> 之后";
      } else {
        return "加在${kindName(preceding.kind)} "
            "<location-type>${preceding.name}</location-type> 之后";
      }
    }

    // If we get here, there isn't a useful location to show. The snippet will
    // have enough surrounding context to make it clear. This is usually stuff
    // like imports or includes near the top of the file.
    return null;
  }

  bool operator ==(Object other) {
    // Note: Signature is deliberately not considered part of equality. There's
    // a case in calls-and-functions where the signature of a function changes
    // and it confuses the build script if we treat the signatures as
    // significant.
    return other is Location && kind == other.kind && name == other.name;
  }

  int get hashCode => kind.hashCode ^ name.hashCode;

  /// Discard as many children as needed to get to [depth] parents.
  Location popToDepth(int depth) {
    var current = this;
    var locations = <Location>[];
    while (current != null) {
      locations.add(current);
      current = current.parent;
    }

    // If we are already shallower, there is nothing to pop.
    if (locations.length < depth + 1) return this;

    return locations[locations.length - depth - 1];
  }
}
