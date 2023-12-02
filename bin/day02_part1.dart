void main(List<String> args) {
  final games = args.map((line) {
    final regex = RegExp(r'Game (\d+): (.*)');
    final matches = regex.firstMatch(line);
    final gameId = int.parse(matches!.group(1)!);
    final draws = matches.group(2)!.split(';').map((e) {
      return Map.fromEntries(e.trim().split(',').map((e) {
        final [number, color] = e.trim().split(' ');
        return MapEntry(color, int.parse(number));
      }));
    }).toList();
    return (gameId: gameId, draws: draws);
  });

  final bag = {
    'red': 12,
    'green': 13,
    'blue': 14,
  };

  final validGames = games.where((it) {
    return it.draws.every((draw) {
      return draw.entries.every((entry) {
        return bag[entry.key]! >= entry.value;
      });
    });
  });

  print(validGames.map((e) => e.gameId).reduce((a, b) => a + b));
}
