import 'package:flutter/material.dart';
import './responsive_layout.dart';
import '../wearhouse/WearLoginScreen.dart';
import '../screens/loginScreen.dart';

class LoginLayout extends StatelessWidget {
  const LoginLayout({Key? key}) : super(key: key);
  static const String id = 'loginLayout';


  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(watchBody: WearLoginScreen(), mobileBody: LoginScreen());
  }
}