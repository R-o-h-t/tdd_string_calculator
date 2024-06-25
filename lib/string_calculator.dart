int add(String numbers) {
  if (numbers.isEmpty) {
    return 0;
  }
  final numbersList = numbers.split(',');
  return numbersList.map(int.parse).reduce((a, b) => a + b);
}
