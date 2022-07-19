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
}
