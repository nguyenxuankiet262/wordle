import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wordle/common/network/models/request_params.dart';
import 'package:wordle/features/random_word/data/models/word_model.dart';

part 'rest_api.g.dart';

@RestApi()
abstract class RestAPI {
  factory RestAPI(Dio dio, {String baseUrl}) = _RestAPI;

  @GET("/random")
  Future<List<WordModel>> getWordsByRandomWord(@Queries() RequestParams params);
}
