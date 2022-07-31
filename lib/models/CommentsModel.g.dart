// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CommentsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentsModel _$CommentsModelFromJson(Map<String, dynamic> json) {
  return CommentsModel(
    id: json['_id'] as String?,
    content: json['content'] as String?,
    likes: (json['likes'] as List<dynamic>?)?.map((e) => e as String).toList(),
    commentedBy: json['commentedBy'] == null
        ? null
        : User.fromJson(json['commentedBy'] as Map<String, dynamic>),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
  )..postid = json['postid'] as String?;
}

Map<String, dynamic> _$CommentsModelToJson(CommentsModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'likes': instance.likes,
      'commentedBy': instance.commentedBy,
      'postid': instance.postid,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
