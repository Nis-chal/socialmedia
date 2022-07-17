import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ExplorePost extends StatelessWidget {
  ExplorePost({Key? key}) : super(key: key);

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
              )




          ]),
        )
        ,
      ),
    );
  }
}