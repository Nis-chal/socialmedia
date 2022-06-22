import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
part 'User.g.dart';

@JsonSerializable()
class User{
  @JsonKey(name: '_id')
  String? id;
  
  String? name;
  String? email;
  String?location; 
  String?username;
  String? password;
  String? coverPage;
  String? profilePicture;
  List<String>? followers;
  List<String>? following;


  User({this.name,this.username,this.email,this.location,this.profilePicture,this.password, this.following,this.followers});

  factory User.fromJson(Map<String,dynamic>json){
    return _$UserFromJson(json);
  }

  Map<String,dynamic>toJson()=> _$UserToJson(this);
}