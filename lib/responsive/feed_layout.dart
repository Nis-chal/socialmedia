import 'package:flutter/material.dart';
import './responsive_layout.dart';
import '../wearhouse/WearFeedScreen.dart';
import '../screens/FeedScreen.dart';

class FeedLayout extends StatelessWidget {
  const FeedLayout({Key? key}) : super(key: key);
  static const String id = 'FeedLayout';


  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(watchBody: WearFeedScreen(), mobileBody: FeedScreen());
  }
}