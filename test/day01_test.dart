import 'dart:io';

import 'package:test/test.dart';
import '../bin/day01_part1.dart' as day01_part1;
import '../bin/day01_part1.dart.golf' as day01_part1_golf;
import '../bin/day01_part2.dart' as day01_part2;
import '../bin/day01_part2.dart.golf' as day01_part2_golf;
import 'main_tester.dart';

void main() {
  group('day 01', () {
    test('sample part 1', () {
      final output = testMain(
        day01_part1.main,
        input: File('data/day01_sample.txt').readAsStringSync(),
      );
      expect(output, '142');
    });
    test('golf part 1', () {
      final output = testMain(
        day01_part1_golf.main,
        input: File('data/day01_sample.txt').readAsStringSync(),
      );
      expect(output, '142');
    });
    test('solve part 1', () {
      final output = testMain(
        day01_part1.main,
        input: File('data/day01_input.txt').readAsStringSync(),
      );
      expect(output, isNot('0'));
      print(output);
    });
    test('sample part 2', () {
      final output = testMain(
        day01_part2.main,
        input: File('data/day01_sample2.txt').readAsStringSync(),
      );
      expect(output, '281');
    });
    test('golf part 2', () {
      final output = testMain(
        day01_part2_golf.main,
        input: File('data/day01_sample2.txt').readAsStringSync(),
      );
      expect(output, '281');
    });
    test('solve part 2', () {
      final output = testMain(
        day01_part2.main,
        input: File('data/day01_input.txt').readAsStringSync(),
      );
      expect(output, isNot('0'));
      print(output);
    });
  });
}
