import 'dart:io';

import 'package:test/test.dart';
import '../bin/day14_part1.dart' as day14_part1;
import '../bin/day14_part2.dart' as day14_part2;
import 'main_tester.dart';

const sampleSolutionPart1 = '12';
const sampleSolutionPart2 = '100';

void main() {
  group('Day 14', () {
    group('Part 1', () {
      test('Sample p1', () async {
        final input = File('data/day14_sample.txt').readAsStringSync();
        final output = await capturePrints(() {
          day14_part1.solveDay14(
            input,
            gridWidth: 11,
            gridHeight: 7,
          );
        });
        checkLastLine(output, sampleSolutionPart1);
      });
      test('Solution p1', () async {
        final input = File('data/day14_input.txt').readAsStringSync();
        final output = await capturePrints(
          () => day14_part1.solveDay14(input),
        );
        checkLastLineNotZero(output);
        checkLastLine(output, isNot(sampleSolutionPart1));
      });
    });
    group('Part 2', () {
      test('manual search', () async {
        markTestSkipped('manual search');
        return;
        // ignore: dead_code
        final input = File('data/day14_input.txt').readAsStringSync();
        final output = await capturePrints(
          () => day14_part2.solveDay14(
            input,
            iterations: 10_000,
          ),
        );
        checkLastLineNotZero(output);
        checkLastLine(output, isNot(sampleSolutionPart1));
      });
    });
  });
}
