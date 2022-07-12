import 'dart:convert';

import 'package:get/get.dart';
import 'package:socialmedia/models/Posts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/models/User.dart';




class PostController extends GetxController{

  var postCard =Posts();

  void increament() async{
var prefs = await SharedPreferences.getInstance();
var data = prefs.getString('userdata');
var userdata = jsonDecode(data.toString());

//  postCard.likesid = [{...Posts.postCard.likesid,userdata.id}];
    // postCard.likesid =
  }


}