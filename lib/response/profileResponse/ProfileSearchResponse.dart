import 'package:json_annotation/json_annotation.dart';

import 'package:socialmedia/models/User.dart';

part 'ProfileSearchResponse.g.dart';

@JsonSerializable()
class ProfileSearchResponse {
  List<User>? users;

  ProfileSearchResponse({required this.users});

  factory ProfileSearchResponse.fromJson(Map<String, dynamic> json) {
    return _$ProfileSearchResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfileSearchResponseToJson(this);
}
