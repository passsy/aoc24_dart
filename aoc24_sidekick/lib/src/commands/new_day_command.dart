import 'package:sidekick_core/sidekick_core.dart';

class NewDayCommand extends Command {
  @override
  final String description = 'Creates code for a new day';

  @override
  final String name = 'new-day';

  @override
  Future<void> run() async {
    final singleDigitDay = ask('Day?', validator: Ask.integer);
    final day = singleDigitDay.padLeft(2, '0');

    File('bin/day${day}_part1.dart')
      ..createSync()
      ..writeAsStringSync('''
const sampleSolution = '100';

void solveDay$day(String input) {
  // https://adventofcode.com/2024/day/$singleDigitDay
  // Solve Part 1 here
  print(0);
}
''');

    File('bin/day${day}_part2.dart')
      ..createSync()
      ..writeAsStringSync('''
const sampleSolution = '100';

void solveDay$day(String input) {
  // https://adventofcode.com/2024/day/$singleDigitDay 
  // Solve Part 2 here
  print(0);
}
''');

    File('data/day${day}_sample.txt').createSync();
    File('data/day${day}_input.txt').createSync();

    final testFile = File('test/day${day}_test.dart')..createSync();

    await testFile.appendString('''
import 'dart:io';

import 'package:test/test.dart';
''');
    await testFile.appendString('''
import '../bin/day${day}_part1.dart' as day${day}_part1;
''');
    await testFile.appendString('''
import '../bin/day${day}_part2.dart' as day${day}_part2;
''');
    await testFile.appendString('''
import 'main_tester.dart';

void main() {
  group('Day $day', () {
    group('Part 1', () {
      test('Sample p1', () async {
        final output = await testMain(
          day${day}_part1.solveDay$day,
          input: File('data/day${day}_sample.txt').readAsStringSync(),
        );
        expect(output, day${day}_part1.sampleSolution);
      });
''');
    await testFile.appendString('''
      test('Solution p1', () async {
        final output = await testMain(
          day${day}_part1.solveDay$day,
          input: File('data/day${day}_input.txt').readAsStringSync(),
        );
        expect(output, isNot('0'));
        print(output);
      });
    });
''');
    await testFile.appendString('''
    group('Part 2', () {
      test('Sample p2', () async {
        final output = await testMain(
          day${day}_part2.solveDay$day,
          input: File('data/day${day}_sample.txt').readAsStringSync(),
        );
        expect(output, day${day}_part2.sampleSolution);
      });
''');
    await testFile.appendString('''
      test('Solution p2', () async {
        final output = await testMain(
          day${day}_part2.solveDay$day,
          input: File('data/day${day}_input.txt').readAsStringSync(),
        );
        expect(output, isNot(contains('\\n')));
        expect(output, isNot('0'));
        print(output);
      });
    });
  });
}
''');

    print(green('Created day $day'));
  }
}
