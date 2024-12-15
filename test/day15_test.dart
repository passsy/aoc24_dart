import 'dart:io';

import 'package:test/test.dart';
import '../bin/day15_part1.dart' as day15_part1;
import '../bin/day15_part2.dart' as day15_part2;
import 'main_tester.dart';

const sampleSolutionPart1 = '10092';
const sampleSolutionPart2 = '9021';

void main() {
  group('Day 15', () {
    group('Part 1', () {
      test('Sample p1', () async {
        final input = File('data/day15_sample.txt').readAsStringSync();
        final output = await capturePrints(() => day15_part1.solveDay15(input));
        checkLastLine(output, sampleSolutionPart1);
      });
      test('Solution p1', () async {
        final input = File('data/day15_input.txt').readAsStringSync();
        final output = await capturePrints(() => day15_part1.solveDay15(input));
        checkLastLineNotZero(output);
        checkLastLine(output, isNot(sampleSolutionPart1));
      });
    });
    group('Part 2', () {
      test('Mini Sample p2', () async {
        final input = File('data/day15_mini_sample.txt').readAsStringSync();
        final output = await capturePrints(() => day15_part2.solveDay15(input));
        checkLastLine(output, '618');
      });
      test('Sample p2', () async {
        final input = File('data/day15_sample.txt').readAsStringSync();
        final output = await capturePrints(() => day15_part2.solveDay15(input));
        checkLastLine(output, sampleSolutionPart2);
      });
      test('Solution p2', () async {
        final input = File('data/day15_input.txt').readAsStringSync();
        final output = await capturePrints(() => day15_part2.solveDay15(input));
        checkLastLineNotZero(output);
        checkLastLine(output, isNot(sampleSolutionPart2));
      });
    });
  });
}
