import 'package:flutter/material.dart';
import 'package:socialmedia/components/FollowButton.dart';
class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  int postLen = 22;
  int followers = 22;
  int following = 22;

  String currentuserid = "hello";
  
  String profileuserid = "hello";
  bool isFollowing = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(child: 
      Column(children: [

        Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                              '',
                            ),
                            radius: 40,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildStatColumn(postLen, "posts"),
                                    buildStatColumn(followers, "followers"),
                                    buildStatColumn(following, "following"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    currentuserid == profileuserid
                                        ? FollowButton(
                                            text: 'Sign Out',
                                            backgroundColor:
                                                Colors.blue.shade600,
                                            textColor: Colors.white,
                                            borderColor: Colors.grey,
                                            function: (){}
                                          )
                                        : isFollowing
                                            ? FollowButton(
                                                text: 'Unfollow',
                                                backgroundColor: Colors.white,
                                                textColor: Colors.black,
                                                borderColor: Colors.grey,
                                                function: (){}
                                              )
                                            : FollowButton(
                                                text: 'Follow',
                                                backgroundColor: Colors.blue,
                                                textColor: Colors.white,
                                                borderColor: Colors.blue,
                                                function: (){}
                                              )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),


      ],)
      
      ),
    );


    
  }


  Column buildStatColumn(int value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
      value.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}