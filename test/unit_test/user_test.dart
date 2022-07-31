import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:socialmedia/models/User.dart';
import 'package:socialmedia/repository/PostRepository.dart';
import 'package:socialmedia/repository/UserRepository.dart';

import 'package:socialmedia/response/logindispatch.dart';
// import 'package:socialmedia/response/FeedsResponse.dart';
import 'package:socialmedia/api/httpServices.dart';
import 'package:socialmedia/utils/url.dart';

void main() {
  UserRepository? userRepository;
  PostRepository? postRepository;

  group('Authorization Test', () {
    setUp(() {
      userRepository = UserRepository();
      postRepository = PostRepository();
    });

    test('login user', () async {
      bool expectedResult = true;

      User user = User(email: "cristiano@gmail.com", password: "cristiano");

      // UserRepository userRepository = UserRepository();

      bool actualResult = await userRepository!.login(user);

      expect(true, actualResult);
    });
    test('Register user', () async {
      bool expectedResult = true;
      // UserRepository userRepository = UserRepository();

      User user = User(
          name: "numsasss",
          email: "numsssi@gmail.com",
          location: "londonsss",
          username: "numsssssa",
          password: "numassnuma");

      LoginDispatch actualResult = await userRepository!.registerUser(user);

      expect(expectedResult, actualResult.login);
    });
  });

  test('get product', () async {
    var url = baseUrl + loginUrl;

    var dio = HttpServices().getDiorInstance();

    var postsurl = baseUrl + getFeedsUrl;

    var response = await dio.post(url, data: {
      "email": "cristiano@gmail.com",
      "password": "cristiano",
    });

    String token = response.data['token'];

    var postresponse = await dio.get(
      postsurl,
      options:
          Options(headers: {HttpHeaders.authorizationHeader: "Bearer $token"}),
    );

    expect(200, postresponse.statusCode);
  });

  test('add Product',() async{
  
  });

  tearDown(() {
    userRepository = null;
    postRepository = null;
  });
}
