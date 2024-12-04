const sampleSolution = '9';

void solveDay04(String input) {
  // https://adventofcode.com/2024/day/4
  // Solve Part 2 here

  final lines = input.split('\n');
  final array2d = lines.map((it) => it.split('')).toList();

  List<CharAtPoint> findA(String map) {
    final lines = map.split('\n');
    final maxY = lines.length;
    final maxX = lines[0].length;

    final found = <CharAtPoint>[];
    for (int y = 0; y < maxY; y++) {
      for (int x = 0; x < maxX; x++) {
        if (array2d[y][x] == 'A') {
          found.add((x: x, y: y, char: 'A'));
        }
      }
    }

    return found;
  }

  final allA = findA(input);

  Iterable<CharAtPoint> pointsInDirection(
      Point point, Point Function(Point) nextPoint) sync* {
    Point next = point;
    while (true) {
      try {
        final value = array2d[next.y][next.x];
        yield (x: next.x, y: next.y, char: value);
      } on RangeError catch (_) {
        return;
      }
      next = nextPoint(next);
    }
  }

  int result = 0;

  for (final point in allA) {
    final p = (x: point.x, y: point.y);

    final bottomRight = (x: p.x + 1, y: p.y + 1);
    final bottomLeft = (x: p.x - 1, y: p.y + 1);
    final topRight = (x: p.x + 1, y: p.y - 1);
    final topLeft = (x: p.x - 1, y: p.y - 1);

    int slash = 0;
    int backslash = 0;

    final northEast =
        pointsInDirection(bottomLeft, (p) => (x: p.x + 1, y: p.y - 1))
            .take(4)
            .toList();
    final northEastWord = northEast.map((it) => it.char).take(3).join();
    if (northEastWord == 'MAS') {
      print('northEast $p');
      slash++;
    }

    final northWest =
        pointsInDirection(bottomRight, (p) => (x: p.x - 1, y: p.y - 1))
            .take(4)
            .toList();
    final northWestWord = northWest.map((it) => it.char).take(3).join();
    if (northWestWord == 'MAS') {
      print('northWest $p');
      backslash++;
    }

    final southEast =
        pointsInDirection(topLeft, (p) => (x: p.x + 1, y: p.y + 1))
            .take(4)
            .toList();
    final southEastWord = southEast.map((it) => it.char).take(3).join();
    if (southEastWord == 'MAS') {
      print('southEast $p');
      backslash++;
    }

    final southWest =
        pointsInDirection(topRight, (p) => (x: p.x - 1, y: p.y + 1))
            .take(4)
            .toList();
    final southWestWord = southWest.map((it) => it.char).take(3).join();
    if (southWestWord == 'MAS') {
      print('southWest $p');
      slash++;
    }

    if (slash > 0 && backslash > 0) {
      result++;
    }
  }

  print(result);
}

typedef Point = ({int x, int y});
typedef CharAtPoint = ({int x, int y, String char});
