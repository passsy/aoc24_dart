import 'package:sidekick_core/sidekick_core.dart';

class NewDayCommand extends Command {
  @override
  final String description = 'Creates code for a new day';

  @override
  final String name = 'new-day';

  @override
  Future<void> run() async {
    final rest = argResults!.rest.first;
    final dayFromRest = int.tryParse(rest);
    final int dayNumber;
    if (dayFromRest != null) {
      dayNumber = dayFromRest;
    } else {
      dayNumber = int.parse(ask('Day?', validator: Ask.integer));
    }

    final singleDigitDay = dayNumber.toString();
    final day = singleDigitDay.padLeft(2, '0');

    File('bin/day${day}_part1.dart')
      ..createSync()
      ..writeAsStringSync('''
// https://adventofcode.com/2024/day/$singleDigitDay
void solveDay$day(String input) {
  final lines = input.split('\\n').map((line) {
    // \\w Any word character
    // \\s Any whitespace character
    // \\d Any digit
    final matches = RegExp(r'(\\w+) (\\w+) (\\w+)').allMatches(line);
    // final a = matches.first.group(1)!;
    // final b = matches.first.group(2)!;
    // final c = matches.first.group(3)!;

    // final numbers = line.split(' ').map(int.parse).toList();

    return line;
  }).toList();
  
  int result = 0;
  for (int i = 0; i < lines.length; i++) {
    final line = lines[i];
    print(line);

    if (false) {
      result += 1;
    }
  }

  print(result);
}
''');

    File('bin/day${day}_part2.dart')
      ..createSync()
      ..writeAsStringSync('''
// https://adventofcode.com/2024/day/$singleDigitDay 
void solveDay$day(String input) {
  // TODO Solve Part 2 here
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


const sampleSolutionPart1 = '100';
const sampleSolutionPart2 = '100';

void main() {
  group('Day $day', () {
    group('Part 1', () {
      test('Sample p1', () async {
        final input = File('data/day${day}_sample.txt').readAsStringSync();
        final output = await capturePrints(() => day${day}_part1.solveDay$day(input));
        checkLastLine(output, sampleSolutionPart1);
      });
''');
    await testFile.appendString('''
      test('Solution p1', () async {
        final input = File('data/day${day}_input.txt').readAsStringSync();
        final output = await capturePrints(() => day${day}_part1.solveDay$day(input));
        checkLastLineNotZero(output);
        checkLastLine(output, isNot(sampleSolutionPart1));
      });
    });
''');
    await testFile.appendString('''
    group('Part 2', () {
      test('Sample p2', () async {
        final input = File('data/day${day}_sample.txt').readAsStringSync();
        final output = await capturePrints(() => day${day}_part2.solveDay$day(input));
        checkLastLine(output, sampleSolutionPart2);
      });
''');
    await testFile.appendString('''
      test('Solution p2', () async {
        final input = File('data/day${day}_input.txt').readAsStringSync();
        final output = await capturePrints(() => day${day}_part2.solveDay$day(input));
        checkLastLineNotZero(output);
        checkLastLine(output, isNot(sampleSolutionPart2));
      });
    });
  });
}
''');

    print(green('Created day $day'));
  }
}
