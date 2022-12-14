import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmedia/components/post_card.dart';
import 'package:socialmedia/models/Posts.dart';
import 'package:socialmedia/screens/shorts/ShortsLstScreen.dart';
import '../response/FeedsResponse.dart';
import '../repository/PostRepository.dart';

class FeedScreen extends StatefulWidget {
  static const String id = 'feed_screen';

  FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  RxBool onDelete = true.obs;
  final controller = ScrollController();
  RxBool viewProfile = false.obs;

  RxString profileId = ''.obs;

  Future<void> updateData() async {
    setState(() {});
  }

  double x = 0, y = 0, z = 0;
  String direction = "none";

  


  

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
              Icons.play_arrow,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushNamed(context, ShortsLstScreen.id);
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: FutureBuilder<FeedsResponse?>(
            future: PostRepository().getFeeds(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data != null) {
                  // ProductResponse productResponse = snapshot.data!;
                  List<Posts> postlst = snapshot.data!.posts!;

                  return RefreshIndicator(
                    onRefresh: updateData,
                    child: ListView.separated(
                        itemCount: postlst.length,
                        separatorBuilder: (context, index) => const Divider(),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return (PostCard(
                            id: postlst[index].id,
                            username: postlst[index].userid!.username!,
                            image: postlst[index].images,
                            date: postlst[index].createdAt,
                            address: postlst[index].location,
                            description: postlst[index].description,
                            userimage: postlst[index].userid!.profilePicture,
                            likesid: postlst[index].likesid,
                            commentsid: postlst[index].commentsid,
                            updatedAt: postlst[index].updatedAt,
                            createdAt: postlst[index].createdAt,
                            saved: postlst[index].saved,
                            postUserId: postlst[index].userid!.id,
                          ));
                        }),
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
