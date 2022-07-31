import 'package:json_annotation/json_annotation.dart';
import '../../models/CommentsModel.dart';

part 'CommentResponse.g.dart';

@JsonSerializable()
class CommentResponse {
  List<CommentsModel>? comment;

  CommentResponse({this.comment});

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    return _$CommentResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CommentResponseToJson(this);
}
