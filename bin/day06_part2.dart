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

  Point? moveUntilObstacle(Point point, MoveDirection direction) {
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

    MoveDirection direction = oneNorth;
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
  for (final point in baseGrid.getAllPoints()) {
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
