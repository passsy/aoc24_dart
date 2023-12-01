void main(List<String> args) {
  int sum = 0;
  for (final line in args) {
    final first = getFirstInt(line);
    final second = getLastInt(line);
    final int value = first * 10 + second;
    sum += value;
  }
  print(sum);
}

final wordToInt = {
  '1': 1,
  '2': 2,
  '3': 3,
  '4': 4,
  '5': 5,
  '6': 6,
  '7': 7,
  '8': 8,
  '9': 9,
  'one': 1,
  'two': 2,
  'three': 3,
  'four': 4,
  'five': 5,
  'six': 6,
  'seven': 7,
  'eight': 8,
  'nine': 9,
};

int getFirstInt(String line) {
  int index = 0;
  while (index < line.length) {
    final remaining = line.substring(index);
    for (final MapEntry(key: word, :value) in wordToInt.entries) {
      if (remaining.startsWith(word)) {
        return value;
      }
    }
    index++;
  }
  throw 'No number found in $line';
}

int getLastInt(String line) {
  int index = line.length - 1;
  while (index >= 0) {
    final remaining = line.substring(0, index + 1);
    for (final MapEntry(key: word, :value) in wordToInt.entries) {
      if (remaining.endsWith(word)) {
        return value;
      }
    }
    index--;
  }
  throw 'No number found in $line';
}
