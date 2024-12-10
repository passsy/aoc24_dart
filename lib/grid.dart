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

  T? getValue(Point coordinate) {
    return metadata[coordinate];
  }

  ValuedPoint<T> getValuedCoordinate(Point coordinate) {
    final value = metadata[coordinate];
    return coordinate.withValue(value);
  }

  void setValue(Point coordinate, T value) {
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
        final valued = getValuedCoordinate(point);
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

extension ToValuedCoordiate on Point {
  ValuedPoint<T?> withValue<T>(T? value) {
    return (x: x, y: y, value: value);
  }

  Point get north => (x: x, y: y - 1);
  Point get south => (x: x, y: y + 1);
  Point get east => (x: x + 1, y: y);
  Point get west => (x: x - 1, y: y);
  Point get northeast => (x: x + 1, y: y - 1);
  Point get northwest => (x: x - 1, y: y - 1);
  Point get southeast => (x: x + 1, y: y + 1);
  Point get southwest => (x: x - 1, y: y + 1);
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
      points.add(getValuedCoordinate(west)!);
    }
    if (!isOutOfBounds(east)) {
      points.add(getValuedCoordinate(east)!);
    }
    if (!isOutOfBounds(north)) {
      points.add(getValuedCoordinate(north)!);
    }
    if (!isOutOfBounds(south)) {
      points.add(getValuedCoordinate(south)!);
    }

    return points;
  }

  List<ValuedPoint<T>> neighborsDiagonalOf(Point point) {
    final List<ValuedPoint<T>> points = [];
    final northwest = point.northwest;
    final northeast = point.northeast;
    final southwest = point.southwest;
    final southeast = point.southeast;
    if (!isOutOfBounds(northwest)) {
      points.add(getValuedCoordinate(northwest)!);
    }
    if (!isOutOfBounds(northeast)) {
      points.add(getValuedCoordinate(northeast)!);
    }
    if (!isOutOfBounds(southwest)) {
      points.add(getValuedCoordinate(southwest)!);
    }
    if (!isOutOfBounds(southeast)) {
      points.add(getValuedCoordinate(southeast)!);
    }
    return points;
  }
}
