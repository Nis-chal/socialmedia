// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProfileResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      post: (json['post'] as List<dynamic>?)
          ?.map((e) => Posts.fromJson(e as Map<String, dynamic>))
          .toList(),
      followings: (json['followings'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      followers: (json['followers'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'post': instance.post,
      'followings': instance.followings,
      'followers': instance.followers,
    };
