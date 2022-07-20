import 'dart:io';

import 'package:socialmedia/api/profileapi.dart';
import 'package:socialmedia/response/profileResponse/ProfileResponse.dart';
import 'package:socialmedia/response/profileResponse/ProfileSearchResponse.dart';

class ProfileRepository {
  Future<ProfileResponse?> userProfile(String profileid) async {
    return ProfileApi().userProfile(profileid);
  }

  Future<ProfileSearchResponse?> profileSearch(String username) async {
    return ProfileApi().profileSearch(username);
  }

  Future<bool?> followuser(String userid) async {
    return ProfileApi().followUser(userid);
  }

  Future<bool?> unfollowuser(String userid) async {
    return ProfileApi().unfollowUser(userid);
  }

   Future<bool?> removeFollower(String followerid) async {
    return ProfileApi().removeFollower(followerid);
  }

  Future<bool?> updateUser({
    String? username,
    String? name,
    String? location,
    File? fimage,
    String? nimage,
    String? email,
    String? userid,
  }) async {
    return ProfileApi().updateProfile(
      username: username,
      name: name,
      location: location,
      fimage: fimage,
      nimage: nimage,
      email: email,
      userid: userid,
    );
  }
}
