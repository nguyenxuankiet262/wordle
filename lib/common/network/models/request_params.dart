import 'package:json_annotation/json_annotation.dart';

part 'request_params.g.dart';

@JsonSerializable()
class RequestParams {
  final String guess;
  @JsonKey(includeIfNull: false)
  final int? size;
  @JsonKey(includeIfNull: false)
  final int? seed;

  const RequestParams({required this.guess, this.size, this.seed});

  Map<String, dynamic> toJson() => _$RequestParamsToJson(this);
}
