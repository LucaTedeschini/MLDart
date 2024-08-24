// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:advance_math/advance_math.dart';
import 'package:collection/collection.dart';

class Knn {
  Knn();
  List<Point> points = [];

  List<String> guess(Matrix image, double maxDistance, int nearestNeigh) {
    Map<String, int> distances = {};
    List<dynamic> nearestPoint = [];
    //Compute the distance from each point and sort them
    for (var info in points) {
      var label = info.label;
      var point = info.matrixPoint;
      var distance = (image - point).norm(Norm.frobenius);
      if (distance <= maxDistance) {
        nearestPoint.add([label, distance]);  
      }
    }
    nearestPoint.sort((a, b) => a[1].compareTo(b[1]));
    if (nearestPoint.length > nearestNeigh)
      nearestPoint = nearestPoint.sublist(0, nearestNeigh);
    for (var el in nearestPoint) {
      if (distances.containsKey(el[0])) {
        distances[el[0]] = distances[el[0]]! + 1;
      } else {
        distances[el[0]] = 1;
      }
    }
    
    //Get the most occurring neighbor
    var listaOrdinata = distances.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    List<String> result = [];
    for (var el in listaOrdinata) {
      result.add(el.key);
    }

    if (result.length > 3) result = result.sublist(0, 3);

    return result;
  }

  void loadFromContent(String content) {
    List<Point> points = [];

    List<dynamic> data = json.decode(content);

    points = data.map((e) => Point.fromMap(e)).toList();

    this.points = points;
  }

  void writeToFile(List<dynamic> points) async {
    var outputfile = File("assets/points.data");
    for (var i = 0; i < points.length; i++) {
      var label = points[i][0] as String;
      var point = points[i][1] as List<dynamic>;
      outputfile.writeAsStringSync("$label\n", mode: FileMode.append);
      outputfile.writeAsStringSync(point.toString() + "\n",
          mode: FileMode.append);
    }
  }
}

class Point {
  final String label;
  final List<double> point;
  const Point({
    required this.label,
    required this.point,
  });

  Matrix get matrixPoint {
    return Matrix([point]);
  }

  Point copyWith({
    String? label,
    List<double>? point,
  }) {
    return Point(
      label: label ?? this.label,
      point: point ?? this.point,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'label': label,
      'point': point,
    };
  }

  factory Point.fromMap(Map<String, dynamic> map) {
    return Point(
        label: map['label'] as String,
        point: [for (var el in map['point']) el as double]);
  }

  String toJson() => json.encode(toMap());

  factory Point.fromJson(String source) =>
      Point.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Point(label: $label, point: $point)';

  @override
  bool operator ==(covariant Point other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.label == label && listEquals(other.point, point);
  }

  @override
  int get hashCode => label.hashCode ^ point.hashCode;
}
