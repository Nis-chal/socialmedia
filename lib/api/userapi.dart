import 'dart:convert';
import 'dart:io';

import 'package:socialmedia/api/httpServices.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:socialmedia/utils/url.dart';
import 'package:socialmedia/models/User.dart';
import 'package:socialmedia/response/LoginResponse.dart';
import 'package:flutter/foundation.dart';
import 'package:socialmedia/response/logindispatch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/models/User.dart';


class UserApi{

  Future<bool> login(User user) async{
    bool isLogin= false;
   
   
    var url = baseUrl + loginUrl;
    var dio = HttpServices().getDiorInstance();

    
    try{
      var response = await dio.post(
        url,
        data:{

        "email":user.email,
        "password":user.password,
        }
      
      
        );
        
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        String userdata = jsonEncode(response.data['user']);
        sharedPreferences.setString('userdata',userdata);


      var data = (sharedPreferences.getString('userdata') ?? '');


        var userdatas = User.fromJson(jsonDecode(userdata.toString()));  
       var userid = userdatas.id.toString();
      


      if(response.statusCode == 200){
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
         String userdata = jsonEncode(response.data['user']);
        sharedPreferences.setString('userdata',userdata);
        token = loginResponse.token;
        sharedPreferences.setString('token','$token');
        isLogin = true;
      }
    }catch(e){
      debugPrint(e.toString());
    }
    return isLogin;
  }

  Future<LoginDispatch>registerUser(User user) async{
    bool isLogin= false;

    final loginaction = LoginDispatch();
    loginaction.login = false;

    


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
        loginaction.login = true;
      }
      


    }on DioError catch(e){
        
        loginaction.errorMsg = e.response!.data['msg'];

    }
    catch(e){
      
      debugPrint(e.toString());

      

    }
    return loginaction;

  
  }




}