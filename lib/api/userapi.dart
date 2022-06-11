import 'dart:io';

import 'package:socialmedia/api/httpServices.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:socialmedia/utils/url.dart';
import 'package:socialmedia/models/User.dart';
import 'package:socialmedia/response/LoginResponse.dart';
import 'package:flutter/foundation.dart';


class UserApi{
  Future<bool>registerUser(User user) async{
    bool isLogin= false;


    try{
    var url = baseUrl + registerUrl;
    var dio = HttpServices().getDiorInstance();
  
      var formData = FormData.fromMap(
        {
          "name":user.name,
          "username":user.username,
          "password":user.password,
          "location":user.location,
          "email":user.email,

          
        
        }

      
      );

      var response = await dio.post(url,data:formData);

      if (response.statusCode == 201){
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        token = loginResponse.token;
        isLogin = true;
      }


    }catch(e){
      debugPrint(e.toString());

      

    }
    return isLogin;

  
  }

}