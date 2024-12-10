import 'package:aoc24/grid.dart';
import 'package:dartx/dartx.dart';

const sampleSolution = '81';

void solveDay10(String input) {
  // https://adventofcode.com/2024/day/10
  // Solve Part 2 here

  final grid = AocGrid<int>(
    data: input,
    mapPoint: (data, point) => int.parse(data),
  );

  final found = <List<PointWithHeight>>[];

  int trailheadRating(List<PointWithHeight> path) {
    assert(path.isNotEmpty);
    final PointWithHeight trail = path.last;
    final number = path.last.height;
    if (number == 9) {
      found.add(path);
      return 1;
    }

    final neighbors = grid
        .neighborsNoswOf(trail.point)
        .where((it) => it.height == number + 1)
        .toList();
    final trails =
        neighbors.map((it) => trailheadRating([...path, it])).toList();
    return trails.sum();
  }

  final startingPositions = grid.findAll((it) => it.height == 0);
  final ratings = startingPositions.map((it) => trailheadRating([it])).toList();
  print(ratings.sum());
}

typedef PointWithHeight = GridPoint<int>;

extension on PointWithHeight {
  int get height => value!;
}
