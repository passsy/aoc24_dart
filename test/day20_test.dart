import 'dart:io';

import 'package:test/test.dart';
import '../bin/day20_part1.dart' as day20_part1;
import '../bin/day20_part2.dart' as day20_part2;
import 'main_tester.dart';

String sampleSolutionPart1 =
    (14 + 14 + 2 + 4 + 2 + 3 + 1 + 1 + 1 + 1 + 1).toString();
String sampleSolutionPart2 =
    (32 + 31 + 29 + 39 + 25 + 23 + 20 + 19 + 12 + 14 + 12 + 22 + 4 + 3)
        .toString();

void main() {
  group('Day 20', () {
    group('Part 1', () {
      test('Sample p1', () async {
        final input = File('data/day20_sample.txt').readAsStringSync();
        final output = await capturePrints(() => day20_part1.solveDay20(input));
        output.contains('All counted: $sampleSolutionPart1');
        checkLastLine(output, '0');
      });
      test('Solution p1', () async {
        final input = File('data/day20_input.txt').readAsStringSync();
        final output = await capturePrints(() => day20_part1.solveDay20(input));
        checkLastLineNotZero(output);
        checkLastLine(output, '1372');
      });
    });
    group('Part 2', () {
      test('Sample p2', () async {
        final input = File('data/day20_sample.txt').readAsStringSync();
        final output = await capturePrints(
            () => day20_part2.solveDay20(input, larger: 50));
        checkLastLine(output, sampleSolutionPart2);
      });
      test('Solution p2', () async {
        final input = File('data/day20_input.txt').readAsStringSync();
        final output = await capturePrints(() => day20_part2.solveDay20(input));
        checkLastLineNotZero(output);
        checkLastLine(output, '979014');
      });
    });
  });
}
