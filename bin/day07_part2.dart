const sampleSolution = '11387';

void solveDay07(String input) {
  // https://adventofcode.com/2024/day/7
  // Solve Part 2 here

  final lines = input.split('\n').map((line) {
    final split = line.split(': ');
    final result = int.parse(split[0]);
    final numbers = split[1].split(' ').map(int.parse).toList();
    return (result: result, numbers: numbers);
  }).toList();

  int result = 0;
  for (int i = 0; i < lines.length; i++) {
    final line = lines[i];
    print(line);

    final r = calibrationResult(line.result, line.numbers);
    if (r != null) {
      result += r;
    }
  }

  print(result);
}

int? calibrationResult(int result, List<int> numbers) {
  final opNum = numbers.length - 1;
  for (final ops in opPermutations(opNum)) {
    final evaluated = evaluateOperation(numbers, ops);
    if (evaluated == result) {
      return result;
    }
  }

  return null;
}

typedef Operation = int Function(int a, int b);
int add(int a, int b) => a + b;
int multiply(int a, int b) => a * b;
int concat(int a, int b) => int.parse('$a$b');
final List<Operation> operations = [add, multiply, concat];

Iterable<List<Operation>> opPermutations(int length) sync* {
  if (length == 0) {
    yield [];
  } else {
    for (final op in operations) {
      for (final perm in opPermutations(length - 1)) {
        yield [op, ...perm];
      }
    }
  }
}

int evaluateOperation(List<int> numbers, List<Operation> ops) {
  int result = numbers[0];
  for (int i = 0; i < ops.length; i++) {
    final op = ops[i];
    final number = numbers[i + 1];
    result = op(result, number);
  }
  return result;
}
