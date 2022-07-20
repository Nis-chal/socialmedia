import 'package:flutter/material.dart';
import 'package:socialmedia/components/post_card.dart';
import 'package:socialmedia/models/Posts.dart';
import 'package:socialmedia/repository/PostRepository.dart';
import 'package:socialmedia/response/PostDetailResponse.dart';
import 'package:socialmedia/responsive/navigation_drawer.dart';

class PostDetailScreen extends StatefulWidget {
  static const String id = 'postedit_screen';

  final String? args;
  const PostDetailScreen(this.args, {Key? key}) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  String? username, description, address, userimage, updatedAt, id;
  List<String>? image, likesid, commentsid, saved;
  DateTime? createdAt, date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('cancel'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  onPrimary: Colors.black,
                  shadowColor: Colors.transparent,
                ),
              ),
              Text(
                "Updated Post",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, NavigationDrawer.id);
                },
                child: Text('Done'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  onPrimary: Colors.blue[600],
                  shadowColor: Colors.transparent,
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          FutureBuilder<PostDetailResponse?>(
            future: PostRepository().postDetail(widget.args!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data != null) {
                  Posts? feed = snapshot.data!.post;
                  return SizedBox(
                    height: 720,
                    child: (PostCard(
                      address: feed!.location,
                      username: feed.userid!.username ?? "hello",
                      userimage: feed.userid!.profilePicture ?? "sdf",
                      description: feed.description,
                      updatedAt: feed.updatedAt,
                      image: feed.images,
                      commentsid: feed.commentsid,
                      saved: feed.saved,
                      createdAt: feed.createdAt,
                      date: feed.createdAt,
                      likesid: feed.likesid,
                      id: feed.id,
                    )

                        //             PostCard(
                        //   address:address ,
                        // username: username,
                        // userimage: userimage,
                        // description: description,
                        // updatedAt: updatedAt,
                        // image: image,
                        // commentsid: commentsid,
                        // saved: saved,
                        // createdAt: createdAt,
                        // date: date,

                        // )
                        ),
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
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                );
              }
            },
          ),
        ],
      )),
    );
  }
}
