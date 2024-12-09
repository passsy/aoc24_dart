import 'package:dartx/dartx.dart';

const sampleSolution = '1928';

void solveDay09(String input) {
  // https://adventofcode.com/2024/day/9
  // Solve Part 1 here

  final freeSpace = FreeSpace(1);
  final List<DiskSection> memory = List.generate(100000, (_) => freeSpace);

  void printMemory() {
    final fromBehind =
        memory.reversed.toList().indexWhere((element) => element is FileOnDisk);
    final firstFreeSpace = memory.length - fromBehind;
    final content = memory.sublist(0, firstFreeSpace);
    final s = content.joinToString(
      transform: (it) {
        if (it is FileOnDisk) {
          return '${it.id}';
        }
        return '.';
      },
      separator: '',
    );
    print(s);
  }

  int id = 0;
  final lines = input.split('').mapIndexed((index, line) {
    final DiskSection item;
    if (index % 2 == 0) {
      item = FileOnDisk(id, int.parse(line));
      id++;
    } else {
      item = FreeSpace(int.parse(line));
    }
    return item;
  }).toList();

  int sectionIndex = 0;
  int indexInSection = 0;
  for (int i = 0; i < 100000; i++) {
    if (sectionIndex >= lines.length) {
      break;
    }
    final section = lines[sectionIndex];
    if (section is FreeSpace) {
      if (section.length == 0) {
        indexInSection = 0;
        sectionIndex++;
        i--;
        continue;
      }
    }
    if (section.length == indexInSection + 1) {
      indexInSection = 0;
      sectionIndex++;
    } else {
      indexInSection += 1;
    }

    memory[i] = section;
  }

  printMemory();

  while (true) {
    final movedIndex = defragment(memory);
    if (movedIndex == null) {
      break;
    }
  }
  printMemory();

  final checksum = memory.mapIndexed((index, element) {
    if (element is FileOnDisk) {
      return index * element.id;
    }
    return 0;
  }).sum();

  print(checksum);
}

int? defragment(List<DiskSection> memory) {
  final firstFreeSpace = memory.indexWhere((element) => element is FreeSpace);
  final lastFile = memory.lastIndexWhere((element) => element is FileOnDisk);
  if (firstFreeSpace - 1 == lastFile) {
    return null;
  }
  memory[firstFreeSpace] = memory[lastFile];
  memory[lastFile] = FreeSpace(1);
  return firstFreeSpace;
}

class DiskSection {
  final int length;
  DiskSection(this.length);
}

class FileOnDisk extends DiskSection {
  final int id;
  FileOnDisk(this.id, super.length);

  @override
  String toString() {
    return 'FileOnDisk{id: $id, length: $length}';
  }
}

class FreeSpace extends DiskSection {
  FreeSpace(super.length);

  @override
  String toString() {
    return 'FreeSpace{length: $length}';
  }
}
