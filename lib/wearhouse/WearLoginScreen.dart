import 'package:flutter/material.dart';
import 'package:socialmedia/responsive/feed_layout.dart';
import '../constants.dart';
import 'package:motion_toast/motion_toast.dart';
import '../repository/UserRepository.dart';
import '../models/User.dart';
import '../screens/navigationdrawer.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:socialmedia/components/roundedbtn.dart';

class WearLoginScreen extends StatefulWidget {
  WearLoginScreen({Key? key}) : super(key: key);

  @override
  State<WearLoginScreen> createState() => _WearLoginScreenState();
}

class _WearLoginScreenState extends State<WearLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  _login(User user) async {
    try {
      UserRepository userRepository = UserRepository();
      bool isLogin = await userRepository.login(user);
      if (isLogin) {
        _navigateToScreen(true);
      } else {
        _navigateToScreen(false);
        MotionToast.warning(description: Text('error login')).show(context);
      }
    } catch (e) {
      print(e);
    }
  }

  _navigateToScreen(bool isLogin) {
    if (isLogin) {
      Navigator.pushReplacementNamed(context, FeedLayout.id);
    } else {
      MotionToast.error(description: const Text('Enter user or passowrd'))
          .show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset('assets/images/camera.png'),
                  ),
                ),
                SizedBox(
                  height: 20,
                  child: Image.asset('assets/images/Winkle.png'),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  style: TextStyle(fontSize: 10.0),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.left,
                  decoration: kWTextFieldDecoration.copyWith(
                      hintText: 'Enter your email'),
                ),
                SizedBox(
                  height: 4.0,
                ),
                TextFormField(
                  style: TextStyle(fontSize: 10.0),
                  controller: _passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,

                  // textAlign: TextAlign.center,

                  decoration: kWTextFieldDecoration.copyWith(
                      hintText: 'Enter your password'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Material(
                    elevation: 5.0,
                    color: Color(0xFF363636),
                    borderRadius: BorderRadius.circular(30.0),
                    child: SizedBox(
                      height: 28.0,
                      child: MaterialButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            User user = User(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );

                            _login(user);
                          }
                        },
                        minWidth: 100.0,
                        height: 8.0,
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
