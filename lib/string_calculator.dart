/// Add function
int add(String numbers) {
  if (numbers.isEmpty) {
    return 0;
  }
  numbers = numbers.replaceAll('\n', ',');

  final List<int> numbersList = numbers.split(',').map(int.parse).toList();
  return numbersList.reduce((int a, int b) => a + b);
}
