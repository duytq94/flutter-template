class Parser {
  Parser._();

  static String? parseString(dynamic value) {
    if (value is String) {
      return value;
    }
    return null;
  }

  static int? parseInt(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }

  static bool? parseBool(dynamic value) {
    if (value is bool) {
      return value;
    }
    if (value is String) {
      return value == "true"
          ? true
          : value == "false"
              ? false
              : null;
    }
    return null;
  }

  static double? parseDouble(dynamic value) {
    if (value is double) {
      return value;
    }
    if (value is String) {
      return double.tryParse(value);
    }
    if (value is int) {
      return value.toDouble();
    }
    return null;
  }
}
