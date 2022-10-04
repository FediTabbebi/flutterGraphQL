
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TextFieldWidget extends StatelessWidget {
  final String hint;
  final String? Function(String?)? validator;
  final ValueChanged<String> onChanged;
  final Icon icon;
   

   const TextFieldWidget({
    Key? key,
  required this.hint,
   required this.icon,
   required this.onChanged,
   required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) { 
     return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          style: GoogleFonts.nunito(color: Colors.white),
           validator: validator,
          cursorColor:const Color(0xffDB9200),
         decoration: InputDecoration(
           contentPadding: const EdgeInsets.symmetric(vertical: 20),
          filled: true,
           errorStyle: const TextStyle(color:Color(0xffDB9200),),
          fillColor: const Color(0xff151515),
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
                width: 0, 
                style: BorderStyle.none,
            ),),
            hintStyle: const TextStyle (color: Color.fromARGB(255, 126, 126, 126)),
          hintText:hint, 
          prefixIcon : icon,
        ),
        onChanged: onChanged,
        ),
      );
  }
}