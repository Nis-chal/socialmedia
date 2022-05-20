import 'package:flutter/material.dart';

import 'package:socialmedia/screens/loginScreen.dart';
import 'package:socialmedia/screens/registerScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // theme: ThemeData.dark(),
      initialRoute: LoginScreen.id,

      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        
      },
    );
  }
}
