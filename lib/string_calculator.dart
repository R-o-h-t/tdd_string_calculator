/// Add function
int add(String numbers) {
  if (numbers.isEmpty) {
    return 0;
  }
  numbers = numbers.replaceAll('\n', ',');
  if (numbers.contains(',,')) {
    throw FormatException(
        'Invalid delimiter at position ${numbers.indexOf(',,') + 1}');
  }
  if (numbers.startsWith(',')) {
    throw FormatException('Invalid delimiter at position 0');
  }
  if (numbers.endsWith(',')) {
    throw FormatException(
        'Invalid delimiter at position ${numbers.length - 1}');
  }

  final List<int> numbersList = numbers.split(',').map(int.parse).toList();
  return numbersList.reduce((int a, int b) => a + b);
}
