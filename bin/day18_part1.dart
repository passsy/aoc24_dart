// https://adventofcode.com/2024/day/18
import 'package:aoc24/grid.dart';

void solveDay18(String input, int width, int height, int take) {
  final fallingBytes = input.split('\n').map((line) {
    final matches = RegExp(r'(\d+),(\d+)').allMatches(line);
    final x = matches.first.group(1)!;
    final y = matches.first.group(2)!;
    return (x: int.parse(x), y: int.parse(y));
  }).toList();

  final first12 = fallingBytes.take(take).toList();
  final grid = AocGrid<String>.empty(height: height, width: width);
  for (final position in grid.getAllPoints()) {
    grid.setValue(position, '.');
  }

  for (final byte in first12) {
    grid.setValue(byte, '#');
  }
  grid.printToConsole();

  final end = (x: width - 1, y: height - 1);
  final path = grid.findFastestPath(
    (x: 0, y: 0),
    end,
    isPath: (GridPoint<String> point) => point.value == '.',
  );

  for (final point in path!) {
    grid.setValue(point.point, 'O');
  }
  grid.printToConsole();
  print(path.length - 1);
}
