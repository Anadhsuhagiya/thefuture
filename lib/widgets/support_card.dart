import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'frostedGlass.dart';

class SupportCard extends StatelessWidget {
  final String title;
  final String disc;
  final String imgSrc;
  final Color color;

  const SupportCard({
    super.key,
    required this.title,
    required this.disc,
    required this.imgSrc,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: FrostedGlass(
        widget: Container(
          color: Colors.white.withOpacity(0.4),
          height: 140,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  imgSrc,
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      disc,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}