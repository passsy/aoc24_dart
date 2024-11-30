import 'dart:io';

import 'package:test/test.dart';
import '../bin/day01_part1.dart' as day01_part1;
import '../bin/day01_part2.dart' as day01_part2;
import 'main_tester.dart';

void main() {
  group('day 01', () {
    test('sample part 1', () async {
      final output = await testMain(
        day01_part1.main,
        input: File('data/day01_sample.txt').readAsStringSync(),
      );
      expect(output, '100');
    });
    test('solve part 1', () async {
      final output = await testMain(
        day01_part1.main,
        input: File('data/day01_input.txt').readAsStringSync(),
      );
      expect(output, isNot('0'));
      print(output);
    });
    test('sample part 2', () async {
      final output = await testMain(
        day01_part2.main,
        input: File('data/day01_sample.txt').readAsStringSync(),
      );
      expect(output, '100');
    });
    test('solve part 2', () async {
      final output = await testMain(
        day01_part2.main,
        input: File('data/day01_input.txt').readAsStringSync(),
      );
      expect(output, isNot(contains('\n')));
      expect(output, isNot('0'));
      print(output);
    });  });
}
