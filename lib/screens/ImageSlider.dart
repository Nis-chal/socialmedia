import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:socialmedia/utils/url.dart';

class ImageSlider extends StatefulWidget {
  @override
  State<ImageSlider> createState() => _ImageSliderState();
  List<String>? listofImage;
  ImageSlider({required this.listofImage});
}

class _ImageSliderState extends State<ImageSlider> {
  int activeIndex = 0;

  Widget buildImage(String urlImage, int index) => Container(
        color: Colors.grey,
        child: Image.network(
          '$baseUr$urlImage',
          fit: BoxFit.cover,
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.listofImage!.length,
        effect: JumpingDotEffect(
            dotWidth: 10,
            dotHeight: 10,
            activeDotColor: Colors.red,
            dotColor: Colors.black12),
      );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.listofImage!.length,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.55,
            aspectRatio: 2.0,
            // pageSnapping: false,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            viewportFraction: 1,
            onPageChanged: (index, reason) =>
                setState(() => activeIndex = index),
          ),
          itemBuilder: (context, index, realIndex) {
            final urlImage = widget.listofImage![index];
            return buildImage(urlImage, index);
          },
        ),
        const SizedBox(
          height: 12,
        ),
        buildIndicator()
      ],
    );
  }
}
