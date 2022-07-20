import 'package:json_annotation/json_annotation.dart';

import 'package:socialmedia/models/User.dart';

part 'ProfileUpdateResponse.g.dart';

@JsonSerializable()
class ProfileUpdateResponse {
  User? users;

  ProfileUpdateResponse({required this.users});

  factory ProfileUpdateResponse.fromJson(Map<String, dynamic> json) {
    return _$ProfileUpdateResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfileUpdateResponseToJson(this);
}
