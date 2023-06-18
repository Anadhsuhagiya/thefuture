import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/constants.dart';

class TypingAnimation extends StatelessWidget {
  const TypingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 30,
          child: SpinKitThreeInOut(
            color: kRadiumGreen,
            size: 15,
          ),
        ),
        SizedBox(width: 10,),
        Text(
          'typing',
          style: GoogleFonts.montserrat(textStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: kRadiumGreen)),
        )
      ],
    );
  }
}