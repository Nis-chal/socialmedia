// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PostDetailResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDetailResponse _$PostDetailResponseFromJson(Map<String, dynamic> json) =>
    PostDetailResponse(
      post: json['post'] == null
          ? null
          : Posts.fromJson(json['post'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostDetailResponseToJson(PostDetailResponse instance) =>
    <String, dynamic>{
      'post': instance.post,
    };
