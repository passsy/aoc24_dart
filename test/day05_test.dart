import 'dart:io';

import 'package:test/test.dart';
import '../bin/day05_part1.dart' as day05_part1;
import '../bin/day05_part2.dart' as day05_part2;
import 'main_tester.dart';

void main() {
  group('Day 05', () {
    group('Part 1', () {
      test('Sample p1', () async {
        final output = await testMain(
          day05_part1.solveDay05,
          input: File('data/day05_sample.txt').readAsStringSync(),
        );
        checkLastLine(output, day05_part1.sampleSolution);
      });
      test('Solution p1', () async {
        final output = await testMain(
          day05_part1.solveDay05,
          input: File('data/day05_input.txt').readAsStringSync(),
        );
        checkLastLineNotZero(output);
      });
    });
    group('Part 2', () {
      test('Sample p2', () async {
        final output = await testMain(
          day05_part2.solveDay05,
          input: File('data/day05_sample.txt').readAsStringSync(),
        );
        checkLastLine(output, day05_part2.sampleSolution);
      });
      test('Solution p2', () async {
        final output = await testMain(
          day05_part2.solveDay05,
          input: File('data/day05_input.txt').readAsStringSync(),
        );
        checkLastLineNotZero(output);
      });
    });
  });
}
