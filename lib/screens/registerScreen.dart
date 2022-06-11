import 'package:flutter/material.dart';
import 'package:socialmedia/components/roundedbtn.dart';
import 'package:socialmedia/screens/loginScreen.dart';
import 'package:socialmedia/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:motion_toast/motion_toast.dart';
import 'package:socialmedia/models/User.dart';
import 'package:socialmedia/repository/UserRepository.dart';



class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool showSpinner = false;
  

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();
  final _locationController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();


  _displayMessage(msg){
    if(msg){
      MotionToast.success(description: Text('success register')).show(context);
    }else{
      MotionToast.warning(description: Text('error register')).show(context);
    }

  }

  _registerUser(User user) async{
    bool isLogin = await UserRepository().registerUser(user);
    if(isLogin){
      _displayMessage(true);

    }else{
      _displayMessage(false);
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
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                     SizedBox(
                      height: 88.0,
                    ),
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
                      keyboardType: TextInputType.emailAddress,
                          
                      controller: _nameController,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                          
                      controller: _usernameController,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your username'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      },
                    ),
                  
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                          
                      controller: _emailController,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your email'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                          
                      controller: _locationController,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your location'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter location';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                          
                      controller: _passwordController,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your password'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    RoundedButton(
                      title: 'Register',
                      colour: Color(0xFF363636),
                      onPressed: () {
                          
              
                        if (_formKey.currentState!.validate()) {
                          User user = User(
                            name: _nameController.text,
                            username: _usernameController.text,
                            email: _emailController.text,
                            location: _locationController.text,
                           
                            password: _passwordController.text,
                          );
                          
                          _registerUser(user);
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Already have a account ",
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        GestureDetector(
                          child: Text(
                            ' login',
                            textAlign: TextAlign.end,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
              
                            Navigator.pushNamed(context, LoginScreen.id);
                           
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
      ),
    );
  }
}
