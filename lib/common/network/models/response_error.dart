import 'package:json_annotation/json_annotation.dart';

part 'response_error.g.dart';

@JsonSerializable()
class ResponseError {
  final List<String> loc;
  final String msg;
  final String type;

  const ResponseError({
    required this.loc,
    required this.msg,
    required this.type,
  });

  factory ResponseError.fromJson(Map<String, dynamic> json) => _$ResponseErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseErrorToJson(this);
}
