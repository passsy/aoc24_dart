import 'package:aoc24/grid.dart';
import 'package:dartx/dartx.dart';

// https://adventofcode.com/2024/day/15
void solveDay15(String input) {
  final parts = input.split('\n\n');

  final widerMap = widenMap(parts[0]);
  final AocGrid<String> grid = AocGrid(
    data: widerMap,
    mapPoint: (data, point) => data,
  );

  final instructions = parts[1].split('').toList();

  void moveRobot(MoveDirection direction) {
    final robot = grid.getAllGridPoints().firstWhere((it) => it.value == '@');
    final allValuesInDir =
        grid.pointsInDirection(robot.point, direction).skip(1);
    final nextPoint = allValuesInDir.first;
    if (nextPoint.value == '.') {
      final updatedPoints = <GridPoint<String>>[];
      updatedPoints.add(robot.point.withValue('.'));
      updatedPoints.add(nextPoint.point.withValue('@'));

      for (final p in updatedPoints) {
        grid.setValue(p.point, p.value!);
      }
    } else if (nextPoint.value == '[' || nextPoint.value == ']') {
      List<GridPoint<String>> boxesInDir(Point point, MoveDirection direction) {
        final d = direction(point);
        final horizontal = d.y == point.y;
        if (horizontal) {
          return grid
              .pointsInDirection(point, direction)
              .skip(1)
              .takeWhile((it) => it.value == '[' || it.value == ']')
              .toList();
        } else {
          final up = d.y > point.y;
          if (up) {
            final List<GridPoint<String>> box = [];
            final next = grid.getGridPoint((x: point.x, y: point.y + 1));
            if (next.value == '[') {
              final other = grid.getGridPoint((x: point.x + 1, y: point.y + 1));
              box.add(next);
              box.add(other);
              box.addAll(boxesInDir(next.point, direction));
              box.addAll(boxesInDir(other.point, direction));
            } else if (next.value == ']') {
              final other = grid.getGridPoint((x: point.x - 1, y: point.y + 1));
              box.add(next);
              box.add(other);
              box.addAll(boxesInDir(next.point, direction));
              box.addAll(boxesInDir(other.point, direction));
            }
            return box;
          } else {
            final List<GridPoint<String>> box = [];
            final next = grid.getGridPoint((x: point.x, y: point.y - 1));
            if (next.value == '[') {
              final other = grid.getGridPoint((x: point.x + 1, y: point.y - 1));
              box.add(next);
              box.add(other);
              box.addAll(boxesInDir(next.point, direction));
              box.addAll(boxesInDir(other.point, direction));
            } else if (next.value == ']') {
              final other = grid.getGridPoint((x: point.x - 1, y: point.y - 1));
              box.add(next);
              box.add(other);
              box.addAll(boxesInDir(next.point, direction));
              box.addAll(boxesInDir(other.point, direction));
            }
            return box;
          }
        }
      }

      final touchingBoxes = boxesInDir(robot.point, direction).toList();

      final touchingInDirection = touchingBoxes
          .map((it) => grid.getGridPoint(direction(it.point)))
          .toList();
      final blockingWalls =
          touchingInDirection.where((it) => it.value == '#').toList();
      if (blockingWalls.isEmpty) {
        // move all boxes in direction
        for (final box in touchingBoxes) {
          grid.setValue(box.point, '.');
        }
        for (final box in touchingBoxes) {
          grid.setValue(direction(box.point), box.value!);
        }
        // move robot in direction
        grid.setValue(direction(robot.point), '@');
        grid.setValue(robot.point, '.');
      }
      print('#');
    }
  }

  int result = 0;
  for (int i = 0; i < instructions.length; i++) {
    final instruction = instructions[i];
    final MoveDirection? direction = switch (instruction) {
      '^' => oneNorth,
      'v' => oneSouth,
      '<' => oneWest,
      '>' => oneEast,
      _ => null
    };
    if (direction == null) {
      continue;
    }
    print("Move $instruction");
    moveRobot(direction);
    grid.printToConsole();
    print('');
  }

  final allBoxes =
      grid.getAllGridPoints().where((it) => it.value == '[').toList();
  final sums = allBoxes.map((it) => it.point.x + it.point.y * 100).toList();
  result = sums.sum();

  print(result);
}

String widenMap(String map) {
  final sb = StringBuffer();

  for (final char in map.split('')) {
    switch (char) {
      case '#':
        sb.write('##');
      case 'O':
        sb.write('[]');
      case '.':
        sb.write('..');
      case '@':
        sb.write('@.');
      default:
        sb.write(char);
    }
  }
  return sb.toString();
}
