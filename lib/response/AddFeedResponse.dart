import 'dart:io';
import 'package:json_annotation/json_annotation.dart';

part 'AddFeedResponse.g.dart';


@JsonSerializable()
class AddFeedResponse{

  List<File> images;
  String? description;
  String? location;

  AddFeedResponse({required this.images,this.description,this.location});

  factory AddFeedResponse.fromJson(Map<String,dynamic>json){
    return _$AddFeedResponseFromJson(json);
  }

  Map<String,dynamic>toJson()=> _$AddFeedResponseToJson(this);


}