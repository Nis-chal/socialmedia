import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmedia/repository/ProfileRepository.dart';

import '../utils/url.dart';

class Following extends StatelessWidget {
  String username, profilePicture, followingid, userid;
  bool isedit;
  VoidCallback increasefollowing;
  VoidCallback decreasefollowing;

  Following(this.username, this.profilePicture, this.followingid, this.userid,
      this.isedit, this.increasefollowing, this.decreasefollowing,
      {Key? key})
      : super(key: key);

  RxBool isfollow = true.obs;

  _unfollowUser() async {
    ProfileRepository profileRepository = ProfileRepository();
    bool? unfollow = await profileRepository.unfollowuser(followingid);
    if (unfollow!) {
      isfollow.value = false;
      decreasefollowing();
    }
  }

  _followUser() async {
    ProfileRepository profileRepository = ProfileRepository();
    bool? unfollow = await profileRepository.followuser(followingid);
    if (unfollow!) {
      isfollow.value = true;
      increasefollowing();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(baseUr + profilePicture),
        ),
        Text(username),
        isedit
            ? Obx(() => ElevatedButton(
                  onPressed: () {
                    if (isfollow.value) {
                      _unfollowUser();
                    } else {
                      _followUser();
                    }
                  },
                  child: isfollow.value ? Text('unfollow') : Text('follow'),
                  style: ElevatedButton.styleFrom(
                      primary: isfollow.value
                          ? Colors.blue.shade600
                          : Colors.grey.shade100,
                      onPrimary: isfollow.value ? Colors.white : Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 8)),
                ))
            : const Visibility(child: SizedBox())
      ],
    );
    ;
  }
}
