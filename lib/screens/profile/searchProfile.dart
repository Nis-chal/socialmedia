import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/models/Posts.dart';
import 'package:socialmedia/repository/PostRepository.dart';
import 'package:socialmedia/utils/url.dart';
import 'package:staggered_grid_view_flutter/staggered_grid_view_flutter.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
class SearchProfileScreen extends StatelessWidget {
  SearchProfileScreen({Key? key}) : super(key: key);

  final search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 8.0),
          child: Column(
            children: [
              
              
              
              CupertinoSearchTextField(
                borderRadius: BorderRadius.circular(20),
              ),

              




          ]),
        )
        ,
      ),
    );
  }
}