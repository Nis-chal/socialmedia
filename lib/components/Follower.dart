import 'package:flutter/material.dart';

import '../utils/url.dart';

class Follower extends StatelessWidget {
  String username,profilePicture,followerid;
 
  Follower(this.username,this.profilePicture,this.followerid,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundImage:
              NetworkImage(baseUr + profilePicture),
        ),
        Text(username),
        ElevatedButton(
          onPressed: () {


          },
          child: Text('Remove'),
          style: ElevatedButton.styleFrom(
              primary: Colors.grey, padding: EdgeInsets.symmetric(vertical: 4)),
        )
      ],
    );
    ;
  }
}