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

  void _removeInBothDirections(
    Fence fence,
    List<Fence> toProcess,
  ) {
    final isVertical = fence.inside.point.x == fence.outside.point.x;
    final oneDown = (dx: -1, dy: 0);
    final oneUp = (dx: 1, dy: 0);
    final oneLeft = (dx: 0, dy: -1);
    final oneRight = (dx: 0, dy: 1);
    final directions = isVertical ? [oneDown, oneUp] : [oneLeft, oneRight];

    for (final direction in directions) {
      int step = 0;
      while (true) {
        step++;
        final nextInside = grid.getGridPointWithOOB((
          x: fence.inside.point.x + direction.dx * step,
          y: fence.inside.point.y + direction.dy * step
        ));
        final nextOutside = grid.getGridPointWithOOB((
          x: fence.outside.point.x + direction.dx * step,
          y: fence.outside.point.y + direction.dy * step
        ));
        final point = (inside: nextInside, outside: nextOutside);
        if (!toProcess.contains(point)) {
          break;
        }
        toProcess.remove(point);
      }
    }
  }

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
      sides++;
      _removeInBothDirections(fence, toProcess);
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
