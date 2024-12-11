import 'dart:io';

import 'package:test/test.dart';
import '../bin/day11_part1.dart' as day11_part1;
import '../bin/day11_part2.dart' as day11_part2;
import 'main_tester.dart';

void main() {
  group('Day 11', () {
    group('Part 1', () {
      test('Sample p1', () async {
        final output = await testFunction(
          () => print(day11_part1.blink(6, [125, 17])),
        );
        checkLastLine(output, '22');
      });
      test('Solution p1', () async {
        final output = await testMain(
          day11_part1.solveDay11,
          input: '337 42493 1891760 351136 2 6932 73 0',
        );
        checkLastLineNotZero(output);
        checkLastLine(output, '233875');
      });
    });
    group('Part 2', () {
      test('Solution p2', () async {
        final output = await testMain(
          day11_part2.solveDay11,
          input: '337 42493 1891760 351136 2 6932 73 0',
        );
        checkLastLineNotZero(output);
        checkLastLine(output, '277444936413293');
      });
    });
  });
}
