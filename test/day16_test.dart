import 'dart:io';

import 'package:test/test.dart';
import '../bin/day16_part1.dart' as day16_part1;
import '../bin/day16_part2.dart' as day16_part2;
import 'main_tester.dart';

const sampleSolutionPart1 = '7036';

void main() {
  group('Day 16', () {
    group('Part 1', () {
      test('Sample p1', () async {
        final input = File('data/day16_sample.txt').readAsStringSync();
        final output = await capturePrints(() => day16_part1.solveDay16(input));
        checkLastLine(output, sampleSolutionPart1);
      });
      test('Solution p1', () async {
        final input = File('data/day16_input.txt').readAsStringSync();
        final output = await capturePrints(() => day16_part1.solveDay16(input));
        checkLastLineNotZero(output);
        checkLastLine(output, isNot(sampleSolutionPart1));
      });
    });
    group('Part 2', () {
      test('Sample p2', () async {
        markTestSkipped('manual search');
        return;
        // ignore: dead_code
        final input = File('data/day16_sample.txt').readAsStringSync();
        final output = await capturePrints(() => day16_part2.solveDay16(input));
        checkLastLine(output, '45');
      });
      test('Sample2 p2', () async {
        markTestSkipped('manual search');
        return;
        // ignore: dead_code
        final input = File('data/day16_sample2.txt').readAsStringSync();
        final output = await capturePrints(() => day16_part2.solveDay16(input));
        checkLastLine(output, '64');
      });
      test('Sample3 p2', () async {
        markTestSkipped('manual search');
        return;
        // ignore: dead_code
        final input = File('data/day16_sample3.txt').readAsStringSync();
        final output = await capturePrints(() => day16_part2.solveDay16(input));
        checkLastLine(output, '26');
      });
      test('Solution p2', () async {
        final input = File('data/day16_input.txt').readAsStringSync();
        final output = await capturePrints(() => day16_part2.solveDay16(input));
        checkLastLineNotZero(output);
        checkLastLine(output, '483');
      });
    });
  });
}
