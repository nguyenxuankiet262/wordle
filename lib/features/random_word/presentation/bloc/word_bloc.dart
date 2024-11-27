import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/common/error/failure.dart';
import 'package:wordle/features/random_word/domain/usecases/get_word_by_random_word_use_case.dart';
import 'package:wordle/features/random_word/presentation/bloc/word_event.dart';
import 'package:wordle/features/random_word/presentation/bloc/word_state.dart';

const String ERROR_FROM_SERVER = 'Error from server';
const String UNKNOWN_ERROR = 'Unknown error';

class WordBloc extends Bloc<WordEvent, WordState> {
  final GetWordByRandomWordUseCase getWordByRandomWordUseCase;

  WordBloc(this.getWordByRandomWordUseCase) : super(Empty()) {
    on<GetWordByRandomWordEvent>(_onGetWordByRandomWordEvent);
  }

  Future<void> _onGetWordByRandomWordEvent(GetWordByRandomWordEvent event, Emitter<WordState> emit) async {
    emit(Loading());
    final failureOrWords = await getWordByRandomWordUseCase(Params(event.guessWord));
    failureOrWords.fold((failure) => emit(Error(_mapFailureToMessage(failure))), (words) => emit(Loaded(words)));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure) {
      case ServerFailure _:
        return failure.message ?? ERROR_FROM_SERVER;
      case UnknownFailure _:
        return UNKNOWN_ERROR;
      default:
        return UNKNOWN_ERROR;
    }
  }
}
