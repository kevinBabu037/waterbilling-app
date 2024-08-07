import 'package:flutter/material.dart';

kSnakBar(BuildContext context,String content,Color clr){
    ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor:Colors.transparent,
              content:Container(
                decoration:BoxDecoration(
                  color: clr, 
                  borderRadius:BorderRadius.circular(5) 
                   ) ,
                height: 40,
                width:double.infinity ,
                child: Center(child: Text(content,style:const TextStyle(fontWeight: FontWeight.bold),)),
              )
            ),
          );
}



kShowDialog(
  {
  required BuildContext context,
  required String title,
  required String contentTxt,
  required String actionBtn1Txt,
  required String actionBtn2Txt,
  required void Function()? onPressed
  }
){
    showDialog(
            context: context,
             builder: (context) {
               return AlertDialog(
                 title: Text(title),
                 content: Text(contentTxt),
                 actions: [
                  TextButton(onPressed: (){
                   Navigator.pop(context);
                  },
                   child: Text(actionBtn1Txt)),
                   TextButton(
                    onPressed:onPressed,
                   child: Text(actionBtn2Txt)),

                 ],
               );
             },
             );
} 


kLodingSnackbar(BuildContext context){
   ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
           content: Row(
             children:  [
               CircularProgressIndicator(),
               SizedBox(width: 20),
               Text('Logging in...'),
             ],
           ),
         ),
       );
}

void kHideLoadingSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
}