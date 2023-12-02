import 'dart:math';

void main(List<String> args) {
  final games = args.map((line) {
    final regex = RegExp(r'Game (\d+): (.*)');
    final matches = regex.firstMatch(line);
    final gameId = int.parse(matches!.group(1)!);
    final draws = matches
        .group(2)!
        .split(';')
        .map((e) => Map.fromEntries(e.trim().split(',').map((e) {
              final [number, color] = e.trim().split(' ');
              return MapEntry(color, int.parse(number));
            })))
        .toList();
    return (gameId: gameId, draws: draws);
  });

  final minimalPieces = games.map((game) {
    final minimalBag = <String, int>{};
    for (final draw in game.draws) {
      for (final MapEntry(key: color, value: count) in draw.entries) {
        final colorCountInBag = minimalBag[color] ?? 0;
        minimalBag[color] = max(colorCountInBag, count);
      }
    }
    return (gameId: game.gameId, minimalBag: minimalBag);
  }).toList();

  final powers = minimalPieces
      .map((e) => e.minimalBag.values.reduce((a, b) => a * b))
      .toList();

  print(powers.reduce((a, b) => a + b));
}
