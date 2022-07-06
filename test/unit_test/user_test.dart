import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:socialmedia/models/User.dart';
import 'package:socialmedia/repository/UserRepository.dart';

import 'package:socialmedia/response/logindispatch.dart';
import 'package:socialmedia/response/FeedsResponse.dart';



void main(){

  late UserRepository? userRepository;

  setUp((){
   userRepository = UserRepository();
  });

  group('Authorization Test', (){
  test('Register user', () async{

    LoginDispatch expectedResult = LoginDispatch(login: true);

   

    User user = User(

      name:"sarthak",
      email: "shresth3a@gmail.com",
      location: "london",
      username: "sarthak",
      password: "sarthak"
    );

    LoginDispatch actualResult = await userRepository!.registerUser(user);

    expect(expectedResult.login,actualResult.login);
  });

  test('login user', () async{

   bool expectedResult = true;

   

    User user = User(

     
      email: "cristiano@gmail.com",
      
      password: "cristiano"
    );

    bool actualResult = await userRepository!.login(user);

    expect(expectedResult,actualResult);
  });
  });

  test('get product',() async{

   


  });



  tearDown((){
    userRepository = null;
  });
}


