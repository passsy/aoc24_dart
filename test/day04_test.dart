import 'dart:io';

import 'package:test/test.dart';
import '../bin/day04_part1.dart' as day04_part1;
import '../bin/day04_part2.dart' as day04_part2;
import 'main_tester.dart';

void main() {
  group('day 04', () {
    test('sample part 1', () {
      final output = testMain(
        day04_part1.main,
        input: File('data/day04_sample.txt').readAsStringSync(),
      );
      expect(output, '13');
    });
    test('solve part 1', () {
      final output = testMain(
        day04_part1.main,
        input: File('data/day04_input.txt').readAsStringSync(),
      );
      expect(output, isNot('0'));
      print(output);
    });
    test('sample part 2', () {
      final output = testMain(
        day04_part2.main,
        input: File('data/day04_sample.txt').readAsStringSync(),
      );
      expect(output, '30');
    });
    test('solve part 2', () {
      final output = testMain(
        day04_part2.main,
        input: File('data/day04_input.txt').readAsStringSync(),
      );
      expect(output, isNot('0'));
      print(output);
    });
  });
}
