// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseError _$ResponseErrorFromJson(Map<String, dynamic> json) =>
    ResponseError(
      loc: (json['loc'] as List<dynamic>).map((e) => e as String).toList(),
      msg: json['msg'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$ResponseErrorToJson(ResponseError instance) =>
    <String, dynamic>{
      'loc': instance.loc,
      'msg': instance.msg,
      'type': instance.type,
    };
