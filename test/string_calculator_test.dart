import 'package:string_calculator/string_calculator.dart';
import 'package:test/test.dart';

void main() {
  test(
    'should return 0 for an empty string',
    () {
      expect(add(''), 0);
    },
  );
}
