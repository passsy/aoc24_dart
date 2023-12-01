void main(List<String> args) {
  int sum = 0;
  for (final line in args) {
    sum += getFirstInt(line, 1, 0) * 10 + getFirstInt(line, 0, 1);
  }
  print(sum);
}

final words = {
  'one': 1,
  'two': 2,
  'three': 3,
  'four': 4,
  'five': 5,
  'six': 6,
  'seven': 7,
  'eight': 8,
  'nine': 9
};

int getFirstInt(String line, int startMulti, int endMulti) {
  for (int index = 0; index < line.length; index++) {
    final start = index * startMulti + (line.length - index - 1) * endMulti;
    final sub = line.substring(start, line.length);
    for (final e in words.entries) {
      final n = int.tryParse(sub[0]);
      if (n != null) return n;
      if (sub.startsWith(e.key)) {
        return e.value;
      }
    }
  }
  throw 'No number found in $line';
}
