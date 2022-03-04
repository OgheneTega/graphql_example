extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String unslug({String by = "_"}) {
    return replaceAll(by, " ");
  }

  String uppercaseFirst() {
    List arrStr = split(" ");
    String formatted = "";
    for (var part in arrStr) {
      formatted += part.toString().capitalize() + " ";
    }
    return formatted.trim();
  }

  bool isNullOrEmpty() {
    if (toString() == "" || this == "null" || isEmpty) {
      return true;
    }
    return false;
  }

  bool isNumeric() {
    return double.tryParse(this) != null;
  }

  String slugify() {
    String str = toLowerCase().replaceAll("(", "").replaceAll(")", "");
    return str.replaceAll(" ", "_");
  }

  String initials() {
    String initials = "";
    List parts = split(" ");

    if (parts.length > 1) {
      initials = parts[0].toString().substring(0, 1) +
          parts[1].toString().substring(0, 1);
    } else {
      initials = parts[0].toString().substring(0, 2);
    }
    initials = initials.toUpperCase();
    return initials;
  }
}
