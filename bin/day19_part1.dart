// https://adventofcode.com/2024/day/19
void solveDay19(String input) {
  final parts = input.split('\n\n');
  final List<String> patterns = parts[0].split(', ').toList();
  final designs = parts[1].split('\n').toList();

  int result = 0;
  for (int i = 0; i < designs.length; i++) {
    final line = designs[i];
    if (isDesignPossible(line, patterns)) {
      result += 1;
    }
  }

  print(result);
}

bool isDesignPossible(
  String design,
  List<String> patterns, [
  String beginning = '',
]) {
  if (design.isEmpty) {
    return true;
  }
  for (int i = 0; i < patterns.length; i++) {
    final pattern = patterns[i];
    if (design.startsWith(pattern)) {
      final newBeginning = beginning + pattern;
      final remainingDesign = design.substring(pattern.length);
      if (isDesignPossible(remainingDesign, patterns, newBeginning)) {
        return true;
      }
    }
  }
  return false;
}
