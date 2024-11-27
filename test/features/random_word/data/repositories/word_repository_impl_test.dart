import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:wordle/common/error/failure.dart';
import 'package:wordle/features/random_word/data/datasources/word_data_source.dart';
import 'package:wordle/features/random_word/data/repositories/word_repository_impl.dart';
import 'package:wordle/features/random_word/domain/repositories/word_repository.dart';

class MockWordDataSource extends Mock implements WordDataSource {}

void main() {
  late MockWordDataSource mockWordDataSource;
  late WordRepository wordRepository;

  setUp(() {
    mockWordDataSource = MockWordDataSource();
    wordRepository = WordRepositoryImpl(mockWordDataSource);
  });

  group(
    'word_repository_impl_test',
    () {
      test(
        'should return Left(UnknownFailure()) when wordDataSource throw DioException but error response has no "data"',
        () async {
          // arrange
          when(() => mockWordDataSource.getWordsByRandomWord(guessWord: "123")).thenThrow(DioException(requestOptions: RequestOptions()));

          // act
          final failureOrWords = await wordRepository.getWordsByRandomWord(guessWord: "123");

          // assert
          expect(failureOrWords, Left(UnknownFailure()));
        },
      );

      test(
        'should return Left(ServerFailure("Guess must be the same length as the word")) when wordDataSource throw DioException and error response has "data" message as String',
        () async {
          // arrange
          when(() => mockWordDataSource.getWordsByRandomWord(guessWord: "123")).thenThrow(
            DioException(
              requestOptions: RequestOptions(),
              response: Response(requestOptions: RequestOptions(), data: "Guess must be the same length as the word"),
            ),
          );

          // act
          final failureOrWords = await wordRepository.getWordsByRandomWord(guessWord: "123");

          // assert
          expect(failureOrWords, Left(ServerFailure(message: "Guess must be the same length as the word")));
        },
      );

      test(
        'should return Left(UnknownFailure()) when wordDataSource throw DioException and error response has "data" message not String and not having "detail" List',
        () async {
          // arrange
          when(() => mockWordDataSource.getWordsByRandomWord(guessWord: "123")).thenThrow(
            DioException(
              requestOptions: RequestOptions(),
              response: Response(requestOptions: RequestOptions(), data: {"details": {}}),
            ),
          );

          // act
          final failureOrWords = await wordRepository.getWordsByRandomWord(guessWord: "123");

          // assert
          expect(failureOrWords, Left(UnknownFailure()));
        },
      );

      test(
        'should return Left(ServerFailure("field required")) when wordDataSource throw DioException and error response has "detail" in "data" message',
        () async {
          // arrange
          when(() => mockWordDataSource.getWordsByRandomWord(guessWord: "123")).thenThrow(
            DioException(
              requestOptions: RequestOptions(),
              response: Response(requestOptions: RequestOptions(), data: {
                "detail": [
                  {
                    "loc": ["query", "guess"],
                    "msg": "field required",
                    "type": "value_error.missing"
                  }
                ]
              }),
            ),
          );

          // act
          final failureOrWords = await wordRepository.getWordsByRandomWord(guessWord: "123");

          // assert
          expect(failureOrWords, Left(ServerFailure(message: "field required")));
        },
      );

      test(
        'should return Left(UnknownFailure()) when wordDataSource throw DioException and error response has "detail" in "data" message but wrong format',
        () async {
          // arrange
          when(() => mockWordDataSource.getWordsByRandomWord(guessWord: "123")).thenThrow(
            DioException(
              requestOptions: RequestOptions(),
              response: Response(requestOptions: RequestOptions(), data: {
                "detail": [
                  {
                    "loc": ["query", "guess"],
                    "msgs": "field required", // this is wrong field. the correct field is "msg"
                    "type": "value_error.missing"
                  }
                ]
              }),
            ),
          );

          // act
          final failureOrWords = await wordRepository.getWordsByRandomWord(guessWord: "123");

          // assert
          expect(failureOrWords, Left(UnknownFailure()));
        },
      );
    },
  );
}
