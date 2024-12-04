const sampleSolution = '18';

void solveDay04(String input) {
  // https://adventofcode.com/2024/day/4
  // Solve Part 1 here

  final lines = input.split('\n');
  final array2d = lines.map((it) => it.split('')).toList();

  List<CharAtPoint> findX(String map) {
    final lines = map.split('\n');
    final maxY = lines.length;
    final maxX = lines[0].length;

    final found = <CharAtPoint>[];
    for (int y = 0; y < maxY; y++) {
      for (int x = 0; x < maxX; x++) {
        if (array2d[y][x] == 'X') {
          found.add((x: x, y: y, char: 'X'));
        }
      }
    }

    return found;
  }

  final allX = findX(input);

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

  for (final point in allX) {
    final p = (x: point.x, y: point.y);
    final up =
        pointsInDirection(p, (p) => (x: p.x, y: p.y - 1)).take(4).toList();
    final upWord = up.map((it) => it.char).take(4).join();
    if (upWord == 'XMAS') {
      print('up $p');
      result++;
    }
    final down =
        pointsInDirection(p, (p) => (x: p.x, y: p.y + 1)).take(4).toList();
    final downWord = down.map((it) => it.char).take(4).join();
    if (downWord == 'XMAS') {
      print('down $p');
      result++;
    }
    final left =
        pointsInDirection(p, (p) => (x: p.x - 1, y: p.y)).take(4).toList();
    final leftWord = left.map((it) => it.char).take(4).join();
    if (leftWord == 'XMAS') {
      print('left $p');
      result++;
    }
    final right =
        pointsInDirection(p, (p) => (x: p.x + 1, y: p.y)).take(4).toList();
    final rightWord = right.map((it) => it.char).take(4).join();
    if (rightWord == 'XMAS') {
      print('right $p');
      result++;
    }

    final northEast =
        pointsInDirection(p, (p) => (x: p.x + 1, y: p.y - 1)).take(4).toList();
    final northEastWord = northEast.map((it) => it.char).take(4).join();
    if (northEastWord == 'XMAS') {
      print('northEast $p');
      result++;
    }

    final northWest =
        pointsInDirection(p, (p) => (x: p.x - 1, y: p.y - 1)).take(4).toList();
    final northWestWord = northWest.map((it) => it.char).take(4).join();
    if (northWestWord == 'XMAS') {
      print('northWest $p');
      result++;
    }

    final southEast =
        pointsInDirection(p, (p) => (x: p.x + 1, y: p.y + 1)).take(4).toList();
    final southEastWord = southEast.map((it) => it.char).take(4).join();
    if (southEastWord == 'XMAS') {
      print('southEast $p');
      result++;
    }

    final southWest =
        pointsInDirection(p, (p) => (x: p.x - 1, y: p.y + 1)).take(4).toList();
    final southWestWord = southWest.map((it) => it.char).take(4).join();
    if (southWestWord == 'XMAS') {
      print('southWest $p');
      result++;
    }
  }

  print(result);
}

typedef Point = ({int x, int y});
typedef CharAtPoint = ({int x, int y, String char});
