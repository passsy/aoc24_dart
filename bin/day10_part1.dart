import 'package:aoc24/grid.dart';
import 'package:dartx/dartx.dart';

const sampleSolution = '36';

void solveDay10(String input) {
  // https://adventofcode.com/2024/day/10
  // Solve Part 1 here

  final grid = AocGrid<int>(
    data: input,
    mapPoint: (data, point) => int.parse(data),
  );

  final found = <List<PointWithHeight>>[];

  void findPaths(List<PointWithHeight> path) {
    assert(path.isNotEmpty);
    final PointWithHeight trail = path.last;
    final number = path.last.height;
    if (number == 9) {
      found.add(path);
      return;
    }

    final neighbors = grid
        .neighborsNoswOf(trail.point)
        .where((it) => it.height == number + 1)
        .toList();
    for (final neighbor in neighbors) {
      findPaths([...path, neighbor]);
    }
  }

  for (final start in grid.findAll((it) => it.height == 0)) {
    findPaths([start]);
  }

  final result = found.distinctBy((it) => (it.first, it.last)).count();
  print(result);
}

typedef PointWithHeight = ValuedPoint<int>;

extension on PointWithHeight {
  int get height => value!;
}
