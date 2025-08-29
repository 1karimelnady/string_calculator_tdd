import 'package:flutter_test/flutter_test.dart';
import 'package:string_calculator_tdd/string_calculator.dart';


void main() {
  late StringCalculator calc;

  setUp(() {
    calc = StringCalculator();
  });

  test('empty string returns 0', () {
    expect(calc.add(''), equals(0));
  });

  test('single number returns its value', () {
    expect(calc.add('1'), equals(1));
    expect(calc.add('42'), equals(42));
  });

  test('two numbers, comma separated', () {
    expect(calc.add('1,5'), equals(6));
    expect(calc.add('10,20'), equals(30));
  });

  test('handle any amount of numbers', () {
    expect(calc.add('1,2,3,4,5'), equals(15));
  });

  test('newlines are valid separators', () {
    expect(calc.add('1\n2,3'), equals(6));
    expect(calc.add('4\n5\n6'), equals(15));
  });

  test('support custom single-char delimiter declaration', () {
    expect(calc.add('//;\n1;2'), equals(3));
    expect(calc.add('//#\n2#3#4'), equals(9));
  });

  test('support custom multi-char delimiter in brackets', () {
    expect(calc.add('//[***]\n1***2***3'), equals(6));
    // multiple delimiters
    expect(calc.add('//[*][%]\n1*2%3'), equals(6));
  });

  test('negative numbers throw with list of negatives', () {
    expect(() => calc.add('1,-2,3,-4'),
        throwsA(predicate((e) => e is NegativeNumbersException && e.negatives.length == 2 && e.negatives.contains(-2) && e.negatives.contains(-4))));
  });

  test('invalid numbers throw FormatException', () {
    expect(() => calc.add('1,a,3'), throwsA(isA<FormatException>()));
  });
}
