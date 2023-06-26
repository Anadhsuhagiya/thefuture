import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:thefuture/data/constants.dart';
import 'package:thefuture/pages/home.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> with SingleTickerProviderStateMixin{

  late AnimationController _Controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Controller = AnimationController(vsync: this, duration: Duration(seconds: 3));
    _Controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return Home();
          },
        ));
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _Controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCodeBgColor,
      body: Center(
        child: Lottie.network(
          'https://assets1.lottiefiles.com/packages/lf20_i1GiktPw9N.json',
          controller: _Controller,
          repeat: true,
          width: 270,
          onLoaded: (composition) {
            _Controller.duration = composition.duration;
            _Controller.forward();
          },
        ),
      ),
    );
  }
}
