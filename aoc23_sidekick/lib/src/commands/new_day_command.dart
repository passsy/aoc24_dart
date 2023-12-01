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

    final golfing = confirm('Are you code golfing this day?');

    File('bin/day${day}_part1.dart')
      ..createSync()
      ..writeAsStringSync('''
void main(List<String> args) {
  print(0);
}
''');
    if (golfing) {
      File('bin/day${day}_part1.min.dart')
        ..createSync()
        ..writeAsStringSync('''
main(a, {i}) {
  print(0);
}
''');
    }

    File('bin/day${day}_part2.dart')
      ..createSync()
      ..writeAsStringSync('''
void main(List<String> args) {
  print(0);
}
''');
    if (golfing) {
      File('bin/day${day}_part2.min.dart')
        ..createSync()
        ..writeAsStringSync('''
main(a, {i}) {
  print(0);
}
''');
    }

    File('data/day${day}_sample.txt').createSync();
    File('data/day${day}_input.txt').createSync();

    final testFile = File('test/day${day}_test.dart')..createSync();

    testFile.appendString('''
import 'dart:io';

import 'package:test/test.dart';
''');
    testFile.appendString('''
import '../bin/day${day}_part1.dart' as day${day}_part1;
''');
    if (golfing) {
      testFile.appendString('''
import '../bin/day${day}_part1.min.dart' as day${day}_part1_min;
''');
    }
    testFile.appendString('''
import '../bin/day${day}_part2.dart' as day${day}_part2;
''');
    if (golfing) {
      testFile.appendString('''
import '../bin/day${day}_part2.min.dart' as day${day}_part2_min;
''');
    }
    testFile.appendString('''
import 'main_tester.dart';

void main() {
  group('day $day', () {
    test('sample part 1', () {
      final output = testMain(
        day${day}_part1.main,
        input: File('data/day${day}_sample.txt').readAsStringSync(),
      );
      expect(output, '100');
    });
''');
    if (golfing) {
      testFile.appendString('''
    test('golf part 1', () {
      final output = testMain(
        day${day}_part1_min.main,
        input: File('data/day${day}_sample.txt').readAsStringSync(),
      );
      expect(output, '100');
    });
''');
    }
    testFile.appendString('''
    test('solve part 1', () {
      final output = testMain(
        day${day}_part1.main,
        input: File('data/day${day}_input.txt').readAsStringSync(),
      );
      expect(output, isNot('0'));
      print(output);
    });
''');
    testFile.appendString('''
    test('sample part 2', () {
      final output = testMain(
        day${day}_part2.main,
        input: File('data/day${day}_sample.txt').readAsStringSync(),
      );
      expect(output, '100');
    });
''');
    if (golfing) {
      testFile.appendString('''
    test('golf part 2', () {
      final output = testMain(
        day${day}_part2_min.main,
        input: File('data/day${day}_sample.txt').readAsStringSync(),
      );
      expect(output, '100');
    });
''');
    }
    testFile.appendString('''
    test('solve part 2', () {
      final output = testMain(
        day${day}_part2.main,
        input: File('data/day${day}_input.txt').readAsStringSync(),
      );
      expect(output, isNot('0'));
      print(output);
    });''');
    testFile.appendString('''
  });
}
''');

    print(green('Created day $day'));
  }
}
