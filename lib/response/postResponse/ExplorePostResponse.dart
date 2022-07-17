
import 'package:json_annotation/json_annotation.dart';
import 'package:socialmedia/models/Posts.dart';

part 'ExplorePostResponse.g.dart';


@JsonSerializable()
class ExplorePostResponse{
  
  List<Posts>? posts;
  

  ExplorePostResponse({this.posts});

   factory ExplorePostResponse.fromJson(Map<String,dynamic>json){
    return _$ExplorePostResponseFromJson(json);
  }

  Map<String,dynamic>toJson()=> _$ExplorePostResponseToJson(this);
}