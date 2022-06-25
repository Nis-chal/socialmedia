

import '../models/Posts.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FeedsResponse.g.dart';


@JsonSerializable()

class FeedsResponse{

  List<Posts>? posts;

  FeedsResponse({this.posts});

  factory FeedsResponse.fromJson(Map<String,dynamic>json){
    return _$FeedsResponseFromJson(json);
  }

  Map<String,dynamic>toJson()=> _$FeedsResponseToJson(this);


}