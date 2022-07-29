import 'package:socialmedia/response/shortsResponse/ShortsResponse.dart';
import 'package:socialmedia/api/shortsapi.dart';

class ShortsRepository{


   Future<ShortsResponse?> getShorts() async {
    return SHORTSAPI().getshorts();
  }
}