import 'package:get_it/get_it.dart';
import 'package:wordle/common/constants/constants.dart';
import 'package:wordle/common/network/dio_manager/dio_manager.dart';
import 'package:wordle/common/network/rest_api.dart';
import 'package:wordle/features/random_word/data/datasources/word_data_source.dart';
import 'package:wordle/features/random_word/data/datasources/word_data_source_impl.dart';
import 'package:wordle/features/random_word/data/repositories/word_repository_impl.dart';
import 'package:wordle/features/random_word/domain/repositories/word_repository.dart';
import 'package:wordle/features/random_word/domain/usecases/get_word_by_random_word_use_case.dart';
import 'package:wordle/features/random_word/presentation/bloc/bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // bloc
  sl.registerFactory(() => WordBloc(sl()));

  // usecases
  sl.registerLazySingleton(() => GetWordByRandomWordUseCase(sl()));

  // repository
  sl.registerLazySingleton<WordRepository>(() => WordRepositoryImpl(sl()));

  // data source
  sl.registerLazySingleton<WordDataSource>(() => WordDataSourceImpl(sl()));

  // external
  sl.registerLazySingleton(() => RestAPI(DioManager().dio, baseUrl: Constants.baseUrl));
}
