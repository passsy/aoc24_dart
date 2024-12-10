class AocGrid<T> {
  late final String textRepresentation;
  late final int width;
  late final int height;
  late final List<List<String>> raw2d;
  Map<Point, T?> metadata = {};

  T? Function(String data, Point point) mapPoint;

  AocGrid({required String data, required this.mapPoint}) {
    textRepresentation = data;
    raw2d = data.split('\n').map((it) => it.split('')).toList();
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

  T getValue(Point coordinate) {
    if (isOutOfBounds(coordinate)) {
      throw RangeError('Coordinate $coordinate is out of bounds');
    }
    return metadata[coordinate]!;
  }

  T? getValueOrNull(Point coordinate) {
    return metadata[coordinate];
  }

  ValuedPoint<T> getValuedPoint(Point coordinate) {
    if (isOutOfBounds(coordinate)) {
      throw RangeError('Coordinate $coordinate is out of bounds');
    }
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

  List<ValuedPoint<T>> findAll(bool Function(ValuedPoint<T>) selector) {
    final List<ValuedPoint<T>> points = [];
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final point = (x: x, y: y);
        final valued = getValuedPoint(point);
        if (selector(valued)) {
          points.add(valued);
        }
      }
    }
    return points;
  }
}

typedef Point = ({int x, int y});

typedef ValuedPoint<T> = ({int x, int y, T? value});

extension ToValuedPoint on Point {
  ValuedPoint<T?> withValue<T>(T? value) {
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

extension ValuedPointNeighbours on ValuedPoint {
  Point get north => (x: x, y: y - 1);
  Point get south => (x: x, y: y + 1);
  Point get east => (x: x + 1, y: y);
  Point get west => (x: x - 1, y: y);
  Point get northEast => (x: x + 1, y: y - 1);
  Point get northWest => (x: x - 1, y: y - 1);
  Point get southEast => (x: x + 1, y: y + 1);
  Point get southWest => (x: x - 1, y: y + 1);
}

extension ToPoint on ValuedPoint {
  Point get point {
    return (x: x, y: y);
  }
}

extension Neighbors<T> on AocGrid<T> {
  List<ValuedPoint<T>> neighborsNoswOf(Point point) {
    final List<ValuedPoint<T>> points = [];
    final west = point.west;
    final east = point.east;
    final north = point.north;
    final south = point.south;
    if (!isOutOfBounds(west)) {
      points.add(getValuedPoint(west)!);
    }
    if (!isOutOfBounds(east)) {
      points.add(getValuedPoint(east)!);
    }
    if (!isOutOfBounds(north)) {
      points.add(getValuedPoint(north)!);
    }
    if (!isOutOfBounds(south)) {
      points.add(getValuedPoint(south)!);
    }

    return points;
  }

  List<ValuedPoint<T>> neighborsDiagonalOf(Point point) {
    final List<ValuedPoint<T>> points = [];
    final northwest = point.northWest;
    final northeast = point.northEast;
    final southwest = point.southWest;
    final southeast = point.southEast;
    if (!isOutOfBounds(northwest)) {
      points.add(getValuedPoint(northwest)!);
    }
    if (!isOutOfBounds(northeast)) {
      points.add(getValuedPoint(northeast)!);
    }
    if (!isOutOfBounds(southwest)) {
      points.add(getValuedPoint(southwest)!);
    }
    if (!isOutOfBounds(southeast)) {
      points.add(getValuedPoint(southeast)!);
    }
    return points;
  }
}

extension PointInDirection<T> on AocGrid<T> {
  Iterable<ValuedPoint<T>> pointsInDirection(
      Point point, Point Function(Point) nextPoint) sync* {
    Point next = point;
    while (true) {
      if (isOutOfBounds(next)) {
        return;
      }
      yield getValuedPoint(next);
      next = nextPoint(next);
    }
  }
}
