int add(String numbers) {
  if (numbers.isEmpty) {
    return 0;
  }
  final numbersList = numbers.split(',');
  if (numbersList.length == 1) {
    return int.parse(numbersList[0]);
  }
  if (numbersList.length == 2) {
    return int.parse(numbersList[0]) + int.parse(numbersList[1]);
  }
  throw UnimplementedError();
}
