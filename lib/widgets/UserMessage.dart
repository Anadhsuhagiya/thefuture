import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thefuture/data/constants.dart';

class UserMessage extends StatelessWidget {

  String sender;
  String text;

  UserMessage(this.sender, this.text);


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Flexible(
        child: Container(
          decoration: BoxDecoration(
            color: kUsrMsgBg,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
          margin: EdgeInsets.all(8),
          child: Text(text,overflow: TextOverflow.fade, style: GoogleFonts.montserrat(textStyle: TextStyle(color: kWhite,fontSize: 16,)),),
        ),
      ),
    );
  }
}
