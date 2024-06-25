int add(String numbers) {
  if (numbers.isEmpty) {
    return 0;
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
