import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmedia/components/post_card.dart';
import 'package:socialmedia/components/post_cardv2.dart';
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
  RxBool issearch = true.obs;
  RxBool isview = true.obs;
  RxBool isexplore = false.obs;
  final controller = CarouselController();
  RxInt activeIndex = 0.obs;

   Widget buildImage(Posts post,int index)=>Container(
      color: Colors.white,
      child: PostCardV2(
                      id: post.id,
                      username: post.userid!.username!,
                      image: post.images,
                      date: post.createdAt,
                      address: post.location,
                      description: post.description,
                      userimage: post.userid!.profilePicture,
                      likesid: post.likesid,
                      commentsid: post.commentsid,
                      updatedAt: post.updatedAt,
                      createdAt: post.createdAt,
                      saved: post.saved,
                     
                    )
    );
    void animateToSlide (int index) => controller.jumpToPage(index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 8.0),
          child: Column(
            children: [
              
              
              
               Obx(() => 
               
               
                issearch.value?GestureDetector(
                onTap: (() {
                  
                }),
                child: CupertinoSearchTextField(
                  borderRadius: BorderRadius.circular(20),
                ),
              ):Container(
                height: 30,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  IconButton(onPressed: (){
                    isview.value = false;
                    issearch.value = true;
                    
                  }, icon: const Icon(Icons.arrow_back_ios) ,padding: const EdgeInsets.all(0),)
                  ,
                  Padding(
                    padding:  EdgeInsets.only(left:
                    MediaQuery.of(context).size.width * 0.3
                    
                  
                    ),
                    child:const Text('Explore',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  )
                ],),
              ),
               ),

              FutureBuilder<ExplorePostResponse?>(
                future: PostRepository().exploreFeeds(),
                builder:(context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                // ProductResponse productResponse = snapshot.data!;
                List<Posts> postlst = snapshot.data!.posts!;
              
                return 
                Obx(() {
                return
                isexplore.value?Text('searchpage'): 

                             Obx(() {
                             return
                             
                                  isview.value? Expanded(
                                   child: StaggeredGridView.countBuilder(
                                    staggeredTileBuilder: (index) => index % 7 ==0? const StaggeredTile.count(2,2):StaggeredTile.count(1,1),
                                    crossAxisCount: 3,  
                                    crossAxisSpacing: 2.0,  
                                    mainAxisSpacing: 4.0 ,
                                    
                                    itemCount: postlst.length, 
                                    itemBuilder: (BuildContext context, int index){
                                 
                                      return ElevatedButton(
                                        onPressed: (() {
                                              isview.value = false;
                                            
                                          controller.jumpToPage(3); 
                                        }),
                                        child: Stack(
                                         fit: StackFit.expand,
                                         children: [
                                         Image.network('$baseUr${postlst[index].images![1]}',fit: BoxFit.cover,),
                                                    
                                         Positioned(
                                           top: 0,
                                           right: 0,
                                           child: Visibility(
                                             visible: postlst[index].images!.length > 1?true:false,
                                             
                                             child: 
                                           const Icon(Icons.file_copy,
                                           color: Colors.white70,
                                           
                                           )
                                           ),
                                         ),
                                         
                                         ]),
                                      );  
                                    },  
                                    
                                    ),
                                 ):
              
                                 CarouselSlider.builder(
                                                 carouselController: controller,
                                               itemCount: postlst.length,
                                               options: CarouselOptions(
                                                
                                                 height: 720 -53,
                                              
                                               scrollDirection: Axis.vertical,
                                               
                                              //  pageSnapping: false,
                                               enableInfiniteScroll: false,
                                               enlargeCenterPage: true,
                                                       viewportFraction: 1,
                                               onPageChanged: (index, reason) => 
                                                
                                                activeIndex.value = index,
                                               ),
                                                itemBuilder: (context, index, realIndex) {
                                                 final post = postlst[index];
                                                 return buildImage(post,index);
                                               
                                                         },);
                });
                                

              }) ;
                
              
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