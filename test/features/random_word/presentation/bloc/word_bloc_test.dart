import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:wordle/common/error/failure.dart';
import 'package:wordle/features/random_word/domain/entities/word.dart';
import 'package:wordle/features/random_word/domain/usecases/get_word_by_random_word_use_case.dart';
import 'package:wordle/features/random_word/presentation/bloc/bloc.dart';

class MockGetWordByRandomWordUseCase extends Mock implements GetWordByRandomWordUseCase {}

void main() {
  late MockGetWordByRandomWordUseCase mockGetWordByRandomWordUseCase;
  late WordBloc wordBloc;

  setUp(() {
    mockGetWordByRandomWordUseCase = MockGetWordByRandomWordUseCase();
    wordBloc = WordBloc(mockGetWordByRandomWordUseCase);
    registerFallbackValue(const Params("123"));
  });

  group(
    'word_bloc_test',
    () {
      test(
        'bloc state is Empty when initialize Bloc',
        () async {
          expect(wordBloc.state, Empty());
        },
      );

      test(
        'bloc should emit [Loading, Loaded] when getWordByRandomWordUseCase return Right(List<Word>)',
        () async {
          // arrange
          const mockData = [Word(result: "123")];
          when(() => mockGetWordByRandomWordUseCase(any())).thenAnswer((_) async => const Right(mockData));

          // assert
          final expected = [
            Loading(),
            Loaded(mockData),
          ];
          expectLater(wordBloc.stream, emitsInOrder(expected));

          // act
          wordBloc.add(GetWordByRandomWordEvent("123"));
        },
      );

      test(
        'bloc should emit [Loading, Error(UNKNOWN_ERROR)] when getWordByRandomWordUseCase return Left(UnknownFailure())',
        () async {
          // arrange
          when(() => mockGetWordByRandomWordUseCase(any())).thenAnswer((_) async => Left(UnknownFailure()));

          // assert
          final expected = [
            Loading(),
            Error(UNKNOWN_ERROR),
          ];
          expectLater(wordBloc.stream, emitsInOrder(expected));

          // act
          wordBloc.add(GetWordByRandomWordEvent("123"));
        },
      );

      test(
        'bloc should emit [Loading, Error(ERROR_FROM_SERVER)] when getWordByRandomWordUseCase return Left(ServerFailure())',
        () async {
          // arrange
          when(() => mockGetWordByRandomWordUseCase(any())).thenAnswer((_) async => Left(ServerFailure()));

          // assert
          final expected = [
            Loading(),
            Error(ERROR_FROM_SERVER),
          ];
          expectLater(wordBloc.stream, emitsInOrder(expected));

          // act
          wordBloc.add(GetWordByRandomWordEvent("123"));
        },
      );

      test(
        'bloc should emit [Loading, Error("Guess must be the same length as the word")] when getWordByRandomWordUseCase return Left(ServerFailure(message: "Guess must be the same length as the word"))',
        () async {
          // arrange
          when(() => mockGetWordByRandomWordUseCase(any()))
              .thenAnswer((_) async => Left(ServerFailure(message: "Guess must be the same length as the word")));

          // assert
          final expected = [
            Loading(),
            Error("Guess must be the same length as the word"),
          ];
          expectLater(wordBloc.stream, emitsInOrder(expected));

          // act
          wordBloc.add(GetWordByRandomWordEvent("123"));
        },
      );
    },
  );
}
