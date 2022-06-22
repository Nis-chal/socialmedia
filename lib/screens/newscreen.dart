// import 'package:flutter/material.dart';
// class PostSlider extends StatefulWidget {
//   PostSlider({Key? key}) : super(key: key);

//   @override
//   State<PostSlider> createState() => _PostSliderState();
// }

// class _PostSliderState extends State<PostSlider> {

//  Widget caresoel() {

//       return Caresoul(context);

//     }
//   @override
//   Container Caresoul(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           CarouselSlider(
//             options: CarouselOptions(
//                 height: 150,
//                 aspectRatio: 2.0,
//                 enlargeCenterPage: true,
//                 viewportFraction: 1,
//                 onPageChanged: (index, carouseLReason) {
//                   setState(() {
//                     _current = index;
//                   });
//                 }),
//             items: imgList
//                 .map((item) => Container(
//                       child: Container(
//                         margin: EdgeInsets.all(5.0),
//                         child: ClipRRect(
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(9.0)),
//                             child: Stack(
//                               children: <Widget>[
//                                 Image.network(item,
//                                     fit: BoxFit.fitWidth, width: 500.0),
//                                 Positioned(
//                                   bottom: 0.0,
//                                   left: 0.0,
//                                   right: 0.0,
//                                   child: Container(
//                                     decoration: const BoxDecoration(
//                                       gradient: LinearGradient(
//                                         colors: [
//                                           Color.fromARGB(197, 255, 255, 255),
//                                           Color.fromARGB(0, 0, 0, 0)
//                                         ],
//                                         begin: Alignment.bottomCenter,
//                                         end: Alignment.topCenter,
//                                       ),
//                                     ),
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 10.0, horizontal: 20.0),
//                                     child: const Text(
//                                       '',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 20.0,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             )),
//                       ),
//                     ))
//                 .toList(),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: imgList.asMap().entries.map((entry) {
//               return GestureDetector(
//                 onTap: () => _controller.animateToPage(entry.key),
//                 child: Container(
//                   width: 12.0,
//                   height: 12.0,
//                   margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
//                   decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: (Theme.of(context).brightness == Brightness.dark
//                               ? Colors.white
//                               : Colors.black)
//                           .withOpacity(_current == entry.key ? 0.9 : 0.4)),
//                 ),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
