// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShortsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortsResponse _$ShortsResponseFromJson(Map<String, dynamic> json) {
  return ShortsResponse(
    shorts: (json['shorts'] as List<dynamic>)
        .map((e) =>
            e == null ? null : ShortsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ShortsResponseToJson(ShortsResponse instance) =>
    <String, dynamic>{
      'shorts': instance.shorts,
    };
