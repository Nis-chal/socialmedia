// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShortsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortsResponse _$ShortsResponseFromJson(Map<String, dynamic> json) {
  return ShortsResponse(
    video: json['video'] as String,
    description: json['description'] as String?,
    location: json['location'] as String?,
    likesid: (json['likesid'] as List<dynamic>?)
        ?.map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
    dislikesid: (json['dislikesid'] as List<dynamic>?)
        ?.map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
    saved: (json['saved'] as List<dynamic>?)
        ?.map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
    userid: json['userid'] == null
        ? null
        : User.fromJson(json['userid'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ShortsResponseToJson(ShortsResponse instance) =>
    <String, dynamic>{
      'video': instance.video,
      'description': instance.description,
      'location': instance.location,
      'likesid': instance.likesid,
      'dislikesid': instance.dislikesid,
      'saved': instance.saved,
      'userid': instance.userid,
    };
