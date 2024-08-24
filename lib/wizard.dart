import 'dart:typed_data';
import 'package:advance_math/advance_math.dart';
import 'package:ml_dart_wizard/knn.dart';
import 'package:ml_dart_wizard/models/guess_result.dart';
import 'package:ml_dart_wizard/pca.dart';

class Wizard {
  Pca pca = Pca();
  Knn knn = Knn();
  Wizard();
  Future<GuessState> guess(Uint8List imageUint) async {
    List<double> imageDouble = List<double>.empty(growable: true);
    List<num> imageInt = List<num>.empty(growable: true);
    //Convert the image into a Matrix
    for (int i = 0; i < 64 * 64; i++) {
      imageUint[(i * 4) + 3] = abs(imageUint[(i * 4) + 3]).toInt();
      imageInt.add(imageUint[(i * 4) + 3]);
      imageDouble.add(imageUint[(i * 4) + 3].toDouble() / 255);
    }
    Matrix imageMat = Matrix([imageDouble]);

    //Check if the Whiteboard has enough color to be considered a sketch
    if (imageInt.sum().toInt() / (255 * 64 * 64) < 0.015) {
      return EmptyGuessResult();
    }

    //Project the matrix
    var imageMatPca = pca.predict(imageMat);
    //Guess the label
    var inference = knn.guess(imageMatPca, 4, 20);

    return GuessResult(
      guesses: inference,
    );
  }

  Future<bool> startPca(String pcaFileContent) async {
    await pca.loadPCA(pcaFileContent);
    return true;
  }

  Future<bool> startPointFinder(String content) async {
    knn.loadFromContent(content);
    return true;
  }
}
