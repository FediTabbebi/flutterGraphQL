
import 'package:flutter/material.dart';

class AlertDialogFb1 extends StatelessWidget {
  final String title;
  final String description;

  final List<TextButton> actions;

  const AlertDialogFb1({required this.title, required this.description, required this.actions, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:const Color(0xff151515) ,
      title: Center(child: Text(title,style: const TextStyle(color: Color(0xffDB9200),),)),
      content:
          Text(description,style: const TextStyle(color: Colors.white),textAlign: TextAlign.center,),
      actions: actions,
    );
  }
}