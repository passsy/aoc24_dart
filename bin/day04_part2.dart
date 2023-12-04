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

  final Map<int, int> bag = {};
  for (final card in cards) {
    bag.putIfAbsent(card.number, () => 1);
  }

  int visitedCards = 0;
  for (int i = 1; i <= cards.length; i++) {
    final ticketsWithNumber = bag[i]!;
    bag.remove(i);

    final sampleTicket = cards.firstWhere((card) => card.number == i);
    final matches = sampleTicket.winningNumbers
        .where(sampleTicket.selection.contains)
        .length;

    visitedCards += ticketsWithNumber;

    for (int n = 1; n <= matches; n++) {
      int wonNumber = i + n;
      bag[wonNumber] = bag[wonNumber]! + ticketsWithNumber;
    }
  }

  print(visitedCards);
}
