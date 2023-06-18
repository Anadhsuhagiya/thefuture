import 'package:flutter/material.dart';
import 'package:thefuture/data/constants.dart';
import 'package:thefuture/widgets/appTitle.dart';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kBackGroundColor,

      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: AppTitle(),
      ),
    );
  }
}
