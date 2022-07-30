import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/api/httpServices.dart';
import 'package:socialmedia/response/commentResponse/CommentResponse.dart';
import 'package:socialmedia/utils/url.dart';

class CommentAPI {
  Future<CommentResponse?> getComments({commentid}) async {
    Future.delayed(const Duration(seconds: 2), () {});

    CommentResponse? commentResponse;

    var commentsurl = baseUrl + 'comment/get/$commentid';

    try {
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      // dio.interceptors
      //     .add(DioCacheManager(CacheConfig(baseUrl: ipaddress)).interceptor);

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await dio.get(
        commentsurl,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        commentResponse = CommentResponse.fromJson(response.data);
      } else {}
    } catch (SocketException) {
      print('No Internet');
    }

    // var mymap = box.toMap().values.toList();
    // if(mymap.isEmpty){
    //   CommentResponse = null;

    // }else{

    // }

    return commentResponse;
  }

  Future<bool> updateComments(String commentid, String content) async {
    bool commentResponse = false;

    var commentsurl = baseUrl + 'comment/update/$commentid';

    try {
      var dio = HttpServices().getDiorInstance();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      FormData formData = FormData.fromMap({
        "content": content,
      });

      var response = await dio.patch(
        commentsurl,
        data: formData,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        commentResponse = true;
      } else {}
    } catch (e) {
      print('No Internet');
    }

    return commentResponse;
  }

  Future<bool> deleteComments(String commentid) async {
    bool commentResponse = false;

    var commentsurl = baseUrl + 'comment/delete/$commentid';

    try {
      var dio = HttpServices().getDiorInstance();

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      var response = await dio.delete(
        commentsurl,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        commentResponse = true;
      } else {}
    } catch (e) {
      print('No Internet');
    }

    return commentResponse;
  }
}
