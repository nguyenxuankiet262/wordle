import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:wordle/common/network/models/request_params.dart';
import 'package:wordle/common/network/rest_api.dart';
import 'package:wordle/features/random_word/data/datasources/word_data_source.dart';
import 'package:wordle/features/random_word/data/datasources/word_data_source_impl.dart';
import 'package:wordle/features/random_word/data/models/word_model.dart';

class MockRestAPI extends Mock implements RestAPI {}

void main() {
  late MockRestAPI mockRestAPI;
  late WordDataSource wordDataSource;

  setUp(() {
    mockRestAPI = MockRestAPI();
    wordDataSource = WordDataSourceImpl(mockRestAPI);
    registerFallbackValue(const RequestParams(guess: "123"));
  });

  group(
    'word_data_source_impl_test',
    () {
      test(
        'should return List<WordModel> if client return data',
        () async {
          // arrange
          const mockData = [WordModel(result: "result", guess: "guess", slot: 1)];
          when(() => mockRestAPI.getWordsByRandomWord(any())).thenAnswer((_) async => mockData);

          // act

          final wordModels = await wordDataSource.getWordsByRandomWord(guessWord: "123");

          // assert
          expect(wordModels, mockData);
        },
      );
    },
  );
}
