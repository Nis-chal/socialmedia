import 'dart:io';
import 'package:dio/dio.dart';

import '../api/postapi.dart';
import '../response/FeedsResponse.dart';
import 'package:socialmedia/models/Posts.dart';


class PostRepository{
  Future<FeedsResponse?> getFeeds() async {
    return PostAPI().feeds();
  }

   Future<bool>addFeed(List<File> images ,String description)async{
    return await PostAPI().addPost(images ,description);
  }

  Future<bool>likePost(String? postid)async{
    return await PostAPI().likePost(postid: postid);
  }




  

  
}