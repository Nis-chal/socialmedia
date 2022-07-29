import 'package:json_annotation/json_annotation.dart';
import 'package:socialmedia/models/ShortsModel.dart';
part 'ShortsResponse.g.dart';

@JsonSerializable()
class ShortsResponse {
  List<ShortsModel?> shorts;

  ShortsResponse({required this.shorts});

  factory ShortsResponse.fromJson(Map<String, dynamic> json) {
    return _$ShortsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ShortsResponseToJson(this);
}
