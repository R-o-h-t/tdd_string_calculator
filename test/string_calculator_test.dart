import 'package:string_calculator/string_calculator.dart';
import 'package:test/test.dart';

void main() {
  test(
    'should return 0 for an empty string',
    () {
      expect(add(''), 0);
    },
  );

  test(
    'should return first nb for a single number',
    () {
      expect(add('1'), 1);
    },
  );

  test(
    'should return sum of two numbers',
    () {
      expect(add('1,2'), 3);
    },
  );

  test(
    'should return sum of any number of numbers',
    () {
      expect(add('1,2,3,4,5'), 15);
    },
  );
}
