// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProfileSearchResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileSearchResponse _$ProfileSearchResponseFromJson(
        Map<String, dynamic> json) =>
    ProfileSearchResponse(
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileSearchResponseToJson(
        ProfileSearchResponse instance) =>
    <String, dynamic>{
      'users': instance.users,
    };
