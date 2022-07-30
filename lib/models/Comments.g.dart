// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comments _$CommentsFromJson(Map<String, dynamic> json) {
  return Comments(
    id: json['_id'] as String?,
    content: json['content'] as String?,
    likes: (json['likes'] as List<dynamic>?)?.map((e) => e as String).toList(),
    commentedby: json['commentedby'] == null
        ? null
        : User.fromJson(json['commentedby'] as Map<String, dynamic>),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
  )..postid = json['postid'] == null
      ? null
      : Posts.fromJson(json['postid'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CommentsToJson(Comments instance) => <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'likes': instance.likes,
      'commentedby': instance.commentedby,
      'postid': instance.postid,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
