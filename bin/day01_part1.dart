void main(List<String> args) {
  int sum = 0;
  for (final line in args) {
    final firstDigit = line.indexOf(RegExp(r'\d'));
    final lastDigit = line.lastIndexOf(RegExp(r'\d'));
    final first = int.parse(line.substring(firstDigit, firstDigit + 1));
    final second = int.parse(line.substring(lastDigit, lastDigit + 1));
    final int value = first * 10 + second;
    sum += value;
  }
  print(sum);
}
