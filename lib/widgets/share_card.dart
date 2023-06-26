import 'package:flutter/cupertino.dart';
import 'package:thefuture/widgets/support_card.dart';

import '../data/constants.dart';

class ShareCard extends StatelessWidget {
  const ShareCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {

      },
      child: const SupportCard(
        title: "Share",
        disc: "Tell the World About Us",
        imgSrc: "images/network.png",
        color: kSupportCard1,
      ),
    );
  }
}