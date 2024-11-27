// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordModel _$WordModelFromJson(Map<String, dynamic> json) => WordModel(
      result: json['result'] as String,
      guess: json['guess'] as String,
      slot: (json['slot'] as num).toInt(),
    );

Map<String, dynamic> _$WordModelToJson(WordModel instance) => <String, dynamic>{
      'result': instance.result,
      'guess': instance.guess,
      'slot': instance.slot,
    };
