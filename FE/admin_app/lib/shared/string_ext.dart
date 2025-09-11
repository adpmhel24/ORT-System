extension StringCasingExtension on String {
  /// Converts "hello world" to "helloWorld"
  String toCamelCase() {
    final words = _splitWords(this);
    if (words.isEmpty) return '';
    return words.first.toLowerCase() +
        words
            .skip(1)
            .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase())
            .join();
  }

  String capitalize() =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';

  /// Converts "hello world" to "Hello World"
  String toTitleCase() {
    final words = _splitWords(this);
    return words
        .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase())
        .join(' ');
  }

  List<String> _splitWords(String input) {
    // Replace _ and - with space, then split
    return input
        .replaceAll(RegExp(r'[_\-]'), ' ')
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .toList();
  }

  String toSpacedTitleCase() {
    // Insert space before each uppercase letter (not at the start)
    final spaced = replaceAllMapped(
      RegExp(r'(?<!^)([A-Z])'),
      (Match m) => ' ${m.group(1)}',
    );

    // Capitalize first letter of each word
    return spaced
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}
