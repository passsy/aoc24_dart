import 'package:aoc24/grid.dart';

const sampleSolution = '41';

void solveDay06(String input) {
  // https://adventofcode.com/2024/day/6
  // Solve Part 1 here

  final grid = AocGrid<String>(
    data: input,
    mapPoint: (data, point) => data,
  );

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

  Point point = grid.findFirst((it) => it.value == '^').point;

  MoveDirection direction = oneNorth;
  while (true) {
    grid.setValue(point, 'X');
    final next = moveUntilObstacle(point, direction);
    if (next == null) {
      // out of bounds
      break;
    }
    point = next;
    direction = direction.rotateRight();
    grid.printToConsole();
  }

  final result = grid.findAll((it) => it.value == 'X').length;
  print(result);
}
