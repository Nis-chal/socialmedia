// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProfileUpdateResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileUpdateResponse _$ProfileUpdateResponseFromJson(
    Map<String, dynamic> json) {
  return ProfileUpdateResponse(
    users: json['users'] == null
        ? null
        : User.fromJson(json['users'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProfileUpdateResponseToJson(
        ProfileUpdateResponse instance) =>
    <String, dynamic>{
      'users': instance.users,
    };
