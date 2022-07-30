// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CommentResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentResponse _$CommentResponseFromJson(Map<String, dynamic> json) {
  return CommentResponse(
    comment: (json['comment'] as List<dynamic>?)
        ?.map((e) => CommentsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CommentResponseToJson(CommentResponse instance) =>
    <String, dynamic>{
      'comment': instance.comment,
    };
