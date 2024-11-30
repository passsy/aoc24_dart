import 'dart:async';

import 'package:aoc24_sidekick/src/commands/clean_command.dart';
import 'package:aoc24_sidekick/src/commands/new_day_command.dart';
import 'package:sidekick_core/sidekick_core.dart';

Future<void> runAoc24(List<String> args) async {
  final runner = initializeSidekick(
    dartSdkPath: systemDartSdkPath(),
  );

  runner
    ..addCommand(DartCommand())
    ..addCommand(DepsCommand())
    ..addCommand(CleanCommand())
    ..addCommand(DartAnalyzeCommand())
    ..addCommand(FormatCommand())
    ..addCommand(SidekickCommand())
    ..addCommand(NewDayCommand());

  try {
    return await runner.run(args);
  } on UsageException catch (e) {
    print(e);
    exit(64); // usage error
  }
}
