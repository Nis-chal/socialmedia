import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socialmedia/components/roundedbtn.dart';

import '../constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import './registerScreen.dart';
import './navigationdrawer.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:socialmedia/models/User.dart';
import 'package:socialmedia/repository/UserRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

   @override
  void initState() {
    super.initState();
    _autoLogin();
  }

  _autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
      final String? token = (prefs.getString('token') ?? '');

      if(token!.isNotEmpty){
        Navigator.pushNamed(context, NavigationDrawer.id);


      }
      

    
  }
  _login(User user) async{
    try{
      UserRepository userRepository = UserRepository();
      bool isLogin = await userRepository.login(user);
      if(isLogin){
        _navigateToScreen(true);
      }else{
        _navigateToScreen(false);
        MotionToast.warning(description: Text('error login')).show(context);
      }

    }catch(e){

    }
  }

  _navigateToScreen(bool isLogin){
    if(isLogin){
      Navigator.pushNamed(context, NavigationDrawer.id);
    }
    else{
      MotionToast.error(description: const Text('Enter user or passowrd')).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 70,
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset('assets/images/camera.png'),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Image.asset('assets/images/Winkle.png'),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  // Image.asset('assets/images/download.jpg'),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.left,
                  
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your email'),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,

            
                    // textAlign: TextAlign.center,
                   
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your password'),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    title: 'Log In',
                    colour: Color(0xFF363636),
                    onPressed: () {
                       if (_formKey.currentState!.validate()) {
                      User user = User(
                        email: _emailController.text,
                       
                        password: _passwordController.text,
                      );

                      _login(user);
                    }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Dont't have account ",
                        textAlign: TextAlign.end,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      GestureDetector(
                        child: Text(
                          ' Register',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, RegisterScreen.id);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
