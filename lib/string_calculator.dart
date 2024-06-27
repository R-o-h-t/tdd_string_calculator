/// Add function
int add(String numbers) {
  if (numbers.isEmpty) {
    return 0;
  }
  // Check if the string begins with a delimiter
  if (numbers.startsWith(',') || numbers.startsWith('\n')) {
    throw FormatException('Invalid delimiter at position 0');
  }
  // Check if the string ends with a delimiter
  if (numbers.endsWith(',') || numbers.endsWith('\n')) {
    throw FormatException(
        'Invalid delimiter at position ${numbers.length - 1}');
  }
  // Check if the string contains consecutive delimiters
  if (numbers.contains(RegExp(r',\n|\n,'))) {
    // indicate the position of the invalid delimiter (the second)
    throw FormatException(
        'Invalid delimiter at position ${numbers.indexOf(RegExp(r',\n|\n,')) + 1}');
  }

  numbers = numbers.replaceAll('\n', ',');

  final List<int> numbersList = numbers.split(',').map(int.parse).toList();
  return numbersList.reduce((int a, int b) => a + b);
}
