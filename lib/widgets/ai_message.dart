import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thefuture/data/constants.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:thefuture/data/globals.dart';
import 'package:thefuture/widgets/MessageLoading.dart';

class AiMessage extends StatelessWidget {
  const AiMessage({
    super.key,
    required this.text,
  });

  final String text;

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
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: kAiMsgBg,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            margin: const EdgeInsets.all(8),
            child: Markdown(
              padding: EdgeInsets.zero,
              selectable: true,
              physics: NeverScrollableScrollPhysics(),
              styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                  .copyWith(
                      p: GoogleFonts.baloo2(
                          textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                      code: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 14,
                              color: kBlack,
                              backgroundColor: kTransparent)),
                      codeblockDecoration: BoxDecoration(
                          color: kBlack.withOpacity(0.4),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                              bottomRight: Radius.circular(16)),
                          border: Border.all(color: kGreen, width: 1))),
              extensionSet: md.ExtensionSet(
                md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                [
                  md.EmojiSyntax(),
                  md.CodeSyntax(),
                  md.ColorSwatchSyntax(),
                  ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
                ],
              ),
              data: text,
              shrinkWrap: true,
            ),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap:() {
                Clipboard.setData(
                  ClipboardData(text: text),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    behavior: SnackBarBehavior.floating,
                    content: Text('Answer Copied Successfully',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),),
                    backgroundColor: kGreen,
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              child: const Icon(
                Icons.copy_rounded,
                size: 24,
                color: kWhite,
              ),
            ))
      ],
    );
  }
}
