import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmedia/components/post_card.dart';
import 'package:socialmedia/models/Posts.dart';

// ignore: must_be_immutable
class ProfileSliderScreen extends StatelessWidget {
  static const String id = 'Explore_VerticalView';

  PageController sliderContoller;
  List<Posts> sliderpost;
  int currntePage;
  ProfileSliderScreen(this.sliderContoller, this.sliderpost, this.currntePage,
      {Key? key})
      : super(key: key);

  final controller = CarouselController();
  RxInt activeIndex = 0.obs;

  Widget buildImage(Posts post, int index) => Container(
      color: Colors.black,
      child: PostCard(
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
      ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CarouselSlider.builder(
          carouselController: controller,
          itemCount: sliderpost.length,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height,

            // pageSnapping: false,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            viewportFraction: 1,
            onPageChanged: (index, reason) => activeIndex.value = index,
          ),
          itemBuilder: (context, index, realIndex) {
            final urlImage = sliderpost[index];
            return buildImage(urlImage, index);
          },
        ),
      ),
    );
  }
}
