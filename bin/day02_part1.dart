void main(List<String> args) {
  final bag = {
    'red': 12,
    'green': 13,
    'blue': 14,
  };
  final validGames = args.map((line) {
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
  }).where((it) {
    for (final draw in it.draws) {
      for (final MapEntry(key: color, value: count) in draw.entries) {
        final colorCountInBag = bag[color]!;
        if (colorCountInBag < count) {
          return false;
        }
      }
    }
    return true;
  });

  print(validGames.map((e) => e.gameId).reduce((a, b) => a + b));
}
