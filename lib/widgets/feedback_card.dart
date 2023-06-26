import 'package:flutter/cupertino.dart';
import 'package:thefuture/widgets/support_card.dart';
import 'package:wiredash/wiredash.dart';

import '../data/constants.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Wiredash.of(context).show();
      },
      child: const SupportCard(
        title: "Feedback",
        disc: "Feature Request, Issue, Suggestions or Anything",
        imgSrc: "images/feedback.png",
        color: kSupportCard3,
      ),
    );
  }
}