import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/api/httpServices.dart';
import 'package:socialmedia/response/profileResponse/ProfileResponse.dart';
import 'package:socialmedia/response/profileResponse/ProfileSearchResponse.dart';
import 'package:socialmedia/response/profileResponse/ProfileUpdateResponse.dart';
import 'package:socialmedia/utils/url.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class ProfileApi {
  Future<ProfileResponse?> userProfile(String profileid) async {
    ProfileResponse? profileResponse;

    var postsurl = baseUrl + getProfileUrl + profileid;

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
        profileResponse = ProfileResponse.fromJson(response.data);
      } else {
        profileResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }

    return profileResponse;
  }

  Future<ProfileSearchResponse?> profileSearch(String username) async {
    ProfileSearchResponse? profileSearchResponse;

    var postsurl = baseUrl + searchProfileUrl + username;

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
        profileSearchResponse = ProfileSearchResponse.fromJson(response.data);
      } else {
        profileSearchResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }

    return profileSearchResponse;
  }

  Future<bool> followUser(String userid) async {
    bool folllow;

    var followurl = baseUrl + '$followUrl$userid';

    try {
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      Response response = await dio.patch(
        followurl,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        folllow = true;
      } else {
        folllow = false;
      }
    } catch (e) {
      throw Exception(e);
    }

    return folllow;
  }

  Future<bool> unfollowUser(String userid) async {
    bool folllow;

    var followurl = baseUrl + '$unfollowUrl$userid';

    try {
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      Response response = await dio.patch(
        followurl,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        folllow = true;
      } else {
        folllow = false;
      }
    } catch (e) {
      throw Exception(e);
    }

    return folllow;
  }

  Future<ProfileUpdateResponse?> updateProfile({
    File? fimage,
    String? username,
    String? name,
    String? email,
    String? location,
    String? nimage,
    String? userid,
  }) async {
    ProfileUpdateResponse? posts;

    var postsurl = baseUrl + updateUser + userid!;
    FormData formData;

    try {
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (fimage != null) {
        var mimeType = lookupMimeType(fimage.path);
        MultipartFile multipartFile = await MultipartFile.fromFile(
          fimage.path,
          filename: fimage.path.split("/").last,
          contentType: MediaType("image", mimeType!.split("/")[1]),
        );
        FormData formData = FormData.fromMap({
          "profilePicture": multipartFile,
          "location": location,
          "email": email,
          "name": name,
          "username": username
        });

        var response = await dio.put(
          postsurl,
          data: formData,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
        );

        if (response.statusCode == 200) {
          posts = ProfileUpdateResponse.fromJson(response.data);
        } else {
          posts = null;
        }
      } else {
        FormData formData = FormData.fromMap({
          "location": location,
          "email": email,
          "name": name,
          "username": username
        });

        Response response = await dio.put(
          postsurl,
          data: formData,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
        );

        if (response.statusCode == 200) {
          posts = ProfileUpdateResponse.fromJson(response.data);
        } else {
          posts = null;
        }
      }

      // for (var file in images) {

      //   uploadList.add(multipartFile);
      // }

    } catch (e) {
      throw Exception(e);
    }

    return posts;
  }

  Future<bool> removeFollower(String followerid) async {
    bool posts;

    var postsurl = baseUrl + '$removeFollower$followerid';

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
}
