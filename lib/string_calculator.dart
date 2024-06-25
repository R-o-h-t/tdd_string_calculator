String? _getDelimiter(String numbers) {
  if (numbers.startsWith('//')) {
    final delimiter = numbers.substring(2, numbers.indexOf('\n'));
    return delimiter;
  }
  return null;
}

int add(String numbers) {
  if (numbers.isEmpty) {
    return 0;
  }

  // if a delimiter is passed, only this delimiter should be used
  final delimiter = _getDelimiter(numbers) ?? ',';
  // remove the delimiter from the string
  numbers = numbers.replaceAll(RegExp(r'//.*\n'), '');

  // handle new lines as delimiters
  numbers = numbers.replaceAll('\n', delimiter);

  // if a non number is found (different from the delimiter), throw an error indicating "[delimiter] expected but [found] found at position [position]"
  if (numbers.contains(RegExp('[^0-9$delimiter-]'))) {
    final position = numbers.indexOf(RegExp('[^0-9$delimiter-]'));
    throw FormatException(
        "'$delimiter' expected but '${numbers[position]}' found at position $position.");
  }

  final numbersList = numbers.split(delimiter);
  // give error if multiple delimiters are found together
  if (numbersList.contains('')) {
    throw FormatException('Invalid input');
  }

  List<int> numbersInt = numbersList.map(int.parse).toList();

  // if negative numbers are found throw an error "Negative number(s) not allowed: <negativeNumbers>"
  final negativeNumbers = numbersInt.where((element) => element < 0).toList();
  if (negativeNumbers.isNotEmpty) {
    throw FormatException(
        'Negative number(s) not allowed: ${negativeNumbers.join(', ')}');
  }

  return numbersInt.reduce((value, element) => value + element);
}
