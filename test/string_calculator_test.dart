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
    expect(add('10'), 10);
  });

  /// function should return the sum of two numbers if the string contains two numbers
  test(
      'should return the sum of two numbers if the string contains two numbers',
      () {
    expect(add('1,2'), 3);
    expect(add('10,20'), 30);
  });

  /// function should return the sum of multiple numbers if the string contains multiple numbers
  /// separated by commas
  test(
      'should return the sum of multiple numbers if the string contains multiple numbers separated by commas',
      () {
    expect(add('1,2,3'), 6);
    expect(add('10,20,30'), 60);
    expect(add('1,2,3,4,5'), 15);
  });

  /// should allow new lines between numbers
  test('should allow new lines between numbers', () {
    expect(add('1\n2,3'), 6);
    expect(add('10\n20\n30'), 60);
    expect(add('1\n2\n3\n4\n5'), 15);
  });

  /// should allow both new lines and commas between numbers in the string
  test('should allow both new lines and commas between numbers in the string',
      () {
    expect(add('1\n2,3'), 6);
    expect(add('10\n20,30'), 60);
    expect(add('1\n2\n3,4\n5'), 15);
  });

  /// should not accept 2 consecutive delimiters
  test('should not accept 2 consecutive delimiters', () {
    expect(() => add('1,\n2'), throwsFormatException);
    expect(() => add('10\n,20'), throwsFormatException);
    expect(() => add('1\n,2\n,3'), throwsFormatException);
  });
}
