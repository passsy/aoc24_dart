import 'package:collection/collection.dart';

void main(List<String> args) {
  final map = parseMap(args);
  final numbersOnMap = map.where((it) => it.number != null).toList();
  final symbols = map.where((it) => it.symbol != null).toList();

  final Set<PointOnMap> allTouchingNumbersSet = {};
  for (final symbol in symbols) {
    final adjacent = map
        .where((it) {
          return (it.x - symbol.x).abs() <= 1.9 &&
              (it.y - symbol.y).abs() <= 1.9;
        })
        .where((it) => it.number != null)
        .toList();
    allTouchingNumbersSet.addAll(adjacent);
  }

  final allTouchingNumbersList = allTouchingNumbersSet.toList();
  int sum = 0;

  while (allTouchingNumbersList.isNotEmpty) {
    // find beginning on the left
    PointOnMap point = allTouchingNumbersList.last;
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
    allTouchingNumbersList.remove(start);
    String number = start.number.toString();
    PointOnMap right = start;
    do {
      found = numbersOnMap
          .firstWhereOrNull((it) => it.x == right.x + 1 && it.y == right.y);
      if (found != null) {
        right = found;
        number += right.number.toString();
        allTouchingNumbersList.remove(found);
      }
    } while (found != null);

    sum += int.parse(number);
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
