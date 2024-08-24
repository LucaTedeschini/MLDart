
import 'package:advance_math/advance_math.dart';
import 'package:flutter/services.dart' show rootBundle;

class Pca {
  Matrix projection_matrix = Matrix();
  Pca();
 
  Future<void> loadPCA(String fileContent) async {
    // Read from file
    //var file = await File("assets/PCA.csv").readAsString();
    //Matrix matrix = await Matrix.fromCSV(csv: file);

    // Read from input string
    Matrix matrix = await Matrix.fromCSV(csv: fileContent);
    this.projection_matrix = matrix;
  }

  Matrix predict(Matrix matrix) {
    return matrix.dot(this.projection_matrix.transpose());
  }
}
