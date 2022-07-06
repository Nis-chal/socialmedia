import 'package:flutter/material.dart';



class ResponsiveLayout extends StatelessWidget {
  final Widget watchBody;
  final Widget mobileBody;
  

  ResponsiveLayout({required this.watchBody,required this.mobileBody});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      if(constraints.maxWidth  < 370 ){
        return watchBody;

      }else{
        return mobileBody;

      }
    });
  }
}