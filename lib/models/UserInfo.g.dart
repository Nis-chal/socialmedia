// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
    id: json['_id'] as String?,
    username: json['username'] as String?,
    profilePicture: json['profilePicture'] as String?,
    location: json['location'] as String?,
  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'profilePicture': instance.profilePicture,
      'location': instance.location,
    };
