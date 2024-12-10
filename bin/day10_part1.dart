import 'package:dartx/dartx.dart';

const sampleSolution = '36';

void solveDay10(String input) {
  // https://adventofcode.com/2024/day/10
  // Solve Part 1 here

  final lines = input.split('\n');
  final List<List<String>> array2d = lines.map((it) => it.split('')).toList();
  final mapHeight = array2d.length;
  final mapWidth = array2d[0].length;

  final initialMap = <Point, int>{};
  for (int y = 0; y < array2d.length; y++) {
    final row = array2d[y];
    for (int x = 0; x < row.length; x++) {
      final number = int.parse(row[x]);
      initialMap[(x: x, y: y, height: number)] = number;
    }
  }
  List<Point> findX(int number) {
    assert(number >= 0 && number <= 9);
    final found = <Point>[];
    for (int y = 0; y < mapHeight; y++) {
      for (int x = 0; x < mapWidth; x++) {
        if (array2d[y][x] == number.toString()) {
          found.add((x: x, y: y, height: number));
        }
      }
    }

    return found;
  }

  List<Point> neighborsOf(Point p) {
    final List<Point> n = [];
    if (p.x > 0) {
      n.add(initialMap.keys.firstWhere((e) => e.x == p.x - 1 && e.y == p.y));
    }
    if (p.x < mapHeight - 1) {
      n.add(initialMap.keys.firstWhere((e) => e.x == p.x + 1 && e.y == p.y));
    }
    if (p.y > 0) {
      n.add(initialMap.keys.firstWhere((e) => e.x == p.x && e.y == p.y - 1));
    }
    if (p.y < mapWidth - 1) {
      n.add(initialMap.keys.firstWhere((e) => e.x == p.x && e.y == p.y + 1));
    }
    return n;
  }

  final found = <List<Point>>[];

  void findPaths(List<Point> path) {
    assert(path.isNotEmpty);
    final trail = path.last;
    final number = path.last.height;
    if (number == 0) {
      print(
          'found trail ${path.joinToString(transform: (it) => '${it.x}/${it.y}')}');
      found.add(path);
    }

    final neighbors =
        neighborsOf(trail).where((it) => it.height == number - 1).toList();
    for (final neighbor in neighbors) {
      findPaths([...path, neighbor]);
    }
  }

  for (final start in findX(9)) {
    findPaths([start]);
  }

  final result = found.distinctBy((it) => (it.first, it.last)).count();
  print(result);
}

typedef Point = ({int x, int y, int height});
