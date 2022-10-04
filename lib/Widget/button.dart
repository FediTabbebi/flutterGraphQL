import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;


  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left:10,right:10),
    child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onClicked,
          child: 
          Text(
             text,
            style: GoogleFonts.nunito(color: Colors.black, fontSize: 17.5),
           ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xffDB9200),
            ),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0))),
          ),
        )),
  );
}
