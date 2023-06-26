import 'package:flutter/cupertino.dart';

import '../data/constants.dart';

class MadeWith extends StatelessWidget {
  const MadeWith({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 100, bottom: 50),
        child: Text.rich(
          style: const TextStyle(
            color: kWhite,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
          TextSpan(
            text: 'Made with ',
            children: [

              const TextSpan(text: ' by ∆nadh in 🇮🇳'),
            ],
          ),
        ),
      ),
    );
  }
}