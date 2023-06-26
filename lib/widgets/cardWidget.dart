import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/constants.dart';
import '../data/icons.dart';
import '../models/appDataModel.dart';
import 'frostedGlass.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.data,
    required this.pageRoute,
    required this.id,
  }) : super(key: key);

  final AppData data;
  final Widget pageRoute;
  final String id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          // shape: ,
          backgroundColor: kBlack.withOpacity(0.6),
          useSafeArea: true,
          context: context,
          builder: (context) => FrostedGlass(widget: pageRoute),
        );
      },
      child: FrostedGlass(widget: Container(
        decoration: BoxDecoration(color: Color(int.parse(data.color.toString())).withOpacity(0.7)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: kBackGroundColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(30),
              ),
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  icons[data.icon],
                  size: 25,
                  color: kRadiumGreen,
                ),
              ),
            ),
            
            Padding(padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: GoogleFonts.montserrat(textStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.w600,
                    ),)
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    data.disc,
                    style: GoogleFonts.montserrat(textStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: kBlack.withOpacity(0.54),
                    ),)
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
