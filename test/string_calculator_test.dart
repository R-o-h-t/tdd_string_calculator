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

  /// the error should indicate the position of the Invalid character found
  test('the error should indicate the position of the Invalid character found',
      () {
    expect(
        () => add('1,\n2'),
        throwsA(predicate((e) =>
            e is FormatException &&
            e.message == 'Invalid character found at position 2')));
    expect(
        () => add('1\n,2'),
        throwsA(predicate((e) =>
            e is FormatException &&
            e.message == 'Invalid character found at position 2')));
  });

  /// throws an error if the string begins with a delimiter
  test('throws an error if the string begins with a delimiter', () {
    expect(
        () => add(',1,2'),
        throwsA(predicate((e) =>
            e is FormatException &&
            e.message == 'Invalid character found at position 0')));
    expect(
        () => add('\n1,2'),
        throwsA(predicate((e) =>
            e is FormatException &&
            e.message == 'Invalid character found at position 0')));
  });

  /// throws an error if the string ends with a delimiter
  test('throws an error if the string ends with a delimiter', () {
    expect(
        () => add('1,2,'),
        throwsA(predicate((e) =>
            e is FormatException &&
            e.message == 'Invalid character found at position 3')));
    expect(
        () => add('1,2\n'),
        throwsA(predicate((e) =>
            e is FormatException &&
            e.message == 'Invalid character found at position 3')));
  });

  /// should find the custom delimiter in the string
  /// and return it
  test('should find the custom delimiter in the string and return it', () {
    expect(getCustomDelimiter('//;\n1;2'), ';');
    expect(getCustomDelimiter('//|\n1|2|3'), '|');
    expect(getCustomDelimiter('//@\n1@2@3@4@5'), '@');
  });

  /// should return null if the string does not contain a custom delimiter
  test('should return null if the string does not contain a custom delimiter',
      () {
    expect(getCustomDelimiter('1,2,3'), null);
    expect(getCustomDelimiter('1\n2\n3'), null);
  });

  /// should use the custom delimiter to split the string
  /// and return the sum of the numbers
  test(
      'should use the custom delimiter to split the string and return the sum of the numbers',
      () {
    expect(add('//;\n1;2'), 3);
    expect(add('//|\n1|2|3'), 6);
    expect(add('//@\n1@2@3@4@5'), 15);
  });

  /// should allow custom delimiters of any length
  test('should allow custom delimiters of any length', () {
    expect(add('//;;;\n1;;;2;;;3'), 6);
    expect(add('//||||\n1||||2||||3'), 6);
    expect(add('//sep\n1sep2sep3'), 6);
  });

  /// should find the position of the invalid character

  /// should return -1 if the string is empty
  test('should return -1 if the string is empty', () {
    expect(invalidCharacter(''), -1);
  });

  /// should return -1 if the string contains only numbers
  test('should return -1 if the string contains only numbers', () {
    expect(invalidCharacter('123'), -1);
  });

  /// should return -1 if the string contains a simple list
  test('should return -1 if the string contains a simple list', () {
    expect(invalidCharacter('1,2,3'), -1);
  });

  /// should return -1 if the string contains a simple list with a custom delimiter
  test(
      'should return -1 if the string contains a simple list with a custom delimiter',
      () {
    expect(invalidCharacter('1|2|3', delimiter: '|'), -1);
  });

  /// return the position of the invalid character : delimiter at the beginning
  test(
      'should return the position of the invalid character : delimiter at the beginning',
      () {
    expect(invalidCharacter(',1,2,3'), 0);
    expect(invalidCharacter('|1|2|3', delimiter: '|'), 0);
  });

  /// return the position of the invalid character : delimiter at the end
  test(
      'should return the position of the invalid character : delimiter at the end',
      () {
    expect(invalidCharacter('1,2,3,'), 5);
    expect(invalidCharacter('1|2|3|', delimiter: '|'), 5);
  });

  /// should return the position of the invalid character : consecutive delimiters
  test(
      'should return the position of the invalid character : consecutive delimiters',
      () {
    expect(invalidCharacter('1,,2,3'), 2);
    expect(invalidCharacter('1||2|3', delimiter: '|'), 2);
  });

  /// should return the position of unexpected exception (neither the delimiter nor a number)
  test(
      'should return the position of unexpected exception (neither the delimiter nor a number)',
      () {
    expect(invalidCharacter('1,2,three'), 4);
    expect(invalidCharacter('1|2|3,4) ', delimiter: '|'), 5);
  });
}
