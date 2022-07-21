// import 'package:flutter/material.dart';
// import 'package:socialmedia/models/User.dart';
// import 'package:socialmedia/repository/ProfileRepository.dart';
// import 'package:socialmedia/response/profileResponse/ProfileSearchResponse.dart';
// import 'package:socialmedia/utils/url.dart';

// // ignore: must_be_immutable
// class SearchContainer extends StatelessWidget {
//   String? search;
//   VoidCallback? goto;
//   SearchContainer(this.search,this.goto, {Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<ProfileSearchResponse?>(
//         future: ProfileRepository().profileSearch(search!),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.data != null) {
//               List<User> userinfo = snapshot.data!.users!;
//               return SingleChildScrollView(
//                 child: Container(
//                     color: Colors.white,
//                     height: 500 - 56,
//                     child: ListView.builder(
//                       itemCount: userinfo.length,
//                       itemBuilder: ((context, index) {
//                         return ElevatedButton(
//                           onPressed: goto!(userinfo[index].id!),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 2),
//                             child: Row(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundImage: NetworkImage(
//                                       '$baseUr${userinfo[index].profilePicture}'),
//                                 ),
//                                 const SizedBox(
//                                   width: 4,
//                                 ),
//                                 Column(
//                                   children: [
//                                     Text(userinfo[index].username!,
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.bold)),
//                                     Text(userinfo[index].name!)
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         );
//                       }),
//                     )),
//               );
//             } else {
//               return const Center(
//                 child: Text("No data"),
//               );
//             }
//           } else if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//               ),
//             );
//           }
//         });
//   }
// }
