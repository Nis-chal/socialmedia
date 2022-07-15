


import 'package:json_annotation/json_annotation.dart';
import 'package:socialmedia/models/Posts.dart';
part 'PostDetailResponse.g.dart';


@JsonSerializable()

class PostDetailResponse {

  Posts? post;


  PostDetailResponse({ this.post});


  factory PostDetailResponse.fromJson(Map<String,dynamic>json){
    return _$PostDetailResponseFromJson(json);
  }

  Map<String,dynamic>toJson()=> _$PostDetailResponseToJson(this);


  
}