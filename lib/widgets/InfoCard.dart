import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/constants.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  _launchUrl(String url) async {
    try {
      await launchUrl(Uri.parse(url),
          mode: LaunchMode.externalNonBrowserApplication);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: kWhite.withOpacity(0.6),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/innovation.png',height: 20,),
          SizedBox(width: 10,),
          Text("The Future",style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15)),)
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _launchUrl('https://github.com/Anadhsuhagiya/thefuture'),
                child: Image.asset('images/github.png',height: 30,),
              ),
              const SizedBox(
                width: 16,
              ),
              GestureDetector(
                onTap: () => _launchUrl(
                    'https://www.linkedin.com/in/anadh-suhagiya-567361229/'),
                child: Image.asset('images/linkedin.png',height: 30,),
              )
            ],
          ),
           SizedBox(
            height: 15,
          ),
           Text(
            '  © All Rights Reserved',
            style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.bold),)
          )
        ],
      ),
    );
  }
}
