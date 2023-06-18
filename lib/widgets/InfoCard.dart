import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/constants.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kWhite.withOpacity(0.8),
      title: Image.asset('images/innovation.png',height: 20,color: Colors.white,),
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: ,
              )
            ],
          )
        ],
      ),
    );
  }
}
