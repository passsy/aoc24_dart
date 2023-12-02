import 'dart:io';

import 'package:test/test.dart';
import '../bin/day02_part1.dart' as day02_part1;
import '../bin/day02_part1.dart.golf' as day02_part1_golf;
import '../bin/day02_part2.dart' as day02_part2;
import '../bin/day02_part2.dart.golf' as day02_part2_golf;
import 'main_tester.dart';

void main() {
  group('day 02', () {
    test('sample part 1', () {
      final output = testMain(
        day02_part1.main,
        input: File('data/day02_sample.txt').readAsStringSync(),
      );
      expect(output, '8');
    });
    test('golf part 1', () {
      final output = testMain(
        day02_part1_golf.main,
        input: File('data/day02_sample.txt').readAsStringSync(),
      );
      expect(output, '8');
    });
    test('solve part 1', () {
      final output = testMain(
        day02_part1.main,
        input: File('data/day02_input.txt').readAsStringSync(),
      );
      expect(output, isNot('0'));
      print(output);
    });
    test('sample part 2', () {
      final output = testMain(
        day02_part2.main,
        input: File('data/day02_sample.txt').readAsStringSync(),
      );
      expect(output, '2286');
    });
    test('golf part 2', () {
      final output = testMain(
        day02_part2_golf.main,
        input: File('data/day02_sample.txt').readAsStringSync(),
      );
      expect(output, '2286');
    });
    test('solve part 2', () {
      final output = testMain(
        day02_part2.main,
        input: File('data/day02_input.txt').readAsStringSync(),
      );
      expect(output, isNot('0'));
      print(output);
    });
  });
}
