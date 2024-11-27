import 'package:wordle/common/network/models/request_params.dart';
import 'package:wordle/common/network/rest_api.dart';
import 'package:wordle/features/random_word/data/datasources/word_data_source.dart';
import 'package:wordle/features/random_word/data/models/word_model.dart';

class WordDataSourceImpl implements WordDataSource {
  final RestAPI client;
  const WordDataSourceImpl(this.client);

  @override
  Future<List<WordModel>> getWordsByRandomWord({required String guessWord}) {
    return client.getWordsByRandomWord(RequestParams(guess: guessWord));
  }
}
