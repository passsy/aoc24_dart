import 'package:dartx/dartx.dart';

// https://adventofcode.com/2024/day/14
void solveDay14(
  String input, {
  int gridWidth = 101,
  int gridHeight = 103,
}) {
  var robots = input.split('\n').map((line) {
    final matches =
        RegExp(r'p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)').allMatches(line);
    final px = matches.first.group(1)!;
    final py = matches.first.group(2)!;
    final vx = matches.first.group(3)!;
    final vy = matches.first.group(4)!;
    assert(int.parse(px) < gridWidth);
    assert(int.parse(py) < gridHeight);
    return Robot(
      velocity: (dx: int.parse(vx), dy: int.parse(vy)),
      position: (x: int.parse(px), y: int.parse(py)),
    );
  }).toList();

  void printRobots() {
    final sb = StringBuffer();
    for (var y = 0; y < gridHeight; y++) {
      for (var x = 0; x < gridWidth; x++) {
        final robot = robots
            .where((robot) => robot.position.x == x && robot.position.y == y);
        if (robot.isNotEmpty) {
          sb.write(robot.length);
        } else {
          sb.write('.');
        }
      }
      sb.writeln();
    }
    print(sb);
  }

  print(robots.joinToString(separator: '\n'));

  for (int i = 1; i <= 100; i++) {
    final updated = <Robot>[];
    for (final robot in robots) {
      final movedRobot = Robot(
        velocity: robot.velocity,
        position: (
          x: (robot.position.x + robot.velocity.dx) % gridWidth,
          y: (robot.position.y + robot.velocity.dy) % gridHeight,
        ),
      );
      updated.add(movedRobot);
    }
    robots = updated;
    print('After $i seconds:');
    printRobots();
  }

  final quadrantTopLeft = robots
      .where((robot) =>
          robot.position.x < (gridWidth - 1) / 2 &&
          robot.position.y < (gridHeight - 1) / 2)
      .length;
  final quadrantTopRight = robots
      .where((robot) =>
          robot.position.x >= (gridWidth + 1) / 2 &&
          robot.position.y < (gridHeight - 1) / 2)
      .length;
  final quadrantBottomLeft = robots
      .where((robot) =>
          robot.position.x < (gridWidth - 1) / 2 &&
          robot.position.y >= (gridHeight + 1) / 2)
      .length;
  final quadrantBottomRight = robots
      .where((robot) =>
          robot.position.x >= (gridWidth + 1) / 2 &&
          robot.position.y >= (gridHeight + 1) / 2)
      .length;

  print(
      'Quadrants: $quadrantTopLeft $quadrantTopRight $quadrantBottomLeft $quadrantBottomRight');

  print(quadrantTopLeft *
      quadrantTopRight *
      quadrantBottomLeft *
      quadrantBottomRight);
}

typedef Velocity = ({int dx, int dy});
typedef Position = ({int x, int y});

class Robot {
  final Velocity velocity;
  final Position position;

  const Robot({
    required this.velocity,
    required this.position,
  });

  @override
  String toString() {
    return 'Robot{position: $position, velocity: $velocity}';
  }
}
