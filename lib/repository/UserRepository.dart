import 'package:socialmedia/api/userapi.dart';
import 'dart:io';
import 'package:socialmedia/models/User.dart';

class UserRepository{
  Future<bool> registerUser(User user) async{
    return  await UserApi().registerUser(user);

  }



  

  
}