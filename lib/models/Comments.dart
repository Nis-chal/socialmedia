import 'package:socialmedia/models/User.dart';

import '../models/Posts.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Comments.g.dart';

@JsonSerializable()
class Comments {
  @JsonKey(name: '_id')
  String? id;
  String? content;
  List<String>? likes;
  User? commentedby;
  Posts? postid;

  DateTime? createdAt;

  Comments({
    this.id,
    this.content,
    this.likes,
    this.commentedby,
    this.createdAt,
  });

  factory Comments.fromJson(Map<String, dynamic> json) {
    return _$CommentsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CommentsToJson(this);
}
