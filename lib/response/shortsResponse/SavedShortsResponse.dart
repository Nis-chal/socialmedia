import 'package:socialmedia/models/ShortsModel.dart';

import 'package:json_annotation/json_annotation.dart';

part 'SavedShortsResponse.g.dart';

@JsonSerializable()
class SavedShortsResponse {
  List<ShortsModel>? posts;

  SavedShortsResponse({this.posts});

  factory SavedShortsResponse.fromJson(Map<String, dynamic> json) {
    return _$SavedShortsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SavedShortsResponseToJson(this);
}
