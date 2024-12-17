// https://adventofcode.com/2024/day/17
import 'dart:math';

void solveDay17(String input) {
  final a = RegExp(r'Register A: (\d+)').allMatches(input);
  final aValue = int.parse(a.first.group(1)!);
  final b = RegExp(r'Register B: (\d+)').allMatches(input);
  final bValue = int.parse(b.first.group(1)!);
  final c = RegExp(r'Register C: (\d+)').allMatches(input);
  final cValue = int.parse(c.first.group(1)!);
  final program = RegExp(r'Program: (.+)').allMatches(input);
  final programValue = program.first.group(1)!;
  final programValues = programValue.split(',').map(int.parse).toList();

  final interpreter = Interpreter();
  interpreter.rA = aValue;
  interpreter.rB = bValue;
  interpreter.rC = cValue;
  final output = interpreter.runProgram(programValues);

  print(output.join(','));
}

class Interpreter {
  int rA = 0;
  int rB = 0;
  int rC = 0;

  List<int> runProgram(List<int> program) {
    int instructionPointer = 0;
    final output = <int>[];

    while (true) {
      if (instructionPointer >= program.length) {
        break;
      }
      final opcode = program[instructionPointer];
      final operandBase10 = program[instructionPointer + 1].toUnsigned(3);

      final combo = switch (operandBase10) {
        0 || 1 || 2 || 3 => operandBase10,
        4 => rA,
        5 => rB,
        6 => rC,
        7 => throw Exception('Invalid operand $operandBase10'),
        _ => 0
      };

      switch (opcode) {
        case 0:
          // adv
          final d = pow(2, combo);
          final result = rA ~/ d;
          rA = result;
          instructionPointer += 2;
        case 1:
          // bxl
          rB = rB ^ operandBase10;
          instructionPointer += 2;
        case 2:
          // bst
          rB = combo % 8;
          instructionPointer += 2;
        case 3:
          // jnz
          if (rA != 0) {
            instructionPointer = operandBase10;
          } else {
            instructionPointer += 2;
          }
        case 4:
          // bxc
          rB = rB ^ rC;
          instructionPointer += 2;
        case 5:
          // out
          final out = combo % 8;
          output.add(out);
          instructionPointer += 2;
        case 6:
          // bdv
          final d = pow(2, combo);
          final result = rA ~/ d;
          rB = result;
          instructionPointer += 2;
        case 7:
          // cdv
          final d = pow(2, combo);
          final result = rA ~/ d;
          rC = result;
          instructionPointer += 2;
        default:
          break;
      }
    }

    return output;
  }
}
