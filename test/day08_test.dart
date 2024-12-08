import 'dart:io';

import 'package:test/test.dart';
import '../bin/day08_part1.dart' as day08_part1;
import '../bin/day08_part2.dart' as day08_part2;
import 'main_tester.dart';

void main() {
  group('Day 08', () {
    group('Part 1', () {
      test('Sample p1', () async {
        final output = await testMain(
          day08_part1.solveDay08,
          input: File('data/day08_sample.txt').readAsStringSync(),
        );
        checkLastLine(output, day08_part1.sampleSolution);
      });
      test('Solution p1', () async {
        final output = await testMain(
          day08_part1.solveDay08,
          input: File('data/day08_input.txt').readAsStringSync(),
        );
        checkLastLineNotZero(output);
      });
    });
    group('Part 2', () {
      test('Sample p2', () async {
        final output = await testMain(
          day08_part2.solveDay08,
          input: File('data/day08_sample.txt').readAsStringSync(),
        );
        checkLastLine(output, day08_part2.sampleSolution);
      });
      test('Solution p2', () async {
        final output = await testMain(
          day08_part2.solveDay08,
          input: File('data/day08_input.txt').readAsStringSync(),
        );
        checkLastLineNotZero(output);
      });
    });
  });
}
