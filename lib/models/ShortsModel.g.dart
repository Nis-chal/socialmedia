// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShortsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortsModel _$ShortsModelFromJson(Map<String, dynamic> json) {
  return ShortsModel(
    video: json['video'] as String,
    description: json['description'] as String?,
    location: json['location'] as String?,
    likesid:
        (json['likesid'] as List<dynamic>?)?.map((e) => e as String).toList(),
    dislikesid: (json['dislikesid'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    saved: (json['saved'] as List<dynamic>?)?.map((e) => e as String).toList(),
    userid: json['userid'] == null
        ? null
        : User.fromJson(json['userid'] as Map<String, dynamic>),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
  );
}

Map<String, dynamic> _$ShortsModelToJson(ShortsModel instance) =>
    <String, dynamic>{
      'video': instance.video,
      'description': instance.description,
      'location': instance.location,
      'likesid': instance.likesid,
      'dislikesid': instance.dislikesid,
      'saved': instance.saved,
      'userid': instance.userid,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
