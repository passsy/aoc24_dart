import 'dart:io';

import 'package:test/test.dart';
import '../bin/day03_part1.dart' as day03_part1;
import '../bin/day03_part2.dart' as day03_part2;
import 'main_tester.dart';

void main() {
  group('day 03', () {
    test('sample part 1', () async {
      final output = await testMain(
        day03_part1.main,
        input: File('data/day03_sample.txt').readAsStringSync(),
      );
      expect(output, '4361');
    });
    test('solve part 1', () async {
      final output = await testMain(
        day03_part1.main,
        input: File('data/day03_input.txt').readAsStringSync(),
      );
      expect(output, isNot('0'));
      print(output);
    });
    test('sample part 2', () async {
      final output = await testMain(
        day03_part2.main,
        input: File('data/day03_sample.txt').readAsStringSync(),
      );
      expect(output, '467835');
    });
    test('solve part 2', () async {
      final output = await testMain(
        day03_part2.main,
        input: File('data/day03_input.txt').readAsStringSync(),
      );
      expect(output, isNot('0'));
      print(output);
    });
  });
}
