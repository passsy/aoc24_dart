import 'dart:io';

import 'package:test/test.dart';
import '../bin/day17_part1.dart' as day17_part1;
import '../bin/day17_part2.dart' as day17_part2;
import 'main_tester.dart';

const sampleSolutionPart1 = '4,6,3,5,6,3,5,2,1,0';
const sampleSolutionPart2 = '117440';

void main() {
  group('Day 17', () {
    group('Part 1', () {
      test('Sample p1', () async {
        final input = File('data/day17_sample.txt').readAsStringSync();
        final output = await capturePrints(() => day17_part1.solveDay17(input));
        checkLastLine(output, sampleSolutionPart1);
      });
      test('Solution p1', () async {
        final input = File('data/day17_input.txt').readAsStringSync();
        final output = await capturePrints(() => day17_part1.solveDay17(input));
        checkLastLineNotZero(output);
        checkLastLine(output, '3,1,4,3,1,7,1,6,3');
      });
    });
    group('Part 2', () {
      test('Sample p2', () async {
        final input = File('data/day17_sample2.txt').readAsStringSync();
        final output = await capturePrints(() => day17_part2.solveDay17(input));
        checkLastLine(output, sampleSolutionPart2);
      });
      test('Solution p2', () async {
        final input = File('data/day17_input.txt').readAsStringSync();
        final output = await capturePrints(() => day17_part2.solveDay17(input));
        checkLastLineNotZero(output);
        checkLastLine(output, '37221270076916');
      });
    });
  });
}
