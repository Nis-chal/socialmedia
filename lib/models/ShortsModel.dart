import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'package:socialmedia/models/User.dart';
part 'ShortsModel.g.dart';

@JsonSerializable()
class ShortsModel {
  @JsonKey(name: '_id')
  String? id;
  String video;
  String? description;
  String? location;
  List<String>? likesid;
  List<String>? dislikesid;
  List<String>? saved;
  User? userid;
  DateTime? createdAt;

  ShortsModel(
      {this.id,
        required this.video,
      this.description,
      this.location,
      this.likesid,
      this.dislikesid,
      this.saved,
      this.userid,
      this.createdAt});

  factory ShortsModel.fromJson(Map<String, dynamic> json) {
    return _$ShortsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ShortsModelToJson(this);
}
