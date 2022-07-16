import 'package:flutter/material.dart';
// import 'package:socialmedia/components/post_card.dart';
import 'package:socialmedia/models/Posts.dart';
import '../response/FeedsResponse.dart';
import '../repository/PostRepository.dart';
import 'package:socialmedia/wearhouse/components/wearProductCard.dart';

class WearFeedScreen extends StatefulWidget {
  static const String id = 'WearFeed_screen';

  WearFeedScreen({Key? key}) : super(key: key);

  @override
  State<WearFeedScreen> createState() => _WearFeedScreenState();
}

class _WearFeedScreenState extends State<WearFeedScreen> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F5F8),
     
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
                      height: MediaQuery.of(context).size.height,
                      child: WearPostCard(
                        username: postlst[index].userid!.username!,
                        image: postlst[index].images,
                        // date: postlst[index].createdAt,
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

 
        ),
      ),
    );
  }
}
