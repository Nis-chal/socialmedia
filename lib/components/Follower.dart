import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmedia/repository/PostRepository.dart';
import 'package:socialmedia/repository/ProfileRepository.dart';

import '../utils/url.dart';

class Follower extends StatelessWidget {
  String username, profilePicture, followerid, userid;
  bool isedit;

  Follower(this.username, this.profilePicture, this.followerid, this.userid,
      this.isedit,
      {Key? key})
      : super(key: key);

  RxBool isdelete = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Visibility(
          visible: !isdelete.value ? false : true,
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(baseUr + profilePicture),
              ),
              Text(username),
              isedit
                  ? ElevatedButton(
                      onPressed: () async {
                        ProfileRepository profileRepository =
                            ProfileRepository();
                        bool? removed =
                            await profileRepository.removeFollower(followerid);
                        isdelete.value = true;
                      },
                      child: Text('Remove'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.grey.shade100,
                          onPrimary: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 8)),
                    )
                  : const Visibility(
                      visible: false,
                      child: SizedBox(),
                    )
            ],
          ),
        ));

    ;
  }
}
