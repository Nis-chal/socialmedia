// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExplorePostResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExplorePostResponse _$ExplorePostResponseFromJson(Map<String, dynamic> json) =>
    ExplorePostResponse(
      post: (json['post'] as List<dynamic>?)
          ?.map((e) => Posts.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExplorePostResponseToJson(
        ExplorePostResponse instance) =>
    <String, dynamic>{
      'post': instance.post,
    };
