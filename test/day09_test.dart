import 'dart:io';

import 'package:test/test.dart';
import '../bin/day09_part1.dart' as day09_part1;
import '../bin/day09_part2.dart' as day09_part2;
import 'main_tester.dart';

void main() {
  group('Day 09', () {
    group('Part 1', () {
      test('Sample p1', () async {
        final output = await testMain(
          day09_part1.solveDay09,
          input: File('data/day09_sample.txt').readAsStringSync(),
        );
        checkLastLine(output, day09_part1.sampleSolution);
      });
      test('Solution p1', () async {
        final output = await testMain(
          day09_part1.solveDay09,
          input: File('data/day09_input.txt').readAsStringSync(),
        );
        checkLastLineNotZero(output);
        checkLastLine(output, '6341711060162');
      });
    });
    group('Part 2', () {
      test('Sample p2', () async {
        final output = await testMain(
          day09_part2.solveDay09,
          input: File('data/day09_sample.txt').readAsStringSync(),
        );
        checkLastLine(output, day09_part2.sampleSolution);
      });
      test('Solution p2', () async {
        final output = await testMain(
          day09_part2.solveDay09,
          input: File('data/day09_input.txt').readAsStringSync(),
        );
        checkLastLineNotZero(output);
        checkLastLine(output, '6377400869326');
      });
    });
  });
}
