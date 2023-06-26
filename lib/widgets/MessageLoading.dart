import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../data/constants.dart';

class msgLoading extends StatelessWidget {
  const msgLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 30,
          width: 30,
          margin: EdgeInsets.symmetric(vertical: 6),
          child: CircleAvatar(
            backgroundColor: kWhite.withOpacity(0.7),
            child: Image.asset(
              'images/innovation.png',
              width: 15,
            ),
          ),
        ),
        Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            color: kAiMsgBg,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16)),
          ),
          alignment: Alignment.center,
          margin: const EdgeInsets.all(8),
          child: SpinKitThreeInOut(
            color: kBlack,
            size: 18,
          )
        ),
      ],
    );
  }
}
