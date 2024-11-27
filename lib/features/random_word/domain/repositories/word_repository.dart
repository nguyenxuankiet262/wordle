import 'package:dartz/dartz.dart';
import 'package:wordle/common/error/failure.dart';
import 'package:wordle/features/random_word/domain/entities/word.dart';

abstract class WordRepository {
  Future<Either<Failure, List<Word>>> getWordsByRandomWord({required String guessWord});
}
