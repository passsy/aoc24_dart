void solveDay11(String input) {
  // https://adventofcode.com/2024/day/11
  // Solve Part 1 here
  final List<int> stones = input.split(' ').map(int.parse).toList().toList();
  print(blink(25, stones));
}

int blink(int n, List<int> stones) {
  List<int> s = stones;
  for (int blink = 1; blink <= n; blink++) {
    s = splitStones(s.toList());
    print('After ${blink} blink, stones: ${s.length}');
  }
  return s.length;
}

List<int> splitStones(List<int> stones) {
  final List<int> output = [];
  for (int s = 0; s < stones.length; s++) {
    final stone = stones[s];
    if (stone == 0) {
      output.add(1);
    } else if (stone.toString().length % 2 == 0) {
      final half = stone.toString().length ~/ 2;
      final firstHalf = int.parse(stone.toString().substring(0, half));
      final secondHalf = int.parse(stone.toString().substring(half));
      output.add(firstHalf);
      output.add(secondHalf);
    } else {
      output.add(stone * 2024);
    }
  }
  return output;
}
