import 'package:collection/collection.dart';

typedef Card = ({int number, List<int> selection, List<int> winningNumbers});
void main(List<String> args) {
  final List<Card> cards = args.map((line) {
    final match = RegExp(r'Card\s+(\d+):(.+)\|(.+)').firstMatch(line);
    List<int> numbers(String text) =>
        text.split(' ').map(int.tryParse).whereNotNull().toSet().toList();
    return (
      number: int.parse(match!.group(1)!),
      winningNumbers: numbers(match!.group(2)!),
      selection: numbers(match!.group(3)!),
    );
  }).toList();

  final Map<int, List<Card>> bag = {};
  for (final card in cards) {
    bag.putIfAbsent(card.number, () => []);
    bag[card.number]!.add(card);
  }

  int visitedCards = 0;
  for (int i = 1; i <= cards.length; i++) {
    final ticketsWithNumber = bag[i]!.toList();
    bag.remove(i);

    final sampleTicket = ticketsWithNumber.first;
    final matches = sampleTicket.winningNumbers
        .where(sampleTicket.selection.contains)
        .length;

    visitedCards += ticketsWithNumber.length;

    for (int n = 1; n <= matches; n++) {
      int wonNumber = i + n;
      final newTickets = cards.firstWhere((card) => card.number == wonNumber);
      for (int x = 0; x < ticketsWithNumber.length; x++) {
        bag[wonNumber]!.add(newTickets);
      }
    }
  }

  print(visitedCards);
}
