import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'InfoCard.dart';
import 'frostedGlass.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) {
              return const FrostedGlass(
                widget: InfoCard(),
              );
            },
          ),
          child: Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Image.asset('images/innovation.png',height: 20,color: Colors.white,),
              SizedBox(
                width: 9,
              ),
              Text(
                "The Future",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
              )
            ],
          ),
        )
      ],
    );
  }
}
