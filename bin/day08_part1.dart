import 'package:trotter/trotter.dart';

const sampleSolution = '14';

void solveDay08(String input) {
  // https://adventofcode.com/2024/day/8
  // Solve Part 1 here

  final lines = input.split('\n');
  final array2d = lines.map((it) => it.split('')).toList();

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

  final allCharacters = map.values.toSet()..remove('.');

  List<CharAtPoint> findAll(String char) {
    assert(char.length == 1);
    final fields = Map.of(map)..removeWhere((key, value) => value == '.');
    final points = fields.entries
        .where((element) => element.value == char)
        .map((e) => e.key)
        .toList();
    return points.map((it) => it.withChar(char)).toList();
  }

  List<Point> findAntiNodes(List<Point> points) {
    final allPairs =
        Combinations(2, points).iterable.toList().cast<List<Point>>();
    final antiNodes = <Point>[];
    for (final pair in allPairs) {
      final a = pair[0];
      final b = pair[1];
      final dx = b.x - a.x;
      final dy = b.y - a.y;
      final Point one = (x: b.x + dx, y: b.y + dy);
      final Point two = (x: a.x - dx, y: a.y - dy);

      if (!isOutOfBounds(one)) {
        antiNodes.add(one);
      }
      if (!isOutOfBounds(two)) {
        antiNodes.add(two);
      }
    }
    return antiNodes;
  }

  final antiNodesOnMap = <Point, List<String>>{};

  for (final char in allCharacters) {
    final points = findAll(char);
    final antiNodes = findAntiNodes(points.map((e) => e.point).toList());
    for (final Point node in antiNodes) {
      antiNodesOnMap.putIfAbsent(node, () => []);
      antiNodesOnMap[node]!.add(char);
    }
  }

  print(antiNodesOnMap.keys.length);
}

typedef Point = ({int x, int y});
typedef Direction = Point Function(Point point);
typedef CharAtPoint = ({int x, int y, String char});

extension on Point {
  CharAtPoint withChar(String char) => (x: x, y: y, char: char);
}

extension on CharAtPoint {
  Point get point => (x: x, y: y);
}
