String? getCustomDelimiter(String numbers) {
  if (numbers.startsWith('//')) {
    final int delimiterEnd = numbers.indexOf('\n');
    final String delimiter = numbers.substring(2, delimiterEnd);
    return delimiter;
  }
  return null;
}

/// find the position of the invalid character
/// invalid character is a non digit character that is not a delimiter, a delimiter placed at the beginning or end of the string, or consecutive delimiters
/// [numbers] the string to check
/// [delimiter] the delimiter used in the string , default is ','
int invalidCharacter(
  String numbers, {
  String delimiter = ',',
}) {
  // Return -1 immediately if the input string is empty
  if (numbers.isEmpty) return -1;

  // Check if the string starts or ends with the delimiter
  if (numbers.startsWith(delimiter) || numbers.endsWith(delimiter)) {
    return numbers.startsWith(delimiter) ? 0 : numbers.length - 1;
  }

  // Create RegExp objects once and reuse
  final doubleDelimiterRegExp = RegExp(RegExp.escape(delimiter) + r'{2,}');
  final invalidCharRegExp = RegExp(r'[^0-9' + RegExp.escape(delimiter) + r']');

  // Check for consecutive delimiters
  if (numbers.contains(doubleDelimiterRegExp)) {
    return numbers.indexOf(doubleDelimiterRegExp) + 1;
  }

  // Check for any character that is not a number or the delimiter
  if (numbers.contains(invalidCharRegExp)) {
    return numbers.indexOf(invalidCharRegExp);
  }

  // If none of the conditions are met, return -1
  return -1;
}

/// Add function
int add(String numbers) {
  if (numbers.isEmpty) return 0;

  String? delimiter = getCustomDelimiter(numbers);
  if (delimiter != null) {
    numbers = numbers.substring(numbers.indexOf('\n') + 1);
  } else {
    numbers = numbers.replaceAll('\n', ',');
    delimiter = ',';
  }

  final int invalidCharIndex = invalidCharacter(numbers, delimiter: delimiter);
  if (invalidCharIndex != -1) {
    throw FormatException(
      'Invalid character found at position $invalidCharIndex',
      numbers,
      invalidCharIndex,
    );
  }

  final List<String> numberList = numbers.split(delimiter);
  return numberList
      .map((number) => int.parse(number))
      .reduce((value, element) => value + element);
}
