import 'package:flutter/cupertino.dart';
import 'package:thefuture/widgets/rate_card.dart';
import 'package:thefuture/widgets/share_card.dart';

import '../data/constants.dart';
import 'feedback_card.dart';

class SupportUs extends StatelessWidget {
  const SupportUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Support Us",
            style: TextStyle(
              color: kWhite,
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            RateCard(),
          ],
        ),
      ],
    );
  }
}