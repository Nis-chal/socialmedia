import 'package:socialmedia/models/User.dart';

import '../models/Posts.dart';
import 'package:json_annotation/json_annotation.dart';
part 'CommentsModel.g.dart';

@JsonSerializable()
class CommentsModel {
  @JsonKey(name: '_id')
  String? id;
  String? content;
  List<String>? likes;
  User? commentedBy;
  String? postid;

  DateTime? createdAt;

  CommentsModel({
    this.id,
    this.content,
    this.likes,
    this.commentedBy,
    this.createdAt,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) {
    return _$CommentsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CommentsModelToJson(this);
}
