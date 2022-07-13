import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../response/FeedsResponse.dart';
import '../utils/url.dart';
import '../api/httpServices.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/models/Posts.dart';
import 'package:mime/mime.dart';




class PostAPI{

  Future<FeedsResponse?>feeds() async{
      Future.delayed(const Duration(seconds: 2), () {});

      FeedsResponse? feedsResponse;



    var postsurl = baseUrl + getFeedsUrl;

    try{
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await dio.get(
        postsurl,
        options:Options(headers: {HttpHeaders.authorizationHeader:"Bearer $token"}),

      
      );
      if (response.statusCode == 200) {
          feedsResponse = FeedsResponse.fromJson(response.data);
        } else {
          feedsResponse= null;
        }


    }catch(e){
      throw Exception(e);

    }

    return feedsResponse;



  }


  Future<bool>addPost(List<File> images,String description) async{
    

    bool posts;



    var postsurl = baseUrl + addPostUrl;
    List<MultipartFile> uploadList = [];
    FormData formData;


    try{
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      for (var file in images){
          var mimeType = lookupMimeType(file.path);

        MultipartFile multipartFile = await MultipartFile.fromFile(file.path,
        filename: file.path.split("/").last,
          contentType: MediaType("image", mimeType!.split("/")[1]),
        );
        

        uploadList.add(multipartFile);
      }
      FormData formData = FormData.fromMap({
        "images":uploadList
      });
      var response = await dio.post(
        postsurl,
        data:formData,
        options:Options(headers: {HttpHeaders.authorizationHeader:"Bearer $token"}),

      
      );
      if (response.statusCode == 200) {
          posts = true;
        } else {
          posts= false;
        }


    }catch(e){
      throw Exception(e);

    }

    

    return posts;



  }


  Future<bool>likePost({postid}) async{
    

    bool posts;



    var postsurl = baseUrl + '$likeUrl$postid';
   


    try{
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

    
      Response response = await dio.patch(
        postsurl,
       
        options:Options(headers: {HttpHeaders.authorizationHeader:"Bearer $token"}),

      
      );
      if (response.statusCode == 200) {
          posts = true;
        } else {
          posts= false;
        }


    }catch(e){
      throw Exception(e);

    }

    

    return posts;



  }


  Future<bool>unlikePost({postid}) async{
    

    bool posts;



    var postsurl = baseUrl + '$unlikeUrl$postid';
   


    try{
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

    
      Response response = await dio.patch(
        postsurl,
       
        options:Options(headers: {HttpHeaders.authorizationHeader:"Bearer $token"}),

      
      );
      if (response.statusCode == 200) {
          posts = true;
        } else {
          posts= false;
        }


    }catch(e){
      throw Exception(e);

    }

    

    return posts;



  }
}