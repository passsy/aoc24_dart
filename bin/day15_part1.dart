import 'package:aoc24/grid.dart';
import 'package:dartx/dartx.dart';

// https://adventofcode.com/2024/day/15
void solveDay15(String input) {
  final parts = input.split('\n\n');
  final AocGrid<String> grid = AocGrid(
    data: parts[0],
    mapPoint: (data, point) => data,
  );

  final instructions = parts[1].split('').toList();

  void moveRobot(MoveDirection direction) {
    final robot = grid.getAllGridPoints().firstWhere((it) => it.value == '@');
    final allValuesInDir =
        grid.pointsInDirection(robot.point, direction).skip(1);
    final nextPoint = allValuesInDir.first;
    final updatedPoints = <GridPoint<String>>[];
    if (nextPoint.value == '.') {
      updatedPoints.add(robot.point.withValue('.'));
      updatedPoints.add(nextPoint.point.withValue('@'));
    } else if (nextPoint.value == 'O') {
      final nonWall = allValuesInDir.takeWhile((it) => it.value != '#');
      final nextFreeSpace = nonWall.firstOrNullWhere((it) => it.value == '.');
      if (nextFreeSpace != null) {
        updatedPoints.add(robot.point.withValue('.'));
        updatedPoints.add(nextPoint.point.withValue('@'));
        for (final p in allValuesInDir.skip(1)) {
          if (p.value == '#') {
            break;
          }
          if (p == nextFreeSpace) {
            updatedPoints.add(p.point.withValue('O'));
            break;
          } else {
            updatedPoints.add(p.point.withValue('O'));
          }
        }
        final remaining =
            nonWall.skipWhile((it) => it != nextFreeSpace).skip(1).toList();
        for (final p in remaining) {
          updatedPoints.add(p);
        }
      }
    }

    for (final p in updatedPoints) {
      grid.setValue(p.point, p.value!);
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
      grid.getAllGridPoints().where((it) => it.value == 'O').toList();
  final sums = allBoxes.map((it) => it.point.x + it.point.y * 100).toList();
  result = sums.sum();

  print(result);
}
