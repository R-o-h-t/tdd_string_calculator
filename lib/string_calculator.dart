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
  throw UnimplementedError();
}

/// Add function
int add(String numbers) {
  if (numbers.isEmpty) {
    return 0;
  }

  final String? customDelimiter = getCustomDelimiter(numbers);
  if (customDelimiter != null) {
    numbers = numbers.substring(numbers.indexOf('\n') + 1);
    numbers = numbers.replaceAll(customDelimiter, ',');
  }

  // Check if the string begins with a delimiter
  if (numbers.startsWith(',') || numbers.startsWith('\n')) {
    throw FormatException('Invalid character found at position 0');
  }
  // Check if the string ends with a delimiter
  if (numbers.endsWith(',') || numbers.endsWith('\n')) {
    throw FormatException(
        'Invalid character found at position ${numbers.length - 1}');
  }
  // Check if the string contains consecutive delimiters
  if (numbers.contains(RegExp(r',\n|\n,'))) {
    // indicate the position of the Invalid character found(the second)
    throw FormatException(
        'Invalid character found at position ${numbers.indexOf(RegExp(r',\n|\n,')) + 1}');
  }

  numbers = numbers.replaceAll('\n', ',');

  final List<int> numbersList = numbers.split(',').map(int.parse).toList();
  return numbersList.reduce((int a, int b) => a + b);
}
