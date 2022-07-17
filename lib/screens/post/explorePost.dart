import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/models/Posts.dart';
import 'package:socialmedia/repository/PostRepository.dart';
import 'package:socialmedia/response/postResponse/ExplorePostResponse.dart';
import 'package:socialmedia/utils/url.dart';
import 'package:staggered_grid_view_flutter/staggered_grid_view_flutter.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
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
              ),

              FutureBuilder<ExplorePostResponse?>(
                future: PostRepository().exploreFeeds(),
                builder:(context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                // ProductResponse productResponse = snapshot.data!;
                List<Posts> postlst = snapshot.data!.posts!;

                return Expanded(
                                   child: StaggeredGridView.countBuilder(
                                    staggeredTileBuilder: (index) => index % 10 ==0? StaggeredTile.count(2,2):StaggeredTile.count(1,1),
                                    crossAxisCount: 3,  
                                    crossAxisSpacing: 2.0,  
                                    mainAxisSpacing: 4.0 ,
                                    
                                    itemCount: postlst.length, 
                                    itemBuilder: (BuildContext context, int index){
                                 
                                      return Image.network('$baseUr${postlst[index].images![1]}',fit: BoxFit.cover,);  
                                    },  
                                    
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




          ]),
        )
        ,
      ),
    );
  }
}