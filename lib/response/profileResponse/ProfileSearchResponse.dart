import 'package:json_annotation/json_annotation.dart';

import 'package:socialmedia/models/User.dart';

part 'ProfileSearchResponse.g.dart';

@JsonSerializable()
class ProfileSearchResponse {
  User user;

  ProfileSearchResponse({required this.user});

  factory ProfileSearchResponse.fromJson(Map<String, dynamic> json) {
    return _$ProfileSearchResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfileSearchResponseToJson(this);
}
