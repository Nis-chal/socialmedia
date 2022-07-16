import 'dart:io';
import 'package:dio/dio.dart';
import 'package:socialmedia/response/PostDetailResponse.dart';

import '../api/postapi.dart';
import '../response/FeedsResponse.dart';
import 'package:socialmedia/models/Posts.dart';


class PostRepository{
  Future<FeedsResponse?> getFeeds() async {
    return PostAPI().feeds();
  }

   Future<bool>addFeed(List<File> images ,String description,String location)async{
    return await PostAPI().addPost(images ,description,location);
  }

  Future<bool>likePost(String? postid)async{
    return await PostAPI().likePost(postid: postid);
  }

   Future<bool>unlikePost(String? postid)async{
    return await PostAPI().unlikePost(postid: postid);
  }

  Future<PostDetailResponse?>postDetail(String postid)async{
    return await PostAPI().postDetail(postid);
  }

     Future<bool>updatePost(String? location ,String? description,String? id,List<String>? networkpath)async{
    return await PostAPI().updatePost(location:location, description:description,id: id,networkpath: networkpath);
  }


  Future<bool>deletePost(String? postid)async{
    return await PostAPI().deletePost(postid: postid);
  }

  Future<bool>savePost(String? postid)async{
    return await PostAPI().savePost(postid: postid);
  }

  Future<bool>unsavePost(String? postid)async{
    return await PostAPI().unsavePost(postid: postid);
  }




  

  
}