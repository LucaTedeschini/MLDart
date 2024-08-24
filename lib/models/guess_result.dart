// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

abstract class GuessState {}

class EmptyGuessResult extends GuessState {}

class GuessResult extends GuessState {
  final List<String> guesses;
  GuessResult({
    required this.guesses,
  });

  String topGuess() {
    Random random = Random();
    return guesses[random.nextInt(guesses.length)];
  }

  @override
  String toString() => 'GuessResult(guesses: $guesses)';
}
