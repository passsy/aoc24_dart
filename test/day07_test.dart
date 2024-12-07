import 'dart:io';

import 'package:test/test.dart';
import '../bin/day07_part1.dart' as day07_part1;
import '../bin/day07_part2.dart' as day07_part2;
import 'main_tester.dart';

void main() {
  group('Day 07', () {
    group('Part 1', () {
      test('Sample p1', () async {
        final output = await testMain(
          day07_part1.solveDay07,
          input: File('data/day07_sample.txt').readAsStringSync(),
        );
        checkLastLine(output, day07_part1.sampleSolution);
      });
      test('Solution p1', () async {
        final output = await testMain(
          day07_part1.solveDay07,
          input: File('data/day07_input.txt').readAsStringSync(),
        );
        checkLastLineNotZero(output);
      });
    });
    group('Part 2', () {
      test('Sample p2', () async {
        final output = await testMain(
          day07_part2.solveDay07,
          input: File('data/day07_sample.txt').readAsStringSync(),
        );
        checkLastLine(output, day07_part2.sampleSolution);
      });
      test('Solution p2', () async {
        final output = await testMain(
          day07_part2.solveDay07,
          input: File('data/day07_input.txt').readAsStringSync(),
        );
        checkLastLineNotZero(output);
      });
    });
  });
}
