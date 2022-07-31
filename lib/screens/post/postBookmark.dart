import 'package:flutter/material.dart';
import 'package:socialmedia/models/Posts.dart';
import 'package:socialmedia/repository/PostRepository.dart';
import 'package:socialmedia/response/FeedsResponse.dart';
import 'package:socialmedia/utils/url.dart';

class PostBookMark extends StatelessWidget {
  static const String id = "postBookMakr";
  const PostBookMark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Saved Posts',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: FutureBuilder<FeedsResponse?>(
            future: PostRepository().savedPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data != null) {
                  // ProductResponse productResponse = snapshot.data!;
                  List<Posts> postlst = snapshot.data!.posts!;

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 2.0,
                            mainAxisSpacing: 4.0),
                    itemCount: postlst.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Image.network(
                          '$baseUr${postlst[index].images![0]}',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
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
        ),
      ),
    );
  }
}
