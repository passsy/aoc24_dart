import 'dart:io';

const sampleSolution = '41';

void solveDay06(String input) {
  // https://adventofcode.com/2024/day/6
  // Solve Part 1 here

  final lines = input.split('\n');
  final List<List<String>> array2d = lines.map((it) => it.split('')).toList();

  final map = <Point, String>{};
  for (int y = 0; y < array2d.length; y++) {
    final row = array2d[y];
    for (int x = 0; x < row.length; x++) {
      final char = row[x];
      map[(x: x, y: y)] = char;
    }
  }

  bool isOutOfBounds(Point point) {
    final x = point.x;
    final y = point.y;
    return x < 0 || y < 0 || x >= array2d[0].length || y >= array2d.length;
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

  void printMap() {
    for (int y = 0; y < array2d.length; y++) {
      final row = array2d[y];
      for (int x = 0; x < row.length; x++) {
        final char = map[(x: x, y: y)];
        stdout.write(char);
      }
      stdout.write('\n');
    }
    stdout.write('\n');
  }

  Point point = map.entries.firstWhere((element) => element.value == '^').key;

  Direction direction = up;
  while (true) {
    map[point] = 'X';
    final next = moveUntilObstacle(point, direction);
    if (next == null) {
      // out of bounds
      break;
    }
    point = next;
    direction = direction.rotateRight();
    printMap();
  }

  print(map.entries.where((element) => element.value == 'X').length);
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
