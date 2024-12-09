import 'package:dartx/dartx.dart';

const sampleSolution = '2858';

void solveDay09(String input) {
  // https://adventofcode.com/2024/day/9
  // Solve Part 2 here

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
  final outline = input.split('').mapIndexed((index, line) {
    final DiskSection item;
    if (index % 2 == 0) {
      item = FileOnDisk(id, int.parse(line));
      id++;
    } else {
      item = FreeSpace(int.parse(line));
    }
    return item;
  }).toList();

  defragOutline(outline);

  int sectionIndex = 0;
  int indexInSection = 0;
  for (int i = 0; i < 100000; i++) {
    if (sectionIndex >= outline.length) {
      break;
    }
    final section = outline[sectionIndex];
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

  final checksum = memory.mapIndexed((index, element) {
    if (element is FileOnDisk) {
      return index * element.id;
    }
    return 0;
  }).sum();

  print(checksum);
}

void defragOutline(List<DiskSection> memory) {
  final files = memory.reversed.whereType<FileOnDisk>();

  void trimFreeSpace() {
    for (int i = 0; i < memory.length; i++) {
      if (memory[i] is FreeSpace && memory[i].length == 0) {
        memory.removeAt(i);
        i--;
      }
      if (i + 1 < memory.length &&
          memory[i] is FreeSpace &&
          memory[i + 1] is FreeSpace) {
        memory[i] = FreeSpace(memory[i].length + memory[i + 1].length);
        memory.removeAt(i + 1);
        i--;
      }
    }
  }

  for (final file in files.toList()) {
    trimFreeSpace();
    final freeSpaces = memory.whereType<FreeSpace>();
    final firstBigEnough =
        freeSpaces.firstOrNullWhere((it) => it.length >= file.length);
    if (firstBigEnough == null) {
      continue;
    }
    final spaceIndex = memory.indexOf(firstBigEnough);
    final itemIndex = memory.indexOf(file);
    if (spaceIndex > itemIndex) {
      continue;
    }
    final remainingSpace = firstBigEnough.length - file.length;
    memory[itemIndex] = FreeSpace(file.length);
    memory[spaceIndex] = file;
    if (remainingSpace > 0) {
      memory.insert(spaceIndex + 1, FreeSpace(remainingSpace));
    }
  }
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
