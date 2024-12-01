import 'dart:io';

import 'package:test/test.dart';
import '../bin/day01_part1.dart' as day01_part1;
import '../bin/day01_part2.dart' as day01_part2;
import 'main_tester.dart';

void main() {
  group('Day 01', () {
    group('Part 1', () {
      test('Sample p1', () async {
        final output = await testMain(
          day01_part1.solveDay01,
          input: File('data/day01_sample.txt').readAsStringSync(),
        );
        checkLastLine(output, day01_part1.sampleSolution);
      });
      test('Solution p1', () async {
        final output = await testMain(
          day01_part1.solveDay01,
          input: File('data/day01_input.txt').readAsStringSync(),
        );
        checkLastLineNotZero(output);
      });
    });
    group('Part 2', () {
      test('Sample p2', () async {
        final output = await testMain(
          day01_part2.solveDay01,
          input: File('data/day01_sample.txt').readAsStringSync(),
        );
        checkLastLine(output, day01_part2.sampleSolution);
      });
      test('Solution p2', () async {
        final output = await testMain(
          day01_part2.solveDay01,
          input: File('data/day01_input.txt').readAsStringSync(),
        );
        checkLastLineNotZero(output);
      });
    });
  });
}
