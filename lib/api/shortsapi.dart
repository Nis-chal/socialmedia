import 'package:socialmedia/response/shortsResponse/ShortsResponse.dart';
import 'dart:io';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

import '../utils/url.dart';
import '../api/httpServices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

import 'package:mime/mime.dart';

class SHORTSAPI {
  Future<ShortsResponse?> getshorts() async {
    Future.delayed(const Duration(seconds: 2), () {});

    ShortsResponse? shortsResponse;

    try {
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      // dio.interceptors
      //     .add(DioCacheManager(CacheConfig(baseUrl: ipaddress)).interceptor);

      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var response = await dio.get(
        getshortUrl,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        shortsResponse = ShortsResponse.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }

    // var mymap = box.toMap().values.toList();
    // if(mymap.isEmpty){
    //  ShortsResponse = null;

    // }else{

    // }

    return shortsResponse;
  }

  Future<bool> likeShort({shortid}) async {
    bool shorts;

    var shortsurl = baseUrl + '$likeshortUrl$shortid';

    try {
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      Response response = await dio.patch(
        shortsurl,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        shorts = true;
      } else {
        shorts = false;
      }
    } catch (e) {
      throw Exception(e);
    }

    return shorts;
  }

  Future<bool> unlikeShort({shortid}) async {
    bool shorts;

    var shortsurl = baseUrl + '$likeshortUrl$shortid/unlike';

    try {
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      Response response = await dio.patch(
        shortsurl,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        shorts = true;
      } else {
        shorts = false;
      }
    } catch (e) {
      throw Exception(e);
    }

    return shorts;
  }

  Future<bool> dislikeShort({shortid}) async {
    bool shorts;

    var shortsurl = baseUrl + '$likeshortUrl$shortid/dislike';

    try {
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      Response response = await dio.patch(
        shortsurl,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        shorts = true;
      } else {
        shorts = false;
      }
    } catch (e) {
      throw Exception(e);
    }

    return shorts;
  }

  Future<bool> undislikeShort({shortid}) async {
    bool shorts;

    var shortsurl = baseUrl + '$likeshortUrl$shortid/undislike';

    try {
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      Response response = await dio.patch(
        shortsurl,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        shorts = true;
      } else {
        shorts = false;
      }
    } catch (e) {
      throw Exception(e);
    }

    return shorts;
  }

  Future<bool> saveShort({shortid}) async {
    bool shorts;

    var shortsurl = baseUrl + '$likeshortUrl$shortid/saveshort';

    try {
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      Response response = await dio.patch(
        shortsurl,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        shorts = true;
      } else {
        shorts = false;
      }
    } catch (e) {
      throw Exception(e);
    }

    return shorts;
  }

  Future<bool> unsaveShort({shortid}) async {
    bool shorts;

    var shortsurl = baseUrl + '$likeshortUrl$shortid/unsaveshort';

    try {
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      Response response = await dio.patch(
        shortsurl,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        shorts = true;
      } else {
        shorts = false;
      }
    } catch (e) {
      throw Exception(e);
    }

    return shorts;
  }

  Future<bool> addShort(
      {required File video,
      required String description,
      String? location}) async {
    bool shorts = false;

    FormData formData;

    try {
      var url = baseUrl + "shorts/upload";
      var dio = HttpServices().getDiorInstance();
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      var mimeType = lookupMimeType(video.path);
      MultipartFile multipartFile = await MultipartFile.fromFile(
        video.path,
        filename: video.path.split("/").last,
        contentType: MediaType("video", mimeType!.split("/")[1]),
      );

      formData = FormData.fromMap({
        "video": multipartFile,
        "description": description,
        "location": location,
      });

      Response response = await dio.post(
        url,
        data: formData,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );

      if (response.statusCode == 201) {
        shorts = true;
      }
    } catch (e) {
      // debugPrint(e.toString());
    }
    return shorts;
  }

  Future<bool> deleteShort({shortid}) async {
    bool shorts;

    var shortsurl = baseUrl + 'shorts/$shortid';

    try {
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      Response response = await dio.delete(
        shortsurl,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        shorts = true;
      } else {
        shorts = false;
      }
    } catch (e) {
      throw Exception(e);
    }

    return shorts;
  }
}
