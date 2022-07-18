import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/api/httpServices.dart';
import 'package:socialmedia/response/profileResponse/ProfileResponse.dart';
import 'package:socialmedia/response/profileResponse/ProfileSearchResponse.dart';
import 'package:socialmedia/utils/url.dart';

class ProfileApi{


  Future<ProfileResponse?>userProfile(String profileid)async{
    ProfileResponse? profileResponse;



    var postsurl = baseUrl + getProfileUrl + profileid;

    try{
      var dio = HttpServices().getDiorInstance();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      Response response = await dio.get(
        postsurl,
        options:Options(headers: {HttpHeaders.authorizationHeader:"Bearer $token"}),

      
      );
      if (response.statusCode == 200) {
          profileResponse = ProfileResponse.fromJson(response.data);
        } else {
          profileResponse= null;
        }


    }catch(e){
      throw Exception(e);

    }

    return profileResponse;

    
  }

  Future<ProfileSearchResponse?>profileSearch(String username)async{
    ProfileSearchResponse? profileSearchResponse;


    var postsurl = baseUrl + getProfileUrl + username;

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



}