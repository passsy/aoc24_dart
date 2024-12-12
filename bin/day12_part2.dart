// https://adventofcode.com/2024/day/12
import 'package:aoc24/grid.dart';
import 'package:dartx/dartx.dart';

void solveDay12(String input) {
  final grid = AocGrid<String>(
    data: input,
    mapPoint: (char, p) => char,
  );

  final regions = grid.getAllGridPoints().map((it) => it.value).toSet();
  final Map<String, Set<GridPoint<String>>> allGroups = {};
  for (final region in regions) {
    final Map<String, Set<GridPoint<String>>> groups = {};
    final cellsWithRegionForProcess = grid.findAll((it) => it.value == region);
    int i = 0;
    final regionCellsForProcess = {cellsWithRegionForProcess.first};
    final processed = <GridPoint<String>>{};
    while (regionCellsForProcess.isNotEmpty) {
      final cell = regionCellsForProcess.first;
      regionCellsForProcess.remove(cell);
      cellsWithRegionForProcess.remove(cell);

      final neighbors = grid.neighborsNoswOf(cell.point);
      final neighborsInRegion =
          neighbors.where((it) => it.value == region).toList();

      for (final n in neighborsInRegion) {
        if (!processed.contains(n)) {
          regionCellsForProcess.add(n);
        }
      }
      final key = '${cell.value}$i';
      groups.putIfAbsent(key, () => {});
      groups[key]!.add(cell);

      cellsWithRegionForProcess.remove(cell);
      processed.add(cell);
      if (regionCellsForProcess.isEmpty &&
          cellsWithRegionForProcess.isNotEmpty) {
        final remaining = cellsWithRegionForProcess.firstOrNull;
        if (remaining != null) {
          regionCellsForProcess.add(remaining);
          i++;
        }
      }
    }
    allGroups.addAll(groups);
  }

  print("allGroups: ${allGroups.keys}");

  int sides(Set<GridPoint<String>> group) {
    final groupName = group.first.value;

    final Set<Fence> fences = {};
    for (final inside in group) {
      final outside = grid
          .neighborsNoswOf(inside.point, includeOutOfBounds: true)
          .where((it) => it.value != groupName);
      fences.addAll(outside.map((it) => (inside: inside, outside: it)));
    }

    int sides = 0;
    final toProcess = fences.toList();

    while (toProcess.isNotEmpty) {
      final fence = toProcess.removeAt(0);
      final isVertical = fence.inside.point.x == fence.outside.point.x;
      if (!isVertical) {
        sides++;
        int up = 0;
        while (true) {
          up++;
          final nextUpInside = fence.inside.point.y - up;
          final nextInside = grid
              .getGridPointWithOOB((x: fence.inside.point.x, y: nextUpInside));
          final nextUpOutside = fence.outside.point.y - up;
          final nextOutside = grid.getGridPointWithOOB(
              (x: fence.outside.point.x, y: nextUpOutside));
          if (toProcess.contains((inside: nextInside, outside: nextOutside))) {
            toProcess.remove((inside: nextInside, outside: nextOutside));
          } else {
            break;
          }
        }
        int down = 0;
        while (true) {
          down++;
          final nextDownInside = fence.inside.point.y + down;
          final nextInside = grid.getGridPointWithOOB(
              (x: fence.inside.point.x, y: nextDownInside));
          final nextDownOutside = fence.outside.point.y + down;
          final nextOutside = grid.getGridPointWithOOB(
              (x: fence.outside.point.x, y: nextDownOutside));
          if (toProcess.contains((inside: nextInside, outside: nextOutside))) {
            toProcess.remove((inside: nextInside, outside: nextOutside));
          } else {
            break;
          }
        }
      } else {
        sides++;
        int left = 0;
        while (true) {
          left++;
          final nextLeftInside = fence.inside.point.x - left;
          final nextInside = grid.getGridPointWithOOB(
              (x: nextLeftInside, y: fence.inside.point.y));
          final nextLeftOutside = fence.outside.point.x - left;
          final nextOutside = grid.getGridPointWithOOB(
              (x: nextLeftOutside, y: fence.outside.point.y));
          if (toProcess.contains((inside: nextInside, outside: nextOutside))) {
            toProcess.remove((inside: nextInside, outside: nextOutside));
          } else {
            break;
          }
        }
        int right = 0;
        while (true) {
          right++;
          final nextRightInside = fence.inside.point.x + right;
          final nextInside = grid.getGridPointWithOOB(
              (x: nextRightInside, y: fence.inside.point.y));
          final nextRightOutside = fence.outside.point.x + right;
          final nextOutside = grid.getGridPointWithOOB(
              (x: nextRightOutside, y: fence.outside.point.y));
          if (toProcess.contains((inside: nextInside, outside: nextOutside))) {
            toProcess.remove((inside: nextInside, outside: nextOutside));
          } else {
            break;
          }
        }
      }
    }

    return sides;
  }

  int result = 0;
  for (final region in allGroups.entries) {
    final area = region.value.length;
    final s = sides(region.value);
    final price = area * s;
    print("region: ${region.key} area: $area side: $s price: $price");
    result += price;
  }

  print(result);
}

typedef Fence = ({GridPoint<String> inside, GridPoint<String> outside});
