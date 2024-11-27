import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:wordle/common/error/failure.dart';
import 'package:wordle/common/network/models/response_error.dart';
import 'package:wordle/features/random_word/data/datasources/word_data_source.dart';
import 'package:wordle/features/random_word/domain/entities/word.dart';
import 'package:wordle/features/random_word/domain/repositories/word_repository.dart';

class WordRepositoryImpl implements WordRepository {
  final WordDataSource wordDataSource;
  const WordRepositoryImpl(this.wordDataSource);

  @override
  Future<Either<Failure, List<Word>>> getWordsByRandomWord({required String guessWord}) async {
    try {
      final failureOrWords = await wordDataSource.getWordsByRandomWord(guessWord: guessWord);
      return Right(failureOrWords);
    } on DioException catch (err) {
      final errorResponseData = err.response?.data;

      // check case error "Guess must be the same length as the word"
      if (errorResponseData == null) return Left(UnknownFailure());
      if (errorResponseData is String) {
        return Left(ServerFailure(message: errorResponseData));
      }

      // check case error code 422
      // {
      //     "detail": [
      //         {
      //             "loc": [
      //                 "query",
      //                 "guess"
      //             ],
      //             "msg": "field required",
      //             "type": "value_error.missing"
      //         }
      //     ]
      // }
      final errorResponseDataDetail = errorResponseData["detail"];
      if (errorResponseDataDetail is List) {
        try {
          final errorDetailList = errorResponseDataDetail.map((json) => ResponseError.fromJson(json)).toList();
          final error = errorDetailList.map((error) => error.msg).join("\n");
          return Left(ServerFailure(message: error));
        } catch (_) {
          return Left(UnknownFailure());
        }
      }
      return Left(UnknownFailure());
    }
  }
}
