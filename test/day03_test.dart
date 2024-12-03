import 'dart:io';

import 'package:test/test.dart';
import '../bin/day03_part1.dart' as day03_part1;
import '../bin/day03_part2.dart' as day03_part2;
import 'main_tester.dart';

void main() {
  group('Day 03', () {
    group('Part 1', () {
      test('Sample p1', () async {
        final output = await testMain(
          day03_part1.solveDay03,
          input: File('data/day03_sample.txt').readAsStringSync(),
        );
        checkLastLine(output, day03_part1.sampleSolution);
      });
      test('Solution p1', () async {
        final output = await testMain(
          day03_part1.solveDay03,
          input: File('data/day03_input.txt').readAsStringSync(),
        );
        checkLastLineNotZero(output);
      });
    });
    group('Part 2', () {
      test('Sample p2', () async {
        final output = await testMain(
          day03_part2.solveDay03,
          input: File('data/day03_sample2.txt').readAsStringSync(),
        );
        checkLastLine(output, day03_part2.sampleSolution);
      });
      test('Solution p2', () async {
        final output = await testMain(
          day03_part2.solveDay03,
          input: File('data/day03_input.txt').readAsStringSync(),
        );
        checkLastLineNotZero(output);
        expect(getLastLine(output), '103811193');
      });
    });
  });
}
