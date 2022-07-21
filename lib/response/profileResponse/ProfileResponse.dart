
import 'package:json_annotation/json_annotation.dart';
import 'package:socialmedia/models/Posts.dart';
import 'package:socialmedia/models/User.dart';

part 'ProfileResponse.g.dart';


@JsonSerializable()

class ProfileResponse{
  User user;
  List <Posts>? post;
  List<User>? followings;
  List<User>? followers;

  ProfileResponse({required this.user,this.post,this.followings,this.followers});

   factory ProfileResponse.fromJson(Map<String,dynamic>json){
    return _$ProfileResponseFromJson(json);
  }

  get id => null;

  Map<String,dynamic>toJson()=> _$ProfileResponseToJson(this);
}