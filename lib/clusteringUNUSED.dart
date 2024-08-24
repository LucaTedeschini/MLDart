import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:advance_math/advance_math.dart';

class Clustering {
  Map<String, Matrix> centroids = Map<String, Matrix>();

  Clustering();

  void findCentroids(Matrix matrix, List<String> labels) {
    /// Non serve più, serviva a calcolare i centroidi ma ora sono già
    /// salvati su file. Così facendo, non serve più il file images.csv
    /// che pesava tanto. NON chiamare questo metodo, NON eliminare
    /// questo metodo che torna utile se bisogna aumentare il dataset
    var matrix_map_list = Map<String, List<List<dynamic>>>();
    for (int i = 0; i < labels.length; i++) {
      if (matrix_map_list.containsKey(labels[i])) {
        matrix_map_list[labels[i]]!.add(matrix.row(i).toList().flatten);
      } else {
        matrix_map_list[labels[i]] = List<List<dynamic>>.empty(growable: true);
        matrix_map_list[labels[i]]!.add(matrix.row(i).toList().flatten);
      }
    }

    var matrix_map = Map<String, Matrix>();
    for (var lab in matrix_map_list.keys) {
      matrix_map[lab] = Matrix(matrix_map_list[lab]);
    }

    var centroic_map = Map<String, List<double>>();
    for (var lab in matrix_map.keys) {
      var centroid_list = List<double>.empty(growable: true);
      for (int i = 0; i < matrix_map[lab]!.columnCount; i++) {
        centroid_list.add(matrix_map[lab]!.column(i).mean() as double);
      }
      centroic_map[lab] = centroid_list;
    }
    var file = File("centroids100.json");
    file.writeAsString(json.encode(centroic_map));
  }

  void loadCentroids(String filecontent) async {
    /// Questa funzione legge il contenuto di centroids.json e lo salva nella
    /// Map<String,Matrix>.

    // Legge da file
    //var file = File("assets/centroids100.json");
    //var filecontent = await file.readAsString();
    //var jsoncontent = json.decode(filecontent) as Map<String, dynamic>;

    // Prende la stringa in input
    var jsoncontent = json.decode(filecontent) as Map<String, dynamic>;

    for (var key in jsoncontent.keys) {
      List<double> convertedList = (jsoncontent[key] as List<dynamic>)
          .map((item) => (item as num).toDouble())
          .toList();
      this.centroids[key] = Matrix([convertedList]);
    }
  }

  SplayTreeMap distance(Matrix point) {
    /// Funzione che restituisce la distanza da ogni centroide dell'immagine
    /// passata in input. L'immagine in input deve prima passare dalla PCA
    Map<String, num> distances = Map<String, num>();
    for (var i in centroids.keys) {
      distances[i] = (centroids[i]! - point).norm(Norm.frobenius);
    }
    var sorted = SplayTreeMap.from(distances,
        (key1, key2) => distances[key1]!.compareTo(distances[key2]!));

    // IMPORTANT! aumentare questa sublist per restituire più risultati corretti
    // Con due è abbastanza preciso, però alcuni disegni fa fatica. Con tre prende
    // anche troppo
    return sorted;
  }
}
