const sampleSolution = '9';

void solveDay04(String input) {
  // https://adventofcode.com/2024/day/4
  // Solve Part 2 here

  final lines = input.split('\n');
  final field = lines.map((it) => it.split('')).toList();

  String? charAtPoint({required int x, required int y}) {
    try {
      return field[y][x];
    } on RangeError catch (_) {
      return null;
    }
  }

  List<CharAtPoint> findPointsWithChar(String char) {
    assert(char.length == 1);
    final maxY = lines.length;
    final maxX = lines[0].length;

    final found = <CharAtPoint>[];
    for (int y = 0; y < maxY; y++) {
      for (int x = 0; x < maxX; x++) {
        final c = charAtPoint(x: x, y: y);
        if (c == char) {
          found.add((x: x, y: y, char: char));
        }
      }
    }

    return found;
  }

  int result = 0;

  final allA = findPointsWithChar('A');
  for (final point in allA) {
    final p = (x: point.x, y: point.y);

    final bottomRight = charAtPoint(x: p.x + 1, y: p.y + 1);
    final bottomLeft = charAtPoint(x: p.x - 1, y: p.y + 1);
    final topRight = charAtPoint(x: p.x + 1, y: p.y - 1);
    final topLeft = charAtPoint(x: p.x - 1, y: p.y - 1);

    final slashUp = '${bottomLeft}A${topRight}';
    final slashDown = '${topRight}A${bottomLeft}';
    final backslashDown = '${topLeft}A${bottomRight}';
    final backslashUp = '${bottomRight}A${topLeft}';

    final slash = slashUp == 'MAS' || slashDown == 'MAS';
    final backslash = backslashDown == 'MAS' || backslashUp == 'MAS';
    if (slash && backslash) {
      result++;
    }
  }

  print(result);
}

typedef Point = ({int x, int y});
typedef CharAtPoint = ({int x, int y, String char});
