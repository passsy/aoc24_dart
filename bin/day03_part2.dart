const sampleSolution = '48';

void solveDay03(String input) {
  // https://adventofcode.com/2024/day/3
  // Solve Part 2 here
  final lines = input.split('\n');

  int result = 0;

  bool multiply = true;
  for (final line in lines) {
    final tokens = lex(line);
    for (final token in tokens) {
      if (token is Do) {
        multiply = true;
      }
      if (token is Dont) {
        multiply = false;
      }

      if (token is Mul) {
        final a = token.a;
        final b = token.b;
        if (multiply) {
          print('do: $a * $b');
          result += a * b;
        } else {
          print('dont: $a * $b');
        }
      }

      throw 'Unknown token: $token';
    }
  }

  print(result);
}

List<Token> lex(String line) {
  final tokens = <Token>[];

  int character = 0;
  while (true) {
    if (character >= line.length) {
      break;
    }
    final remaining = line.substring(character);
    if (remaining.startsWith('do()')) {
      tokens.add(Do(column: character, text: 'do()'));
      character += 4;
      continue;
    }
    if (remaining.startsWith("don't()")) {
      tokens.add(Dont(column: character, text: "don't()"));
      character += 7;
      continue;
    }

    if (remaining.startsWith('mul(')) {
      final match =
          RegExp(r'^mul\((\d{1,3}),(\d{1,3})\)').firstMatch(remaining);
      if (match == null) {
        character += 1;
        continue;
      }
      final a = int.parse(match.group(1)!);
      final b = int.parse(match.group(2)!);
      tokens.add(Mul(a, b, column: character, text: match.group(0)!));
      character += match.end;
      continue;
    }

    // nothing
    character += 1;
  }

  return tokens;
}

class Token {
  Token({required this.column, required this.text});
  final int column;
  final String text;

  @override
  // ignore: no_runtimetype_tostring
  String toString() => '${runtimeType}($text) @ $column';
}

class Mul extends Token {
  final int a;
  final int b;
  Mul(this.a, this.b, {required super.column, required super.text});

  @override
  String toString() => 'Mul($a, $b, $text) @ $column';
}

class Do extends Token {
  Do({required super.column, required super.text});
}

class Dont extends Token {
  Dont({required super.column, required super.text});
}
