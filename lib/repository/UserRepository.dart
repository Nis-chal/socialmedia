import 'package:socialmedia/api/userapi.dart';
import 'dart:io';
import 'package:socialmedia/models/User.dart';
import 'package:socialmedia/response/logindispatch.dart';

class UserRepository {
  Future<LoginDispatch> registerUser(User user) async {
    return await UserApi().registerUser(user);
  }

  Future<bool> login(User user) async {
    return await UserApi().login(user);
  }
}
