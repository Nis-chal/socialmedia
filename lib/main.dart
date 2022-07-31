import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/components/addPostCarousel.dart';
import 'package:socialmedia/screens/add_post.dart';
import 'package:socialmedia/screens/comments/PostCommentsScreen.dart';

import 'package:socialmedia/screens/loginScreen.dart';
import 'package:socialmedia/screens/post/add_post_description.dart';
import 'package:socialmedia/screens/post/explorePostVerticalView.dart';
import 'package:socialmedia/screens/post/postBookmark.dart';
import 'package:socialmedia/screens/post/postProviewScreen.dart';
import 'package:socialmedia/screens/profile/editProfile.dart';
import 'package:socialmedia/screens/profile/profileScreen.dart';
import 'package:socialmedia/screens/registerScreen.dart';
import 'package:socialmedia/screens/navigationdrawer.dart';
import 'package:socialmedia/screens/shorts/Addshort.dart';
import './responsive/login_layout.dart';
import 'package:socialmedia/responsive/feed_layout.dart';
import 'package:socialmedia/screens/post/post_edit.dart';
import 'package:socialmedia/screens/post/post_detail.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:socialmedia/screens/shorts/ShortsLstScreen.dart';

void main() async {
  await Hive.initFlutter();

  AwesomeNotifications().initialize('resource://drawable/launcher', [
    NotificationChannel(
      channelGroupKey: 'basic_channel_group',
      channelKey: 'basic_channel',
      channelName: 'Basic Notifications',
      importance: NotificationImportance.Max,
      ledColor: Colors.white,
      channelShowBadge: true,
      channelDescription: 'Notification for the basic test of the app',
    ),
  ]);
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
        ProfileScreen.id: (context) => ProfileScreen(
            arguments: ModalRoute.of(context)!.settings.arguments as String),
        ExploreVerticalView.id: (context) => ExploreVerticalView(
            ModalRoute.of(context)!.settings.arguments as Map),
        EditProfileScreen.id: (context) => EditProfileScreen(
            ModalRoute.of(context)!.settings.arguments as Map),
        ShortsLstScreen.id: (context) => ShortsLstScreen(),
        AddShortScreen.id: (context) =>
            AddShortScreen(ModalRoute.of(context)!.settings.arguments as File),

        PostCommentScreen.id:(context) => PostCommentScreen(ModalRoute.of(context)!.settings.arguments as String),
        PostBookMark.id: (context) => const PostBookMark(),
         
      },
    );
  }
}
