import 'package:socialmedia/response/shortsResponse/ShortsResponse.dart';
import 'dart:io';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

import '../utils/url.dart';
import '../api/httpServices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

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
}
