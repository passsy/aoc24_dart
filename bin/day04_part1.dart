import 'dart:math' as math;

import 'package:collection/collection.dart';

void main(List<String> args) {
  final tickets = args.map((line) {
    final match = RegExp(r'Card\s+\d+:(.+)\|(.+)').firstMatch(line);
    List<int> numbers(String text) =>
        text.split(' ').map(int.tryParse).whereNotNull().toSet().toList();
    return (
      winningNumbers: numbers(match!.group(1)!),
      selection: numbers(match!.group(2)!),
    );
  }).toList();

  final scores = tickets.map((ticket) {
    final matches =
        ticket.winningNumbers.where(ticket.selection.contains).length;
    if (matches == 0) return 0;
    return math.pow(2, matches - 1);
  }).toList();

  print(scores.reduce((a, b) => a + b));
}
