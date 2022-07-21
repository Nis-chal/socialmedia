import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socialmedia/components/addPostCarousel.dart';

class PostPreviewScreen extends StatelessWidget {
  static const String id = "PostPreviewScreen_id";
  List<File>? arguments;
  PostPreviewScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: PostCarousel(
        listofImage: arguments,
      )),
    );
  }
}
