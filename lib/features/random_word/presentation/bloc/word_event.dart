abstract class WordEvent {}

class GetWordByRandomWordEvent extends WordEvent {
  final String guessWord;
  GetWordByRandomWordEvent(this.guessWord);
}
