// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FeedsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedsResponse _$FeedsResponseFromJson(Map<String, dynamic> json) {
  return FeedsResponse(
    posts: (json['posts'] as List<dynamic>?)
        ?.map((e) => Posts.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FeedsResponseToJson(FeedsResponse instance) =>
    <String, dynamic>{
      'posts': instance.posts,
    };
