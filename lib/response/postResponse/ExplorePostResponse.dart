
import 'package:json_annotation/json_annotation.dart';
import 'package:socialmedia/models/Posts.dart';

part 'ExplorePostResponse.g.dart';


@JsonSerializable()
class ExplorePostResponse{
  
  List <Posts>? post;
  

  ExplorePostResponse({this.post});

   factory ExplorePostResponse.fromJson(Map<String,dynamic>json){
    return _$ExplorePostResponseFromJson(json);
  }

  Map<String,dynamic>toJson()=> _$ExplorePostResponseToJson(this);
}