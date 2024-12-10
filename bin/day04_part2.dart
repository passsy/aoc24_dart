import 'package:aoc24/grid.dart';

const sampleSolution = '9';

void solveDay04(String input) {
  // https://adventofcode.com/2024/day/4
  // Solve Part 2 here

  final grid = AocGrid<String>(
    data: input,
    mapPoint: (data, point) => data,
  );

  int result = 0;

  final allA = grid.findAll((it) => it.value == 'A');
  for (final p in allA) {
    final sw = grid.getValueOrNull(p.southWest);
    final ne = grid.getValueOrNull(p.northEast);
    final nw = grid.getValueOrNull(p.northWest);
    final se = grid.getValueOrNull(p.southEast);

    final slashUp = '${sw}A${ne}';
    final slashDown = '${ne}A${sw}';
    final backslashDown = '${nw}A${se}';
    final backslashUp = '${se}A${nw}';

    final slash = slashUp == 'MAS' || slashDown == 'MAS';
    final backslash = backslashDown == 'MAS' || backslashUp == 'MAS';
    if (slash && backslash) {
      result++;
    }
  }

  print(result);
}

typedef Point = ({int x, int y});
typedef CharAtPoint = ({int x, int y, String char});
