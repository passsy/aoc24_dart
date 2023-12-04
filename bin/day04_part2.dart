import 'package:collection/collection.dart';

void main(List<String> args) {
  final cards = args.map((line) {
    final match = RegExp(r'Card\s+(\d+):(.+)\|(.+)').firstMatch(line);
    List<int> numbers(String text) =>
        text.split(' ').map(int.tryParse).whereNotNull().toSet().toList();
    return (
      number: int.parse(match!.group(1)!),
      winningNumbers: numbers(match!.group(2)!),
      selection: numbers(match!.group(3)!),
    );
  }).toList();

  final bag = cards.toList();

  int visitedCards = 0;
  for (int i = 1; i <= cards.length; i++) {
    final ticketsWithNumber = bag.where((it) => it.number == i).toList();
    bag.removeWhere((it) => it.number == i);

    final sampleTicket = ticketsWithNumber.first;
    final matches = sampleTicket.winningNumbers
        .where(sampleTicket.selection.contains)
        .length;

    visitedCards += ticketsWithNumber.length;

    for (int n = 1; n <= matches; n++) {
      final newTickets = cards.firstWhere((card) => card.number == i + n);
      for (int x = 0; x < ticketsWithNumber.length; x++) {
        bag.add(newTickets);
      }
    }
  }

  print(visitedCards);
}
