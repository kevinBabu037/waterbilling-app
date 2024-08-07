import 'package:flutter/material.dart';

kNavigationPush(BuildContext context,Widget screen){
  Navigator.push(context, MaterialPageRoute(builder: (context) =>screen,));
}

kNavigationPushReplacement(BuildContext context,Widget screen){
 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>screen,));
}

kNavigationPushRemoveUntil(BuildContext context,Widget screen){
 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>screen,), (route) => false);
}

kNavigationPop(BuildContext context){
  Navigator.pop(context);
}


