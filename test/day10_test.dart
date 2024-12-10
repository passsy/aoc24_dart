import 'dart:io';

import 'package:test/test.dart';
import '../bin/day10_part1.dart' as day10_part1;
import '../bin/day10_part2.dart' as day10_part2;
import 'main_tester.dart';

void main() {
  group('Day 10', () {
    group('Part 1', () {
      test('Sample p1', () async {
        final output = await testMain(
          day10_part1.solveDay10,
          input: File('data/day10_sample.txt').readAsStringSync(),
        );
        checkLastLine(output, day10_part1.sampleSolution);
      });
      test('Solution p1', () async {
        final output = await testMain(
          day10_part1.solveDay10,
          input: File('data/day10_input.txt').readAsStringSync(),
        );
        checkLastLineNotZero(output);
      });
    });
    group('Part 2', () {
      test('Sample p2', () async {
        final output = await testMain(
          day10_part2.solveDay10,
          input: File('data/day10_sample.txt').readAsStringSync(),
        );
        checkLastLine(output, day10_part2.sampleSolution);
      });
      test('Solution p2', () async {
        final output = await testMain(
          day10_part2.solveDay10,
          input: File('data/day10_input.txt').readAsStringSync(),
        );
        checkLastLineNotZero(output);
      });
    });
  });
}
