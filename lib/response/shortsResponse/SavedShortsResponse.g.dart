// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SavedShortsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedShortsResponse _$SavedShortsResponseFromJson(Map<String, dynamic> json) {
  return SavedShortsResponse(
    posts: (json['posts'] as List<dynamic>?)
        ?.map((e) => ShortsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SavedShortsResponseToJson(
        SavedShortsResponse instance) =>
    <String, dynamic>{
      'posts': instance.posts,
    };
