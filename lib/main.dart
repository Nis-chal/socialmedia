import 'package:flutter/material.dart';

import 'package:socialmedia/screens/loginScreen.dart';
import 'package:socialmedia/screens/registerScreen.dart';
import 'package:socialmedia/screens/navigationdrawer.dart';
import './responsive/login_layout.dart';
import 'package:socialmedia/responsive/feed_layout.dart';
import 'package:socialmedia/screens/post/post_edit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // theme: ThemeData.dark(),
      initialRoute: LoginLayout.id,

      routes: {
        LoginLayout.id:(context) => const LoginLayout(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        NavigationDrawer.id: (context) => NavigationDrawer(),
        FeedLayout.id:(context)=>FeedLayout(),
        PostEditScreen.id:(context) => PostEditScreen() 
      },
    );
  }
}
