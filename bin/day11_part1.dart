// https://adventofcode.com/2024/day/11
void solveDay11(String input) {
  final List<int> stones = input.split(' ').map(int.parse).toList();
  print(blink(25, stones));
}

int blink(int n, List<int> stones) {
  List<int> s = stones;
  for (int blink = 1; blink <= n; blink++) {
    s = s.expand(splitStone).toList();
    print('After ${blink} blink, stones: ${s.length}');
  }
  return s.length;
}

List<int> splitStone(int stone) {
  if (stone == 0) {
    return [1];
  }
  final stoneString = stone.toString();
  if (stoneString.length % 2 == 0) {
    final half = stoneString.length ~/ 2;
    final firstHalf = int.parse(stoneString.substring(0, half));
    final secondHalf = int.parse(stoneString.substring(half));
    return [firstHalf, secondHalf];
  }
  return [stone * 2024];
}
