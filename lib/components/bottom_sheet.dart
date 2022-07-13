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
      height: 300,
      decoration:const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))),
      child: Column(children: [

        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue,shadowColor: Colors.transparent),
                onPressed: (){},
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
    return buildBottom(onClicked: ()=>showModalBottomSheet(context: context,backgroundColor: Colors.transparent,  builder: (BuildContext context)=>buildSheet()));
  }
}