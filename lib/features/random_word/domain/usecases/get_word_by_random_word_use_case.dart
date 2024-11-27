import 'package:dartz/dartz.dart';
import 'package:wordle/common/error/failure.dart';
import 'package:wordle/common/usecase/usecase.dart';
import 'package:wordle/features/random_word/domain/entities/word.dart';
import 'package:wordle/features/random_word/domain/repositories/word_repository.dart';

class GetWordByRandomWordUseCase implements UseCase<List<Word>, Params> {
  final WordRepository wordRepository;
  const GetWordByRandomWordUseCase(this.wordRepository);

  @override
  Future<Either<Failure, List<Word>>> call(Params params) {
    return wordRepository.getWordsByRandomWord(guessWord: params.guessWord);
  }
}

class Params {
  final String guessWord;
  const Params(this.guessWord);
}
