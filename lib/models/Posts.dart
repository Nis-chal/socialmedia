
import 'UserInfo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Posts.g.dart';

@JsonSerializable()

class Posts {
  @JsonKey(name: '_id')
  String? id;
  List<String>? images;
  String? location;
  String? description;
  List<String>? likesid;
  List<String>? commentsid;
  UserInfo? userid;
  List<String>? saved;
  String? createdAt;
  String? updatedAt;

  Posts(
    {
      this.id,
      this.images,
      this.location,
      this.description,
      this.likesid,
      this.commentsid,
      this.userid,
      this.saved,
      this.createdAt,
      this.updatedAt,
    }
  );

  factory Posts.fromJson(Map<String,dynamic>json){
    return _$PostsFromJson(json);
  }

  Map<String,dynamic>toJson()=> _$PostsToJson(this);
}