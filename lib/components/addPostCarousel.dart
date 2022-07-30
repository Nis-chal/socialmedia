import 'dart:ui';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:socialmedia/screens/post/add_post_description.dart';
import 'package:socialmedia/utils/url.dart';
import 'package:blur/blur.dart';

class PostCarousel extends StatelessWidget {
  static const String id = "Post_carousel";

  List<File>? listofImage;
  List<File>? _imagelist;
  PostCarousel({Key? key, this.listofImage}) : super(key: key);

  var activeIndex = 0.obs;
  final controller = CarouselController();
  final urlImage = [
    "https://www.pockettactics.com/wp-content/uploads/2022/03/anime-dimensions-tier-list.jpg",
    "https://cdn-www.comingsoon.net/assets/uploads/2021/09/onepiece.jpg",
    "https://www.pockettactics.com/wp-content/uploads/2022/03/anime-dimensions-tier-list.jpg",
    "https://www.pockettactics.com/wp-content/uploads/2022/03/anime-dimensions-tier-list.jpg",
    "https://www.pockettactics.com/wp-content/uploads/2022/03/anime-dimensions-tier-list.jpg",
  ];

  Widget buildImage(String urlImage, int index) => Container(
        color: Colors.black,
        child: Image.file(
          File(urlImage),
          fit: BoxFit.cover,
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex.value,
        count: listofImage!.length,
        effect: JumpingDotEffect(
            dotWidth: 10,
            dotHeight: 10,
            activeDotColor: Colors.red,
            dotColor: Colors.black12),
      );
  void animateToSlide(int index) => controller.animateToPage(index);
  void indexImage() =>
      controller.nextPage(duration: Duration(milliseconds: 100));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(fit: StackFit.expand, children: [
            Container(
              color: Colors.black,
              child: CarouselSlider.builder(
                carouselController: controller,
                itemCount: listofImage!.length,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,

                  // pageSnapping: false,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) => activeIndex.value = index,
                ),
                itemBuilder: (context, index, realIndex) {
                  final urlImage = listofImage![index].path;
                  return buildImage(urlImage, index);
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.black.withOpacity(0.1),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                                color: Colors.black.withOpacity(0.1),
                                height: 70,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: ListView.separated(
                                    itemCount: listofImage!.length,
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (context, index) =>
                                        const Divider(),
                                    shrinkWrap: true,
                                    // physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final urlImage = listofImage![index].path;

                                      return GestureDetector(
                                          onTap: () {
                                            activeIndex.value = index;
                                            animateToSlide(index);
                                          },
                                          child: (Obx((() => Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 7.0,
                                                        horizontal: 7.0),
                                                margin: const EdgeInsets.only(
                                                    right: 5),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: activeIndex.value
                                                                  .toInt() ==
                                                              index
                                                          ? Colors.grey.shade400
                                                          : Colors.transparent),
                                                ),
                                                width: 70,
                                                child: Image.file(
                                                  File(urlImage),
                                                  fit: BoxFit.cover,
                                                ),
                                              )))));
                                    })

                                //               Image.network(

                                // "https://www.pockettactics.com/wp-content/uploads/2022/03/anime-dimensions-tier-list.jpg",
                                // fit: BoxFit.cover,

                                //               )

                                ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            height: 50,
                            width: 50,
                            color: Colors.white,
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AddPostDecriptionScreen.id,
                                      arguments: listofImage);
                                },
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.all(0)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),

        // buildIndicator()
      ],
    );
  }
}
