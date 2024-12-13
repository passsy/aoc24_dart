// https://adventofcode.com/2024/day/13
void solveDay13(String input) {
  final machines = input.split('\n\n').map((line) {
    final matchesA = RegExp(r'Button A: X\+(\d+), Y\+(\d+)', multiLine: true)
        .allMatches(line);
    final matchesB = RegExp(r'Button B: X\+(\d+), Y\+(\d+)', multiLine: true)
        .allMatches(line);
    final matchesP =
        RegExp(r'Prize: X=(\d+), Y=(\d+)', multiLine: true).allMatches(line);
    final ax = matchesA.first.group(1)!;
    final ay = matchesA.first.group(2)!;
    final bx = matchesB.first.group(1)!;
    final by = matchesB.first.group(2)!;
    final px = matchesP.first.group(1)!;
    final py = matchesP.first.group(2)!;

    return Machine(
      buttonA: (dx: int.parse(ax), dy: int.parse(ay)),
      buttonB: (dx: int.parse(bx), dy: int.parse(by)),
      price: (x: int.parse(px), y: int.parse(py)),
    );
  }).toList();

  int result = 0;
  for (int i = 0; i < machines.length; i++) {
    final machine = machines[i];
    final presses = grabPrice(machine);
    if (presses != null) {
      result += presses.a * 3 + presses.b;
    }
  }

  print(result);
}

({int a, int b})? grabPrice(Machine machine) {
  final ax = machine.buttonA.dx;
  final ay = machine.buttonA.dy;
  final bx = machine.buttonB.dx;
  final by = machine.buttonB.dy;
  final px = machine.price.x;
  final py = machine.price.y;

  // Cramer's rule
  final d = ax * by - ay * bx;
  if (d == 0) {
    return null;
  }
  final a = (px * by - py * bx) / d;
  final b = (py * ax - px * ay) / d;
  if (a < 0 || b < 0 || a != a.truncate() || b != b.truncate()) {
    return null;
  }
  return (a: a.round(), b: b.round());
}

typedef Offset = ({int dx, int dy});
typedef Location = ({int x, int y});

class Machine {
  final Offset buttonA;
  final Offset buttonB;
  final Location price;

  const Machine({
    required this.buttonA,
    required this.buttonB,
    required this.price,
  });
}
