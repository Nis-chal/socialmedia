// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProfileSearchResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileSearchResponse _$ProfileSearchResponseFromJson(
        Map<String, dynamic> json) =>
    ProfileSearchResponse(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileSearchResponseToJson(
        ProfileSearchResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
    };
