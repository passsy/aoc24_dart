import 'dart:io';

import 'package:test/test.dart';
import '../bin/day12_part1.dart' as day12_part1;
import '../bin/day12_part2.dart' as day12_part2;
import 'main_tester.dart';

const sampleSolutionPart1 = '1930';
const sampleSolutionPart2 = '1206';

void main() {
  group('Day 12', () {
    group('Part 1', () {
      test('Sample p1', () async {
        final input = File('data/day12_sample.txt').readAsStringSync();
        final output = await capturePrints(() => day12_part1.solveDay12(input));
        checkLastLine(output, sampleSolutionPart1);
      });
      test('Solution p1', () async {
        final input = File('data/day12_input.txt').readAsStringSync();
        final output = await capturePrints(() => day12_part1.solveDay12(input));
        checkLastLineNotZero(output);
        checkLastLine(output, "1473276");
      });
    });
    group('Part 2', () {
      test('Sample p2', () async {
        final input = File('data/day12_sample.txt').readAsStringSync();
        final output = await capturePrints(() => day12_part2.solveDay12(input));
        checkLastLine(output, sampleSolutionPart2);
      });
      test('Solution p2', () async {
        final input = File('data/day12_input.txt').readAsStringSync();
        final output = await capturePrints(() => day12_part2.solveDay12(input));
        checkLastLineNotZero(output);
        checkLastLine(output, "901100");
      });
    });
  });
}
