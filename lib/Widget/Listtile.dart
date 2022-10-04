import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListileWidget extends StatelessWidget {
  final String text;
   
  const ListileWidget({
  required this.text,
    Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;
  
    return ListTile(
                title:Text(text, style:GoogleFonts.nunito(color: color),),
    );
  }
}
