import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FileImageSlider extends StatelessWidget {

  List<File>? listofImage;
  RxInt activeIndex = 0.obs;


  FileImageSlider({Key? key, this.listofImage}) : super(key: key);
   

    Widget buildImage(String urlImage,int index)=>Container(
      color: Colors.grey,
      child: Image.file(File(urlImage),fit: BoxFit.cover,),
    );

    Widget buildIndicator()=>AnimatedSmoothIndicator(
      activeIndex: activeIndex.value, 
      count: listofImage!.length,
      effect: JumpingDotEffect(
        dotWidth: 10,
        dotHeight: 10,
        activeDotColor: Colors.red,
        dotColor: Colors.black12
        
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: listofImage!.length,
          options: CarouselOptions(
    height: MediaQuery.of(context).size.height * 0.55,
          aspectRatio: 2.0,
          // pageSnapping: false,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
                  viewportFraction: 1,
          onPageChanged: (index, reason) => 
           
           activeIndex.value = index
          ),
           itemBuilder: (context, index, realIndex) {
            final urlImage = listofImage![index].path;
            return buildImage(urlImage,index);
          
        },),

        const SizedBox(
          height: 12,

        ),
        buildIndicator()
      ],
    );
  }

}