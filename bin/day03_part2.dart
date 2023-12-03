import 'package:collection/collection.dart';

void main(List<String> args) {
  final map = parseMap(args);
  final numbersOnMap = map.where((it) => it.number != null).toList();
  final gears = map.where((it) => it.symbol == '*').toList();

  List<int> findParts(List<PointOnMap> adjacentNumbers) {
    final Set<String> partNumbers = {};
    for (final point in adjacentNumbers) {
      // find beginning on the left
      PointOnMap left = point;
      PointOnMap? found;
      do {
        found = numbersOnMap
            .firstWhereOrNull((it) => it.x == left.x - 1 && it.y == left.y);
        if (found != null) {
          left = found;
        }
      } while (found != null);

      // iterate right to read the whole number
      final start = left;
      String number = start.number.toString();
      PointOnMap right = start;
      do {
        found = numbersOnMap
            .firstWhereOrNull((it) => it.x == right.x + 1 && it.y == right.y);
        if (found != null) {
          right = found;
          number += right.number.toString();
        }
      } while (found != null);
      partNumbers.add(number);
    }
    return partNumbers.map((it) => int.parse(it)).toList();
  }

  final connectedParts = gears.map((gear) {
    final adjacentNumbers = numbersOnMap.where((it) {
      return (it.x - gear.x).abs() <= 1.9 && (it.y - gear.y).abs() <= 1.9;
    }).toList();
    final List<int> adjacentParts = findParts(adjacentNumbers);

    if (adjacentParts.length == 2) {
      return (part1Number: adjacentParts[0], part2Number: adjacentParts[1]);
    }
    return null;
  });

  int sum = 0;
  for (final parts in connectedParts) {
    if (parts == null) continue;
    sum += parts.part1Number * parts.part2Number;
  }

  print(sum);
}

typedef PointOnMap = ({int? number, String? symbol, int x, int y});

List<PointOnMap> parseMap(List<String> args) {
  final List<({int x, int y, String? symbol, int? number})> map = [];
  for (int y = 0; y < args.length; y++) {
    final line = args[y];
    final chars = line.split('');
    for (int x = 0; x < chars.length; x++) {
      final char = chars[x];
      if (char == '.') {
        continue;
      }
      if (int.tryParse(char) != null) {
        map.add((x: x, y: y, symbol: null, number: int.parse(char)));
      } else {
        map.add((x: x, y: y, symbol: char, number: null));
      }
    }
  }
  return map;
}
