import 'package:wordle/features/random_word/data/models/word_model.dart';

abstract class WordDataSource {
  Future<List<WordModel>> getWordsByRandomWord({required String guessWord});
}
