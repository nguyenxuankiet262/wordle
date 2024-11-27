import 'package:json_annotation/json_annotation.dart';
import 'package:wordle/features/random_word/domain/entities/word.dart';

part 'word_model.g.dart';

@JsonSerializable()
class WordModel extends Word {
  final String guess;
  final int slot;

  const WordModel({required super.result, required this.guess, required this.slot});

  factory WordModel.fromJson(Map<String, dynamic> json) => _$WordModelFromJson(json);

  Map<String, dynamic> toJson() => _$WordModelToJson(this);
}
