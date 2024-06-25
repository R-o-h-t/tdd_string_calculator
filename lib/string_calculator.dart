int add(String numbers) {
  if (numbers.isEmpty) {
    return 0;
  }

  // handle specifying a delimiter
  // "//[delimiter]\n[numbers]"
  if (numbers.startsWith('//')) {
    // take the delimiter (between the // and the \n)
    final delimiter = numbers.substring(2, numbers.indexOf('\n'));
    numbers = numbers.substring(numbers.indexOf('\n') + 1);
    // replace the delimiter with a comma
    numbers = numbers.replaceAll(delimiter, ',');
  }

  // handle new lines as delimiters
  numbers = numbers.replaceAll('\n', ',');
  final numbersList = numbers.split(',');
  // give error if multiple delimiters are found together
  if (numbersList.contains('')) {
    throw FormatException('Invalid input');
  }

  return numbersList.map(int.parse).reduce((a, b) => a + b);
}
