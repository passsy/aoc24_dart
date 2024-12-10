import 'package:aoc24/grid.dart';

const sampleSolution = '6';

void solveDay06(String input) {
  // https://adventofcode.com/2024/day/6
  // Solve Part 2 here

  final baseGrid = AocGrid<String>(
    data: input,
    mapPoint: (data, point) => data,
  );

  AocGrid<String> grid = baseGrid.copy();

  Point? moveUntilObstacle(Point point, Direction direction) {
    Point next = point;
    while (!grid.isOutOfBounds(next)) {
      final prev = next;
      grid.setValue(prev, 'X');
      next = direction(next);
      final nextChar = grid.getValueOrNull(next);
      if (nextChar == '#') {
        return prev;
      }
    }
    return null;
  }

  bool isLoop() {
    Point point = grid.findFirst((it) => it.value == '^').point;

    final List<(Point, Point)> paths = [];

    Direction direction = up;
    while (true) {
      grid.setValue(point, 'X');
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
  for (final point in baseGrid.allPoints()) {
    grid = baseGrid.copy();

    if (grid.getValue(point) == '#') {
      continue;
    }
    if (grid.getValue(point) == '^') {
      continue;
    }
    grid.setValue(point, '#');

    print('Checking $point');
    if (isLoop()) {
      result++;
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
