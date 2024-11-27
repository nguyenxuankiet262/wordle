import 'package:equatable/equatable.dart';
import 'package:wordle/features/random_word/domain/entities/word.dart';

abstract class WordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Empty extends WordState {
  @override
  List<Object?> get props => [];
}

class Loading extends WordState {
  @override
  List<Object?> get props => [];
}

class Loaded extends WordState {
  final List<Word> words;
  Loaded(this.words);

  @override
  List<Object?> get props => [words];
}

class Error extends WordState {
  final String message;
  Error(this.message);

  @override
  List<Object?> get props => [message];
}
