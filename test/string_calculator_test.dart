import 'package:string_calculator/string_calculator.dart';
import 'package:test/test.dart';

void main() {
  /// function should return 0 if the string is empty
  test('should return 0 if the string is empty', () {
    expect(add(''), 0);
  });
}
