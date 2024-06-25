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

  test(
    'should handle new lines as delimiters',
    () {
      expect(add('1\n2,3'), 6);
    },
  );

  test(
    'should throw an exception if multiple delimiters are found together',
    () {
      expect(() => add('1,\n2'), throwsFormatException);
    },
  );

  test(
    'should throw an exception if separator is at the end',
    () {
      expect(() => add('1,'), throwsFormatException);
    },
  );

  // handle any other delimiters, the delimiters must be specified at the beginning of the string : //[delimiter]\n[numbers]
  test(
    'should handle any other delimiters',
    () {
      expect(add('//;\n1;2'), 3);
      expect(add('//|\n1|2|3'), 6);
      expect(add('//sep\n2sep3'), 5);
    },
  );

  // if a delimiter is specified , only this delimiter should be used
  test(
    'should throw an exception if a delimiter is specified and another delimiter is found and indicate the position',
    () {
      expect(
        () => add('//|\n1|2,3'),
        throwsA(
          isA<FormatException>().having(
            (e) => e.message,
            'error message',
            equals("'|' expected but ',' found at position 3."),
          ),
        ),
      );
    },
  );

  // Calling add with negative numbers will return the message 'Negative number(s) not allowed: <negativeNumbers>'
  test(
    'should throw an exception if negative numbers are found',
    () {
      expect(
        () => add('1,-2,-3'),
        throwsA(
          isA<FormatException>().having(
            (e) => e.message,
            'error message',
            equals('Negative number(s) not allowed: -2, -3'),
          ),
        ),
      );
    },
  );

  // if multiple error are found, the message should indicate
  // all the errors that were found separated by new lines
  test(
    'should throw an exception if multiple errors are found',
    () {
      expect(
        () => add('//|\n1|2,-3,4,-5'),
        throwsA(
          isA<FormatException>().having(
            (e) => e.message,
            'error message',
            equals(
              "'|' expected but ',' found at position 3.\nNegative number(s) not allowed: -3, -5",
            ),
          ),
        ),
      );
    },
  );

  // if a number is bigger than 1000, it should be ignored
  test(
    'should ignore numbers bigger than 1000',
    () {
      expect(add('2,1001'), 2);
    },
  );
}
