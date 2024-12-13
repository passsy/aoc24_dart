import 'dart:io';

import 'package:test/test.dart';
import '../bin/day06_part1.dart' as day06_part1;
import '../bin/day06_part2.dart' as day06_part2;
import 'main_tester.dart';

void main() {
  group('Day 06', () {
    group('Part 1', () {
      test('Sample p1', () async {
        final output = await testMain(
          day06_part1.solveDay06,
          input: File('data/day06_sample.txt').readAsStringSync(),
        );
        checkLastLine(output, day06_part1.sampleSolution);
      });
      test('Solution p1', () async {
        final output = await testMain(
          day06_part1.solveDay06,
          input: File('data/day06_input.txt').readAsStringSync(),
        );
        checkLastLineNotZero(output);
      });
    });
    group('Part 2', () {
      test('Sample p2', () async {
        final output = await testMain(
          day06_part2.solveDay06,
          input: File('data/day06_sample.txt').readAsStringSync(),
        );
        checkLastLine(output, day06_part2.sampleSolution);
      });
      test('Solution p2', () async {
        markTestSkipped('takes too long');
        return;
        // ignore: dead_code
        final output = await testMain(
          day06_part2.solveDay06,
          input: File('data/day06_input.txt').readAsStringSync(),
        );
        checkLastLineNotZero(output);
        checkLastLine(output, '1530');
      });
    });
  });
}
