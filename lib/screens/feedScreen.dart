import 'package:flutter/material.dart';
import 'package:socialmedia/components/post_card.dart';
import 'package:socialmedia/models/post.dart';

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
          'https://i.pinimg.com/564x/39/2d/7a/392d7ac0aca769d528ec4984359177cd.jpg',
      description: 'yolo',
      userimage:
          'https://images.unsplash.com/photo-1611643378160-39d6dd915b69?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YW5pbWF0aW9ufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
    ),
    Post(
      username: "blender",
      address: 'london',
      date: '2022/1/2',
      image:
          'https://images.unsplash.com/photo-1611643378160-39d6dd915b69?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YW5pbWF0aW9ufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
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
          child: Column(
            children: [
              ListView.separated(
                  itemCount: postlst.length,
                  separatorBuilder: (context, index) => const Divider(),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 550,
                      child: PostCard(
                        username: postlst[index].username,
                        image: postlst[index].image,
                        date: postlst[index].date,
                        address: postlst[index].address,
                        description: postlst[index].description,
                        userimage: postlst[index].userimage,
                      ),
                    );
                  }),

              // PostCard(
              //   username: 'name',
              //   image: null,
              //   date: 'sdfds',
              //   address: 'sdfds',
              //   description: 'sdfdsf',
              //   userimage:
              //       'https://myrepublica.nagariknetwork.com/uploads/media/2019/July/Kung-Fu-Panda.jpg',
              // ),

              // PostCard(
              //   username: 'name',
              //   image:
              //       'https://myrepublica.nagariknetwork.com/uploads/media/2019/July/Kung-Fu-Panda.jpg',
              //   date: 'sdfds',
              //   address: 'sdfds',
              //   description: 'sdfdsf',
              //   userimage:
              //       'https://myrepublica.nagariknetwork.com/uploads/media/2019/July/Kung-Fu-Panda.jpg',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
