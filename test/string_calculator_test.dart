import 'package:string_calculator/string_calculator.dart';
import 'package:test/test.dart';

void main() {
  /// function should return 0 if the string is empty
  test('should return 0 if the string is empty', () {
    expect(add(''), 0);
  });

  /// function should return the number if the string contains only one number
  test('should return the number if the string contains only one number', () {
    expect(add('1'), 1);
  });

  /// function should return the sum of two numbers if the string contains two numbers
  test(
      'should return the sum of two numbers if the string contains two numbers',
      () {
    expect(add('1,2'), 3);
  });
}
