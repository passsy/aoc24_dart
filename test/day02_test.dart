import 'dart:io';

import 'package:test/test.dart';
import '../bin/day02_part1.dart' as day02_part1;
import '../bin/day02_part2.dart' as day02_part2;
import 'main_tester.dart';

void main() {
  group('Day 02', () {
    group('Part 1', () {
      test('Sample p1', () async {
        final output = await testMain(
          day02_part1.solveDay02,
          input: File('data/day02_sample.txt').readAsStringSync(),
        );
        checkLastLine(output, day02_part1.sampleSolution);
      });
      test('Solution p1', () async {
        final output = await testMain(
          day02_part1.solveDay02,
          input: File('data/day02_input.txt').readAsStringSync(),
        );
        checkLastLineNotZero(output);
      });
    });
    group('Part 2', () {
      test('Sample p2', () async {
        final output = await testMain(
          day02_part2.solveDay02,
          input: File('data/day02_sample.txt').readAsStringSync(),
        );
        checkLastLine(output, day02_part2.sampleSolution);
      });
      test('Solution p2', () async {
        final output = await testMain(
          day02_part2.solveDay02,
          input: File('data/day02_input.txt').readAsStringSync(),
        );
        checkLastLineNotZero(output);
      });
    });
  });
}
