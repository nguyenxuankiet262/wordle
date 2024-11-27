import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:wordle/common/error/failure.dart';
import 'package:wordle/features/random_word/domain/entities/word.dart';
import 'package:wordle/features/random_word/domain/repositories/word_repository.dart';
import 'package:wordle/features/random_word/domain/usecases/get_word_by_random_word_use_case.dart';

class MockWordRepository extends Mock implements WordRepository {}

void main() {
  late MockWordRepository mockWordRepository;
  late GetWordByRandomWordUseCase getWordByRandomWordUseCase;

  setUp(() {
    mockWordRepository = MockWordRepository();
    getWordByRandomWordUseCase = GetWordByRandomWordUseCase(mockWordRepository);
  });
  group(
    'get_word_by_random_word_use_case_test',
    () {
      test(
        'should return Right(List<Word>) when wordRepository return data',
        () async {
          // arrange
          const mockData = [Word(result: "123")];
          const params = Params("123");
          when(() => mockWordRepository.getWordsByRandomWord(guessWord: "123")).thenAnswer((_) async => const Right(mockData));

          // act
          final failureOrWords = await getWordByRandomWordUseCase(params);

          // assert
          expect(failureOrWords, const Right(mockData));
        },
      );

      test(
        'should return Left(UnknownFailure()) when wordRepository return Left(UnknownFailure())',
        () async {
          // arrange
          const params = Params("123");
          when(() => mockWordRepository.getWordsByRandomWord(guessWord: "123")).thenAnswer((_) async => Left(UnknownFailure()));

          // act
          final failureOrWords = await getWordByRandomWordUseCase(params);

          // assert
          expect(failureOrWords, Left(UnknownFailure()));
        },
      );

      test(
        'should return Left(ServerFailure("123")) when wordRepository return Left(ServerFailure("123"))',
        () async {
          // arrange
          const params = Params("123");
          when(() => mockWordRepository.getWordsByRandomWord(guessWord: "123")).thenAnswer((_) async => Left(ServerFailure(message: "123")));

          // act
          final failureOrWords = await getWordByRandomWordUseCase(params);

          // assert
          expect(failureOrWords, Left(ServerFailure(message: "123")));
        },
      );
    },
  );
}
