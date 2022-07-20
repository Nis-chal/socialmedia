import 'package:flutter/material.dart';
import 'package:socialmedia/repository/ProfileRepository.dart';
import 'package:socialmedia/response/profileResponse/ProfileResponse.dart';

class Followerlist extends StatelessWidget {
  final String profileid;
  const Followerlist(this.profileid, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProfileResponse?>(
        future: ProfileRepository().userProfile(profileid),
        builder: (((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              ProfileResponse? profile = snapshot.data!;
              return Column(
                children: [
                  ListView.builder(
                    itemCount: profile.followers!.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                profile.followers![index].profilePicture!),
                          ),
                          Text(profile.followers![index].username!),
                          ElevatedButton(
                              onPressed: () {}, child: Text('unfollow'))
                        ],
                      );
                    },
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('No data'),
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
        })));
  }
}
