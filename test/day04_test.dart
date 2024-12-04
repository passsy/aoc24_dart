import 'dart:io';

import 'package:test/test.dart';
import '../bin/day04_part1.dart' as day04_part1;
import '../bin/day04_part2.dart' as day04_part2;
import 'main_tester.dart';

void main() {
  group('Day 04', () {
    group('Part 1', () {
      test('Sample p1', () async {
        final output = await testMain(
          day04_part1.solveDay04,
          input: File('data/day04_sample.txt').readAsStringSync(),
        );
        checkLastLine(output, day04_part1.sampleSolution);
      });
      test('Solution p1', () async {
        final output = await testMain(
          day04_part1.solveDay04,
          input: File('data/day04_input.txt').readAsStringSync(),
        );
        checkLastLineNotZero(output);
      });
    });
    group('Part 2', () {
      test('Sample p2', () async {
        final output = await testMain(
          day04_part2.solveDay04,
          input: File('data/day04_sample.txt').readAsStringSync(),
        );
        checkLastLine(output, day04_part2.sampleSolution);
      });
      test('Solution p2', () async {
        final output = await testMain(
          day04_part2.solveDay04,
          input: File('data/day04_input.txt').readAsStringSync(),
        );
        checkLastLineNotZero(output);
      });
    });
  });
}
