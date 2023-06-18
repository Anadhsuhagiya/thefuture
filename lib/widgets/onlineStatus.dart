import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'indicator.dart';

class onlineStatus extends StatefulWidget {
  bool isOnline;

  onlineStatus(this.isOnline);

  @override
  State<onlineStatus> createState() => _onlineStatusState();
}

class _onlineStatusState extends State<onlineStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 90,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
          color: Colors.black38, borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.isOnline ? "Online" : "Offline",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),

          ),
          const SizedBox(
            width: 8,
          ),
          Indicator(status: widget.isOnline)
        ],
      ),
    );
  }
}
