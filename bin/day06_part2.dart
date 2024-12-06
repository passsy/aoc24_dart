const sampleSolution = '6';

void solveDay06(String input) {
  // https://adventofcode.com/2024/day/6
  // Solve Part 2 here

  final lines = input.split('\n');
  final List<List<String>> array2d = lines.map((it) => it.split('')).toList();
  final mapHeight = array2d.length;
  final mapWidth = array2d[0].length;

  final initialMap = <Point, String>{};
  for (int y = 0; y < array2d.length; y++) {
    final row = array2d[y];
    for (int x = 0; x < row.length; x++) {
      final char = row[x];
      initialMap[(x: x, y: y)] = char;
    }
  }

  var map = <Point, String>{};

  bool isOutOfBounds(Point point) {
    final x = point.x;
    final y = point.y;
    return x < 0 || y < 0 || x >= mapWidth || y >= mapHeight;
  }

  Point? moveUntilObstacle(Point point, Direction direction) {
    Point next = point;
    while (!isOutOfBounds(next)) {
      final prev = next;
      next = direction(next);
      final nextChar = map[next];
      map[prev] = 'X';
      if (nextChar == '#') {
        return prev;
      }
    }
    return null;
  }

  bool isLoop() {
    Point point = map.entries.firstWhere((element) => element.value == '^').key;

    final List<(Point, Point)> paths = [];

    Direction direction = up;
    while (true) {
      map[point] = 'X';
      final next = moveUntilObstacle(point, direction);

      if (next == null) {
        // out of bounds
        return false;
      }
      final path = (point, next);
      if (paths.contains(path)) {
        return true;
      }
      paths.add(path);
      point = next;
      direction = direction.rotateRight();
    }
  }

  int result = 0;
  for (int y = 0; y < array2d.length; y++) {
    final row = array2d[y];
    for (int x = 0; x < row.length; x++) {
      final point = (x: x, y: y);

      map = Map.of(initialMap);
      final char = map[point];
      if (char == '^') {
        continue;
      }
      if (char == '#') {
        continue;
      }
      map[point] = '#';

      print('Checking $point');
      if (isLoop()) {
        result++;
      }
    }
  }

  print(result);
}

typedef Point = ({int x, int y});
typedef Direction = Point Function(Point point);

Point up(Point point) => (x: point.x, y: point.y - 1);
Point down(Point point) => (x: point.x, y: point.y + 1);
Point left(Point point) => (x: point.x - 1, y: point.y);
Point right(Point point) => (x: point.x + 1, y: point.y);

extension on Direction {
  Direction rotateRight() {
    if (this == up) {
      return right;
    }
    if (this == right) {
      return down;
    }
    if (this == down) {
      return left;
    }
    if (this == left) {
      return up;
    }
    throw Exception('Unknown direction');
  }
}
