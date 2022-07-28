import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'package:socialmedia/models/User.dart';
part 'ShortsResponse.g.dart';


@JsonSerializable()
class ShortsResponse{

  String video;
  String? description;
  String? location;
  List<User>? likesid;
  List<User>? dislikesid;
  List<User>? saved;
  User? userid;

  ShortsResponse({required this.video,this.description,this.location,this.likesid,this.dislikesid,this.saved,this.userid});

  factory ShortsResponse.fromJson(Map<String,dynamic>json){
    return _$ShortsResponseFromJson(json);
  }

  Map<String,dynamic>toJson()=> _$ShortsResponseToJson(this);

}