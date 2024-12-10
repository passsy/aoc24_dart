import 'package:aoc24/grid.dart';

const sampleSolution = '18';

void solveDay04(String input) {
  // https://adventofcode.com/2024/day/4
  // Solve Part 1 here

  final grid = AocGrid<String>(
    data: input,
    mapPoint: (data, point) => data,
  );
  final allX = grid.findAll((it) => it.value == 'X');

  int result = 0;

  for (final p in allX) {
    final up = grid.pointsInDirection(p.point, (p) => p.north).take(4).toList();
    final upWord = up.map((it) => it.value).take(4).join();
    if (upWord == 'XMAS') {
      print('up $p');
      result++;
    }
    final down =
        grid.pointsInDirection(p.point, (p) => p.south).take(4).toList();
    final downWord = down.map((it) => it.value).take(4).join();
    if (downWord == 'XMAS') {
      print('down $p');
      result++;
    }
    final left =
        grid.pointsInDirection(p.point, (p) => p.west).take(4).toList();
    final leftWord = left.map((it) => it.value).take(4).join();
    if (leftWord == 'XMAS') {
      print('left $p');
      result++;
    }
    final right =
        grid.pointsInDirection(p.point, (p) => p.east).take(4).toList();
    final rightWord = right.map((it) => it.value).take(4).join();
    if (rightWord == 'XMAS') {
      print('right $p');
      result++;
    }

    final northEast =
        grid.pointsInDirection(p.point, (p) => p.northEast).take(4).toList();
    final northEastWord = northEast.map((it) => it.value).take(4).join();
    if (northEastWord == 'XMAS') {
      print('northEast $p');
      result++;
    }

    final northWest =
        grid.pointsInDirection(p.point, (p) => p.northWest).take(4).toList();
    final northWestWord = northWest.map((it) => it.value).take(4).join();
    if (northWestWord == 'XMAS') {
      print('northWest $p');
      result++;
    }

    final southEast =
        grid.pointsInDirection(p.point, (p) => p.southEast).take(4).toList();
    final southEastWord = southEast.map((it) => it.value).take(4).join();
    if (southEastWord == 'XMAS') {
      print('southEast $p');
      result++;
    }

    final southWest =
        grid.pointsInDirection(p.point, (p) => p.southWest).take(4).toList();
    final southWestWord = southWest.map((it) => it.value).take(4).join();
    if (southWestWord == 'XMAS') {
      print('southWest $p');
      result++;
    }
  }

  print(result);
}

typedef Point = ({int x, int y});
typedef CharAtPoint = ({int x, int y, String char});
