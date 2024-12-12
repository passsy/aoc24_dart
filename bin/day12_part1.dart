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

  int perimeter(Set<GridPoint<String>> group) {
    final groupName = group.first.value;

    final Set<({GridPoint<String> inside, GridPoint<String> outside})> fences =
        {};
    for (final inside in group) {
      final outside = [
        ...grid.neighborsNoswOf(inside.point, includeOutOfBounds: true),
        // ...grid.neighborsDiagonalOf(inside.point, includeOutOfBounds: true)
      ].where((it) => it.value != groupName);
      fences.addAll(outside.map((it) => (inside: inside, outside: it)));
    }

    return fences.length;
  }

  int result = 0;
  for (final region in allGroups.entries) {
    final area = region.value.length;
    final p = perimeter(region.value);
    final price = area * p;
    print("region: ${region.key} area: $area perimeter: $p price: $price");
    result += price;
  }

  print(result);
}
