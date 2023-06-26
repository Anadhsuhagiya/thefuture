import 'package:flutter/widgets.dart';
import 'package:thefuture/data/globals.dart';
import 'package:thefuture/widgets/MessageLoading.dart';

import 'UserMessage.dart';
import 'ai_message.dart';

class Message extends StatelessWidget {
  const Message({super.key, required this.text, required this.sender});

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: sender == 'user' ? UserMessage(sender, text) : AiMessage(text: text.trim())
    );
  }
}
