// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddFeedResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddFeedResponse _$AddFeedResponseFromJson(Map<String, dynamic> json) {
  return AddFeedResponse(
    images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    description: json['description'] as String?,
    location: json['location'] as String?,
  );
}

Map<String, dynamic> _$AddFeedResponseToJson(AddFeedResponse instance) =>
    <String, dynamic>{
      'images': instance.images,
      'description': instance.description,
      'location': instance.location,
    };
