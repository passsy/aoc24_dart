import 'dart:io';

import 'package:test/test.dart';
import '../bin/day13_part1.dart' as day13_part1;
import '../bin/day13_part2.dart' as day13_part2;
import 'main_tester.dart';

const sampleSolutionPart1 = '480';
const sampleSolutionPart2 = '875318608908';

void main() {
  group('Day 13', () {
    group('Part 1', () {
      test('Sample p1', () async {
        final input = File('data/day13_sample.txt').readAsStringSync();
        final output = await capturePrints(() => day13_part1.solveDay13(input));
        checkLastLine(output, sampleSolutionPart1);
      });
      test('Solution p1', () async {
        final input = File('data/day13_input.txt').readAsStringSync();
        final output = await capturePrints(() => day13_part1.solveDay13(input));
        checkLastLineNotZero(output);
        checkLastLine(output, isNot(sampleSolutionPart1));
        checkLastLine(output, '37901');
      });
    });
    group('Part 2', () {
      test('Sample p2', () async {
        final input = File('data/day13_sample.txt').readAsStringSync();
        final output = await capturePrints(() => day13_part2.solveDay13(input));
        checkLastLine(output, sampleSolutionPart2);
      });
      test('Solution p2', () async {
        final input = File('data/day13_input.txt').readAsStringSync();
        final output = await capturePrints(() => day13_part2.solveDay13(input));
        checkLastLineNotZero(output);
        checkLastLine(output, isNot(sampleSolutionPart2));
        checkLastLine(output, '77407675412647');
      });
    });
  });
}
