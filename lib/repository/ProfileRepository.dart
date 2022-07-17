import 'package:socialmedia/api/profileapi.dart';
import 'package:socialmedia/response/profileResponse/ProfileResponse.dart';

class ProfileRepository{
  Future<ProfileResponse?>userProfile(String profileid)async{
    return ProfileApi().userProfile(profileid);
  }
}