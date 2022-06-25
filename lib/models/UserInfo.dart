import 'package:json_annotation/json_annotation.dart';
part 'UserInfo.g.dart';

@JsonSerializable()

class UserInfo{
  @JsonKey(name: '_id')
  String? id;

  String? username;
  String? profilePicture;
  String? location;

  UserInfo({this.id, this.username, this.profilePicture, this.location});

  factory UserInfo.fromJson(Map<String,dynamic>json){
    return _$UserInfoFromJson(json);
  }

  Map<String,dynamic>toJson()=> _$UserInfoToJson(this);
}
