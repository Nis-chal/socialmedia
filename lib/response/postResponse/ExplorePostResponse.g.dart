// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExplorePostResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExplorePostResponse _$ExplorePostResponseFromJson(Map<String, dynamic> json) {
  return ExplorePostResponse(
    posts: (json['posts'] as List<dynamic>?)
        ?.map((e) => Posts.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ExplorePostResponseToJson(
        ExplorePostResponse instance) =>
    <String, dynamic>{
      'posts': instance.posts,
    };
