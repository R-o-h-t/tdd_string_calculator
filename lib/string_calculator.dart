String? _getDelimiter(String numbers) {
  if (numbers.startsWith('//')) {
    final delimiter = numbers.substring(2, numbers.indexOf('\n'));
    return delimiter;
  }
  return null;
}

int add(String numbers) {
  if (numbers.isEmpty) return 0;

  final List<String> errors = [];

  // extract a custom delimiter
  final delimiter = _getDelimiter(numbers) ?? ',';
  // remove the part of the string that contains the delimiter
  numbers = numbers.replaceAll(RegExp(r'//.*\n'), '');
  // handle new lines as delimiters
  numbers = numbers.replaceAll('\n', delimiter);
  // detect other delimiters (not a number(positive or negative) or the custom delimiter) (word) and get the length of the word
  final otherDelimiters = numbers
      .split(RegExp('[0-9$delimiter-]'))
      .where((element) => element.isNotEmpty)
      .toList();
  if (otherDelimiters.isNotEmpty) {
    errors.add(
        "'$delimiter' expected but '${otherDelimiters.first}' found at position ${numbers.indexOf(otherDelimiters.first)}.");
    // replace the other delimiters with the custom delimiter
    numbers = numbers.replaceAll(RegExp('[^0-9$delimiter-]'), delimiter);
  }

  final numbersList = numbers.split(delimiter);
  // give error if one of the element is empty
  errors.addAll(numbersList
      .asMap()
      .entries
      .where((element) => element.value.isEmpty)
      .map((e) =>
          "'$delimiter' expected but '${numbers[e.key]}' found at position ${e.key}."));

  List<int> numbersInt = numbersList
      .where((element) => element.isNotEmpty)
      .map(int.parse)
      .toList();

  // if negative numbers are found throw an error "Negative number(s) not allowed: <negativeNumbers>"

  final negativeNumbers = numbersInt.where((element) => element < 0).toList();

  if (negativeNumbers.isNotEmpty) {
    errors.add('Negative number(s) not allowed: ${negativeNumbers.join(', ')}');
  }

  // remove > 1000 numbers from the list
  numbersInt = numbersInt.where((element) => element <= 1000).toList();

  if (errors.isNotEmpty) {
    throw FormatException(errors.join('\n'));
  }

  return numbersInt.reduce((value, element) => value + element);
}
