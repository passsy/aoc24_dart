import 'dart:io';

import 'package:test/test.dart';
import '../bin/day18_part1.dart' as day18_part1;
import '../bin/day18_part2.dart' as day18_part2;
import 'main_tester.dart';

const sampleSolutionPart1 = '22';
const sampleSolutionPart2 = '6,1';

void main() {
  group('Day 18', () {
    group('Part 1', () {
      test('Sample p1', () async {
        final input = File('data/day18_sample.txt').readAsStringSync();
        final output =
            await capturePrints(() => day18_part1.solveDay18(input, 7, 7, 12));
        checkLastLine(output, sampleSolutionPart1);
      });
      test('Solution p1', () async {
        final input = File('data/day18_input.txt').readAsStringSync();
        final output = await capturePrints(
            () => day18_part1.solveDay18(input, 71, 71, 1024));
        checkLastLineNotZero(output);
        checkLastLine(output, isNot(sampleSolutionPart1));
        checkLastLine(output, isNot('470'));
      });
    });
    group('Part 2', () {
      test('Sample p2', () async {
        final input = File('data/day18_sample.txt').readAsStringSync();
        final output =
            await capturePrints(() => day18_part2.solveDay18(input, 7, 7, 12));
        checkLastLine(output, sampleSolutionPart2);
      });
      test('Solution p2', () async {
        final input = File('data/day18_input.txt').readAsStringSync();
        final output = await capturePrints(
            () => day18_part2.solveDay18(input, 71, 71, 1850));
        checkLastLineNotZero(output);
        checkLastLine(output, '26,50');
      });
    });
  });
}
