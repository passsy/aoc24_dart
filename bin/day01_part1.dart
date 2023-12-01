void main(List<String> args) {
  int sum = 0;
  for (final line in args) {
    final split = line.split(RegExp(r'\D+')).where((e) => !e.isEmpty).toList();
    sum += int.parse(split[0]) * 10 + int.parse(split.last);
  }
  print(sum);
}
