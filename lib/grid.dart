import 'dart:collection';

class AocGrid<T> {
  late final String textRepresentation;
  late final int width;
  late final int height;
  Map<Point, T?> metadata = {};

  T Function(String data, Point point) mapPoint;
  String Function(T data, Point point)? pointToString;

  String Function(T data, Point point) get pointToStringOrDefault {
    return pointToString ?? (data, point) => data.toString();
  }

  AocGrid({required String data, required this.mapPoint, this.pointToString}) {
    textRepresentation = data;
    final raw2d = data.split('\n').map((it) => it.split('')).toList();
    height = raw2d.length;
    width = raw2d[0].length;

    for (int y = 0; y < raw2d.length; y++) {
      final row = raw2d[y];
      for (int x = 0; x < row.length; x++) {
        final mapped = mapPoint(row[x], (x: x, y: y));
        metadata[(x: x, y: y)] = mapped;
      }
    }
  }

  AocGrid._copy({
    required this.textRepresentation,
    required this.width,
    required this.height,
    required this.metadata,
    required this.mapPoint,
    this.pointToString,
  });

  Iterable<GridPoint<T>> getAllGridPoints() sync* {
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final point = (x: x, y: y);
        final value = getValueOrNull(point);
        yield point.withValue(value);
      }
    }
  }

  Iterable<Point> getAllPoints() sync* {
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        yield (x: x, y: y);
      }
    }
  }

  T getValue(Point coordinate) {
    if (isOutOfBounds(coordinate)) {
      throw RangeError('Coordinate $coordinate is out of bounds');
    }
    return metadata[coordinate] as T;
  }

  T? getValueOrNull(Point coordinate) {
    return metadata[coordinate];
  }

  GridPoint<T> getGridPointFor(int x, int y) {
    return getGridPoint((x: x, y: y));
  }

  GridPoint<T> getGridPoint(Point coordinate) {
    if (isOutOfBounds(coordinate)) {
      throw RangeError('Coordinate $coordinate is out of bounds');
    }
    final value = metadata[coordinate];
    return coordinate.withValue(value);
  }

  /// returns out of bounds values
  GridPoint<T> getGridPointWithOOB(Point coordinate) {
    final value = metadata[coordinate];
    return coordinate.withValue(value);
  }

  void setValue(Point coordinate, T value) {
    if (isOutOfBounds(coordinate)) {
      throw RangeError('Coordinate $coordinate is out of bounds');
    }
    metadata[coordinate] = value;
  }

  bool isOutOfBounds(Point coordinate) {
    return coordinate.x < 0 ||
        coordinate.x >= width ||
        coordinate.y < 0 ||
        coordinate.y >= height;
  }

  List<GridPoint<T>> findAll(bool Function(GridPoint<T>) selector) {
    final List<GridPoint<T>> points = [];
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final point = (x: x, y: y);
        final valued = getGridPoint(point);
        if (selector(valued)) {
          points.add(valued);
        }
      }
    }
    return points;
  }

  GridPoint<T> findFirst(bool Function(GridPoint<T>) selector) {
    return findAll(selector).first;
  }

  void printToConsole() {
    final sb = StringBuffer();
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final point = (x: x, y: y);
        final value = getValue(point);
        final char = pointToStringOrDefault(value, point);
        sb.write(char);
      }
      sb.write('\n');
    }
    sb.write('\n');

    print(sb);
  }

  AocGrid<T> copy() {
    return AocGrid._copy(
      textRepresentation: textRepresentation,
      width: width,
      height: height,
      metadata: Map.of(metadata),
      mapPoint: mapPoint,
      pointToString: pointToString,
    );
  }
}

typedef Point = ({int x, int y});

typedef GridPoint<T> = ({int x, int y, T? value});

extension ToValuedPoint on Point {
  GridPoint<T?> withValue<T>(T? value) {
    return (x: x, y: y, value: value);
  }
}

extension PointNeighbours on Point {
  Point get north => (x: x, y: y - 1);
  Point get south => (x: x, y: y + 1);
  Point get east => (x: x + 1, y: y);
  Point get west => (x: x - 1, y: y);
  Point get northEast => (x: x + 1, y: y - 1);
  Point get northWest => (x: x - 1, y: y - 1);
  Point get southEast => (x: x + 1, y: y + 1);
  Point get southWest => (x: x - 1, y: y + 1);
}

extension ValuedPointNeighbours on GridPoint {
  Point get north => (x: x, y: y - 1);
  Point get south => (x: x, y: y + 1);
  Point get east => (x: x + 1, y: y);
  Point get west => (x: x - 1, y: y);
  Point get northEast => (x: x + 1, y: y - 1);
  Point get northWest => (x: x - 1, y: y - 1);
  Point get southEast => (x: x + 1, y: y + 1);
  Point get southWest => (x: x - 1, y: y + 1);
}

extension ToPoint on GridPoint {
  Point get point {
    return (x: x, y: y);
  }
}

extension Neighbors<T> on AocGrid<T> {
  // TODO rename to adjacent?
  List<GridPoint<T>> neighborsNoswOf(
    Point point, {
    bool includeOutOfBounds = false,
  }) {
    final List<GridPoint<T>> points = [];
    final west = point.west;
    final east = point.east;
    final north = point.north;
    final south = point.south;
    if (includeOutOfBounds) {
      points.add(getGridPointWithOOB(west));
    } else if (!isOutOfBounds(west)) {
      points.add(getGridPoint(west));
    }
    if (includeOutOfBounds) {
      points.add(getGridPointWithOOB(east));
    } else if (!isOutOfBounds(east)) {
      points.add(getGridPoint(east));
    }
    if (includeOutOfBounds) {
      points.add(getGridPointWithOOB(north));
    } else if (!isOutOfBounds(north)) {
      points.add(getGridPoint(north));
    }
    if (includeOutOfBounds) {
      points.add(getGridPointWithOOB(south));
    } else if (!isOutOfBounds(south)) {
      points.add(getGridPoint(south));
    }

    return points;
  }

  List<GridPoint<T>> neighborsDiagonalOf(
    Point point, {
    bool includeOutOfBounds = false,
  }) {
    final List<GridPoint<T>> points = [];
    final northwest = point.northWest;
    final northeast = point.northEast;
    final southwest = point.southWest;
    final southeast = point.southEast;
    if (includeOutOfBounds) {
      points.add(getGridPointWithOOB(northwest));
    } else if (!isOutOfBounds(northwest)) {
      points.add(getGridPoint(northwest));
    }
    if (includeOutOfBounds) {
      points.add(getGridPointWithOOB(northeast));
    } else if (!isOutOfBounds(northeast)) {
      points.add(getGridPoint(northeast));
    }
    if (includeOutOfBounds) {
      points.add(getGridPointWithOOB(southwest));
    } else if (!isOutOfBounds(southwest)) {
      points.add(getGridPoint(southwest));
    }
    if (includeOutOfBounds) {
      points.add(getGridPointWithOOB(southeast));
    } else if (!isOutOfBounds(southeast)) {
      points.add(getGridPoint(southeast));
    }
    return points;
  }
}

extension PointInDirection<T> on AocGrid<T> {
  Iterable<GridPoint<T>> pointsInDirection(
      Point point, Point Function(Point) nextPoint) sync* {
    Point next = point;
    while (true) {
      if (isOutOfBounds(next)) {
        return;
      }
      yield getGridPoint(next);
      next = nextPoint(next);
    }
  }
}

typedef MoveDirection = Point Function(Point point);

Point oneNorth(Point point) => (x: point.x, y: point.y - 1);
Point oneEast(Point point) => (x: point.x + 1, y: point.y);
Point oneSouth(Point point) => (x: point.x, y: point.y + 1);
Point oneWest(Point point) => (x: point.x - 1, y: point.y);

extension RotateMoveDirection on MoveDirection {
  MoveDirection rotateRight() {
    if (this == oneNorth) {
      return oneEast;
    }
    if (this == oneEast) {
      return oneSouth;
    }
    if (this == oneSouth) {
      return oneWest;
    }
    if (this == oneWest) {
      return oneNorth;
    }
    throw Exception('Unknown direction');
  }

  MoveDirection rotateLeft() {
    if (this == oneNorth) {
      return oneWest;
    }
    if (this == oneWest) {
      return oneSouth;
    }
    if (this == oneSouth) {
      return oneEast;
    }
    if (this == oneEast) {
      return oneNorth;
    }
    throw Exception('Unknown direction');
  }
}

extension SearchAllPaths<T> on AocGrid<T> {
  List<GridPoint<T>> findFastestPaths(
    Point start,
    Point end, {
    required bool Function(GridPoint<T>) isPath,
    int Function(List<GridPoint<T>> path)? cost,
  }) {
    final costFunction = cost ?? ((it) => 1);
    final pathTiles = getAllGridPoints().where((it) => isPath(it)).toList();
    final startTile = pathTiles.firstWhere((it) => it.point == start);
    final endTile = pathTiles.firstWhere((it) => it.point == end);

    // djiikstra's algorithm, but custom cost function

    final map = HashMap<GridPoint<T>, int>();
    final previous = HashMap<GridPoint<T>, GridPoint<T>>();
    final visited = HashSet<GridPoint<T>>();
    final unvisited = HashSet<GridPoint<T>>.from(pathTiles);

    map[startTile] = 0;

    while (unvisited.isNotEmpty) {
      final current = unvisited.reduce((a, b) =>
          (map[a] ?? 1_000_000_000) < (map[b] ?? 1_000_000_000) ? a : b);
      unvisited.remove(current);
      visited.add(current);

      final neighbors = neighborsNoswOf(current.point);
      for (final neighbor in neighbors) {
        if (!isPath(neighbor)) {
          continue;
        }
        if (visited.contains(neighbor)) {
          continue;
        }

        final List<GridPoint<T>> pathUntilNow = [neighbor];
        var currentPoint = current;
        while (currentPoint != startTile) {
          pathUntilNow.add(currentPoint);
          currentPoint = previous[currentPoint]!;
        }
        pathUntilNow.add(startTile);

        final tentativeScore = costFunction(pathUntilNow);
        final neighborScore = map[neighbor] ?? 1_000_000_000;
        if (tentativeScore < neighborScore) {
          map[neighbor] = tentativeScore;
          previous[neighbor] = current;
        }
      }
    }

    final path = <GridPoint<T>>[];
    var current = endTile;
    while (current != startTile) {
      path.add(current);
      current = previous[current]!;
    }
    path.add(startTile);

    return path.reversed.toList();
  }
}
