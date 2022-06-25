import 'package:flutter/material.dart';
import 'package:socialmedia/components/post_card.dart';
import 'package:socialmedia/models/post.dart';
import 'package:socialmedia/models/Posts.dart';
import '../response/FeedsResponse.dart';
import '../repository/PostRepository.dart';

class FeedScreen extends StatefulWidget {
  static const String id = 'feed_screen';

  FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<Post> postlst = [
    Post(
      username: "new",
      address: 'london',
      date: '2022/1/2',
      image:
      [

          'https://i.pinimg.com/564x/39/2d/7a/392d7ac0aca769d528ec4984359177cd.jpg',
          'https://i.pinimg.com/564x/39/2d/7a/392d7ac0aca769d528ec4984359177cd.jpg',
          'https://i.pinimg.com/564x/39/2d/7a/392d7ac0aca769d528ec4984359177cd.jpg',
          'https://i.pinimg.com/564x/39/2d/7a/392d7ac0aca769d528ec4984359177cd.jpg',
          
      ],
      description: 'yolo',
      userimage:
          'https://images.unsplash.com/photo-1611643378160-39d6dd915b69?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YW5pbWF0aW9ufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
    ),
    Post(
      username: "blender",
      address: 'london',
      date: '2022/1/2',
        image:
      [

          'https://i.pinimg.com/564x/39/2d/7a/392d7ac0aca769d528ec4984359177cd.jpg',
          'https://i.pinimg.com/564x/39/2d/7a/392d7ac0aca769d528ec4984359177cd.jpg',
          'https://i.pinimg.com/564x/39/2d/7a/392d7ac0aca769d528ec4984359177cd.jpg',
          'https://i.pinimg.com/564x/39/2d/7a/392d7ac0aca769d528ec4984359177cd.jpg',
          
      ],
      description: 'yolo',
      userimage:
          'https://images.unsplash.com/photo-1611643378160-39d6dd915b69?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YW5pbWF0aW9ufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F5F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/images/Winkle.png',
          height: 32,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.messenger_outline,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child:FutureBuilder<FeedsResponse?>(
          future: PostRepository().getFeeds(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                // ProductResponse productResponse = snapshot.data!;
                List<Posts> postlst = snapshot.data!.posts!;

                return ListView.separated(
                  itemCount: postlst.length,
                  separatorBuilder: (context, index) => const Divider(),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 550,
                      child: PostCard(
                        username: postlst[index].userid!.username!,
                        image: postlst[index].images,
                        date: postlst[index].createdAt,
                        address: postlst[index].location,
                        description: postlst[index].description,
                        userimage: postlst[index].userid!.profilePicture,
                      ),
                    );
                  }
                  );

              } else {
                return const Center(
                  child: Text("No data"),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              );
            }
          },
        ), 

          // Column(
          //   children: [
          //     ListView.separated(
          //         itemCount: postlst.length,
          //         separatorBuilder: (context, index) => const Divider(),
          //         shrinkWrap: true,
          //         physics: NeverScrollableScrollPhysics(),
          //         itemBuilder: (context, index) {
          //           return SizedBox(
          //             height: 550,
          //             child: PostCard(
          //               username: postlst[index].username,
          //               image: postlst[index].image,
          //               date: postlst[index].date,
          //               address: postlst[index].address,
          //               description: postlst[index].description,
          //               userimage: postlst[index].userimage,
          //             ),
          //           );
          //         }),

              
          //   ],
          // ),
        ),
      ),
    );
  }
}
