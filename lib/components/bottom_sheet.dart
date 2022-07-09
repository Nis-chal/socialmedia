import 'package:flutter/material.dart';
import 'package:socialmedia/constants.dart';
class BottomTab extends StatelessWidget {
  String?text;

  VoidCallback? onClicked;
  BottomTab({Key? key}): super(key: key);


  Widget buildBottom({required VoidCallback onClicked}){
    return IconButton(
      onPressed: onClicked, 
      icon: const Icon(Icons.more_vert),

    );
  }

  Widget buildSheet(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0 ,vertical: 10),
      height: 400,
      decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(90),topLeft: Radius.circular(10))),
      child: Column(children: [

        Row(
          
          
          children: [
            Expanded(
              child: Container(
                height: 70,
                width: 100,
            
               
                decoration: BoxDecoration(color: secodaryColor,borderRadius: BorderRadius.all(Radius.circular(7))),
              
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
              
                  Icon(Icons.delete,
                  color: Color(0xFFB1ABAB),
                  ),
                  Text("Delete")
                  ],
                ),
                
              ),
            ),
            SizedBox(
              width: 10,
            ),

            Expanded(
              child: Container(
                height: 70,
                width: 100,
            
               
                decoration: BoxDecoration(color: secodaryColor,borderRadius: BorderRadius.all(Radius.circular(7))),
              
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
              
                  Icon(Icons.edit,
                  color: Color(0xFFB1ABAB),
                  ),
                  Text("Edit")
                  ],
                ),
                
              ),
            )
          ],
        )
        ,
        Column(children: [
            SizedBox(
              height: 10,
            ),
          ElevatedButton(onPressed: (){}, child: Text('view user profile',style: TextStyle(color: Colors.black45),),
          style: ElevatedButton.styleFrom(
            primary: secodaryColor,
            shadowColor: Colors.transparent,
            
            
            minimumSize: Size.fromHeight(40)),),

          ElevatedButton(onPressed: (){}, child: Text('view Comments',style: TextStyle(color: Colors.black45),),
          style: ElevatedButton.styleFrom(
            primary: secodaryColor,
            shadowColor: Colors.transparent,
            
            
            minimumSize: Size.fromHeight(40)),),
             ElevatedButton(onPressed: (){}, child: Text('Save Post',style: TextStyle(color: Colors.black45),),
          style: ElevatedButton.styleFrom(
            primary: secodaryColor,
            shadowColor: Colors.transparent,
            
            
            minimumSize: Size.fromHeight(40)),)
          
        ],)
      ]),
      
    );

  }
  @override
  Widget build(BuildContext context) {
    return buildBottom(onClicked: ()=>showModalBottomSheet(context: context, builder: (BuildContext context)=>buildSheet()));
  }
}