// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Posts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Posts _$PostsFromJson(Map<String, dynamic> json) {
  return Posts(
    id: json['_id'] as String?,
    images:
        (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    location: json['location'] as String?,
    description: json['description'] as String?,
    likesid:
        (json['likesid'] as List<dynamic>?)?.map((e) => e as String).toList(),
    commentsid: (json['commentsid'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    userid: json['userid'] == null
        ? null
        : UserInfo.fromJson(json['userid'] as Map<String, dynamic>),
    saved: (json['saved'] as List<dynamic>?)?.map((e) => e as String).toList(),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] as String?,
  );
}

Map<String, dynamic> _$PostsToJson(Posts instance) => <String, dynamic>{
      '_id': instance.id,
      'images': instance.images,
      'location': instance.location,
      'description': instance.description,
      'likesid': instance.likesid,
      'commentsid': instance.commentsid,
      'userid': instance.userid,
      'saved': instance.saved,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt,
    };
