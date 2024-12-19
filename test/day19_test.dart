import 'dart:io';

import 'package:test/test.dart';
import '../bin/day19_part1.dart' as day19_part1;
import '../bin/day19_part2.dart' as day19_part2;
import 'main_tester.dart';

const sampleSolutionPart1 = '6';
const sampleSolutionPart2 = '16';

void main() {
  group('Day 19', () {
    group('Part 1', () {
      test('Sample p1', () async {
        day19_part1.isDesignPossible(
            'bwurrg', ['r', 'wr', 'b', 'g', 'bwu', 'rb', 'gb', 'br']);
        final input = File('data/day19_sample.txt').readAsStringSync();
        final output = await capturePrints(() => day19_part1.solveDay19(input));
        checkLastLine(output, sampleSolutionPart1);
      });
      test('Solution p1', () async {
        final input = File('data/day19_input.txt').readAsStringSync();
        final output = await capturePrints(() => day19_part1.solveDay19(input));
        checkLastLineNotZero(output);
        checkLastLine(output, isNot(sampleSolutionPart1));
      });
    });
    group('Part 2', () {
      test('Sample p2', () async {
        final input = File('data/day19_sample.txt').readAsStringSync();
        final output = await capturePrints(() => day19_part2.solveDay19(input));
        checkLastLine(output, sampleSolutionPart2);
      });
      test('Solution p2', () async {
        final input = File('data/day19_input.txt').readAsStringSync();
        final output = await capturePrints(() => day19_part2.solveDay19(input));
        checkLastLineNotZero(output);
        checkLastLine(output, '692596560138745');
      });
    });
  });
}
