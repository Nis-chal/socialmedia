import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:socialmedia/response/PostDetailResponse.dart';
import 'package:socialmedia/response/postResponse/ExplorePostResponse.dart';

import '../response/FeedsResponse.dart';
import '../utils/url.dart';
import '../api/httpServices.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mime/mime.dart';

class PostAPI {
  Future<FeedsResponse?> feeds() async {
    Future.delayed(const Duration(seconds: 2), () {});

    FeedsResponse? feedsResponse;

    var postsurl = baseUrl + getFeedsUrl;

    try {
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      dio.interceptors
          .add(DioCacheManager(CacheConfig(baseUrl: ipaddress)).interceptor);
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await dio.get(
        postsurl,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        feedsResponse = FeedsResponse.fromJson(response.data);
      } else {
        feedsResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }

    return feedsResponse;
  }

  Future<bool> addPost(
      List<File> images, String description, String location) async {
    bool posts;

    var postsurl = baseUrl + addPostUrl;
    List<MultipartFile> uploadList = [];
    FormData formData;

    try {
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      for (var file in images) {
        var mimeType = lookupMimeType(file.path);

        MultipartFile multipartFile = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split("/").last,
          contentType: MediaType("image", mimeType!.split("/")[1]),
        );

        uploadList.add(multipartFile);
      }
      FormData formData = FormData.fromMap({
        "images": uploadList,
        "location": location,
        "description": description
      });
      var response = await dio.post(
        postsurl,
        data: formData,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 201) {
        posts = true;
      } else {
        posts = false;
      }
    } catch (e) {
      throw Exception(e);
    }

    return posts;
  }

  Future<bool> likePost({postid}) async {
    bool posts;

    var postsurl = baseUrl + '$likeUrl$postid';

    try {
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      Response response = await dio.patch(
        postsurl,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        posts = true;
      } else {
        posts = false;
      }
    } catch (e) {
      throw Exception(e);
    }

    return posts;
  }

  Future<bool> unlikePost({postid}) async {
    bool posts;

    var postsurl = baseUrl + '$unlikeUrl$postid';

    try {
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      Response response = await dio.patch(
        postsurl,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        posts = true;
      } else {
        posts = false;
      }
    } catch (e) {
      throw Exception(e);
    }

    return posts;
  }

  Future<PostDetailResponse?> postDetail(String postid) async {
    // Future.delayed(const Duration(seconds: 2), () {});

    PostDetailResponse? posts;

    var postsurl = baseUrl + postDetailUrl + postid;

    try {
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      Response response = await dio.get(
        postsurl,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        posts = PostDetailResponse.fromJson(response.data);
      } else {
        posts = null;
      }
    } catch (e) {
      throw Exception(e);
    }

    return posts;
  }

  Future<bool> updatePost(
      {String? description,
      String? location,
      String? id,
      List<String>? networkpath}) async {
    bool posts;

    var postsurl = baseUrl + updatePostUrl + id!;

    try {
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      FormData formData = FormData.fromMap({
        "location": location,
        "description": description,
        "networkpath": networkpath
      });
      var response = await dio.patch(
        postsurl,
        data: formData,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        posts = true;
      } else {
        posts = false;
      }
    } catch (e) {
      throw Exception(e);
    }

    return posts;
  }

  Future<bool> deletePost({postid}) async {
    bool posts;

    var postsurl = baseUrl + '$postDetailUrl$postid';

    try {
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      Response response = await dio.delete(
        postsurl,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        posts = true;
      } else {
        posts = false;
      }
    } catch (e) {
      throw Exception(e);
    }

    return posts;
  }

  Future<bool> savePost({postid}) async {
    bool posts;

    var postsurl = baseUrl + '$savePostUrl$postid';

    try {
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      Response response = await dio.patch(
        postsurl,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        posts = true;
      } else {
        posts = false;
      }
    } catch (e) {
      throw Exception(e);
    }

    return posts;
  }

  Future<bool> unsavePost({postid}) async {
    bool posts;

    var postsurl = baseUrl + '$unsavePostUrl$postid';

    try {
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      Response response = await dio.patch(
        postsurl,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        posts = true;
      } else {
        posts = false;
      }
    } catch (e) {
      throw Exception(e);
    }

    return posts;
  }

  Future<ExplorePostResponse?> exploreFeeds() async {
    Future.delayed(const Duration(seconds: 2), () {});

    ExplorePostResponse? explorePostResponse;

    var postsurl = baseUrl + exploreFeedsUrl;

    try {
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await dio.get(
        postsurl,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        explorePostResponse = ExplorePostResponse.fromJson(response.data);
      } else {
        explorePostResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }

    return explorePostResponse;
  }
}
