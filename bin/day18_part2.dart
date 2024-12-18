// https://adventofcode.com/2024/day/18
import 'package:aoc24/grid.dart';

void solveDay18(String input, int width, int height, int take) {
  final fallingBytes = input.split('\n').map((line) {
    final matches = RegExp(r'(\d+),(\d+)').allMatches(line);
    final x = matches.first.group(1)!;
    final y = matches.first.group(2)!;
    return (x: int.parse(x), y: int.parse(y));
  }).toList();

  bool isBlocked(int index) {
    final grid = AocGrid<String>.empty(height: height, width: width, fill: '.');
    for (final b in fallingBytes.take(index)) {
      grid.setValue(b, '#');
    }
    final path = grid.findFastestPath(
      (x: 0, y: 0),
      (x: width - 1, y: height - 1),
      isPath: (GridPoint<String> point) => point.value == '.',
    );
    return path == null;
  }

  // do a binary search for the index where the path is blocked
  int low = 0;
  int high = fallingBytes.length;
  while (low < high) {
    final mid = low + (high - low) ~/ 2;
    if (isBlocked(mid)) {
      high = mid;
    } else {
      low = mid + 1;
    }
  }
  print(low - 1);
  final breakingPoint = fallingBytes.skip(low - 1).first;
  print('${breakingPoint.x},${breakingPoint.y}');
}
