import 'package:trotter/trotter.dart';

const sampleSolution = '34';

void solveDay08(String input) {
  // https://adventofcode.com/2024/day/8
  // Solve Part 2 here

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

  Iterable<Point> inDirection(
      Point point, Point Function(Point) nextPoint) sync* {
    Point next = point;
    while (true) {
      next = nextPoint(next);
      if (isOutOfBounds(next)) {
        return;
      } else {
        yield next;
      }
    }
  }

  List<Point> findAntiNodesWithResonance(List<Point> points) {
    final allPairs =
        Combinations(2, points).iterable.toList().cast<List<Point>>();
    final antiNodes = <Point>[];
    for (final pair in allPairs) {
      final a = pair[0];
      final b = pair[1];
      final dx = b.x - a.x;
      final dy = b.y - a.y;
      antiNodes.add(a);
      antiNodes.add(b);
      final up = inDirection(a, (p) => (x: p.x - dx, y: p.y - dy)).toList();
      antiNodes.addAll(up);
      final down = inDirection(b, (p) => (x: p.x + dx, y: p.y + dy)).toList();
      antiNodes.addAll(down);
    }
    return antiNodes.toSet().toList();
  }

  final antiNodesOnMap = <Point, List<String>>{};

  void printMap() {
    final sb = StringBuffer();
    for (int y = 0; y < array2d.length; y++) {
      final row = array2d[y];
      for (int x = 0; x < row.length; x++) {
        final char = map[(x: x, y: y)];
        final antiNodes = antiNodesOnMap[(x: x, y: y)];
        if (char == '.') {
          if (antiNodes != null) {
            sb.write('X');
          } else {
            sb.write('.');
          }
        } else {
          sb.write(char);
        }
      }
      sb.write('\n');
    }
    sb.write('\n');
    print(sb);
  }

  for (final char in allCharacters) {
    final points = findAll(char);
    final antiNodes =
        findAntiNodesWithResonance(points.map((e) => e.point).toList());
    for (final Point node in antiNodes) {
      antiNodesOnMap.putIfAbsent(node, () => []);
      antiNodesOnMap[node]!.add(char);
    }
  }

  printMap();

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
