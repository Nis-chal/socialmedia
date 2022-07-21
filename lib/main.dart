import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socialmedia/components/addPostCarousel.dart';
import 'package:socialmedia/screens/add_post.dart';

import 'package:socialmedia/screens/loginScreen.dart';
import 'package:socialmedia/screens/post/add_post_description.dart';
import 'package:socialmedia/screens/post/explorePostVerticalView.dart';
import 'package:socialmedia/screens/post/postProviewScreen.dart';
import 'package:socialmedia/screens/profile/editProfile.dart';
import 'package:socialmedia/screens/profile/profileScreen.dart';
import 'package:socialmedia/screens/registerScreen.dart';
import 'package:socialmedia/screens/navigationdrawer.dart';
import './responsive/login_layout.dart';
import 'package:socialmedia/responsive/feed_layout.dart';
import 'package:socialmedia/screens/post/post_edit.dart';
import 'package:socialmedia/screens/post/post_detail.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
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
        LoginLayout.id: (context) => const LoginLayout(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        NavigationDrawer.id: (context) => NavigationDrawer(
            idImage: ModalRoute.of(context)!.settings.arguments as Map),
        FeedLayout.id: (context) => FeedLayout(),
        PostEditScreen.id: (context) => PostEditScreen(),
        PostDetailScreen.id: ((context) => PostDetailScreen(
            ModalRoute.of(context)!.settings.arguments as String)),
        AddPost.id: ((context) =>
            AddPost(ModalRoute.of(context)!.settings.arguments as List<File>)),
        PostCarousel.id: (context) => PostCarousel(),
        PostPreviewScreen.id: (context) => PostPreviewScreen(
            ModalRoute.of(context)!.settings.arguments as List<File>),
        AddPostDecriptionScreen.id: (context) => AddPostDecriptionScreen(),
        ProfileScreen.id: (context) =>
            ProfileScreen(arguments:ModalRoute.of(context)!.settings.arguments as String),
        ExploreVerticalView.id: (context) => ExploreVerticalView(
            ModalRoute.of(context)!.settings.arguments as Map),
        EditProfileScreen.id: (context) => EditProfileScreen(
            ModalRoute.of(context)!.settings.arguments as Map),
      },
    );
  }
}
