import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/constants.dart';
import 'frostedGlass.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar(
      {Key? key,
        required this.chatController,
        required this.hintText,
        required this.suffixIcon,
        required this.onComplete,
        required this.onChanged})
      : super(key: key);

  final TextEditingController chatController;
  final String hintText;
  final Widget suffixIcon;
  final VoidCallback onComplete;
  final VoidCallback onChanged;
  static const double borderWidth = 3.0;

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: FrostedGlass(
        widget: TextField(
          cursorColor: kAiMsgBg,
          maxLines: 4,
          minLines: 1,
          style:  GoogleFonts.montserrat(textStyle: TextStyle(
            fontSize: 18,
            color: kWhite,
            fontWeight: FontWeight.w500,
          ),),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(width: 3, color: kAiMsgBg),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(width: 3, color: kAiMsgBg),
            ),
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: kWhite,fontSize: 14),
            filled: true,
            fillColor: kBlack.withOpacity(0.5),
            suffixIcon: widget.suffixIcon,
          ),
          controller: widget.chatController,
          textInputAction: TextInputAction.search,
          onEditingComplete: () {
            widget.onComplete();
            FocusScope.of(context).unfocus();
          },
          onChanged: (val) {
            widget.onChanged();
          },
        ),
      ),
    );
  }
}