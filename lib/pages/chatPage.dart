import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/constants.dart';
import '../data/globals.dart';
import '../models/MessageModel.dart';
import '../services/apiService.dart';
import '../widgets/indicator.dart';
import '../widgets/typingAnimation.dart';

class ChatScreen extends StatefulWidget {
  final String? queryController;
  bool isFormRoute;

  ChatScreen({Key? key, required this.queryController, required this.isFormRoute})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin{

  List<MessageModel> msgList = [];
  late AnimationController _aniController;
  final TextEditingController newQueryController = TextEditingController();
  bool _isTyping = false;
  final ScrollController _scrollController = ScrollController();

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.minScrollExtent);
  }

  void sendMessage(String query) {
    if (widget.isFormRoute == false) {
      setState(() {
        msgList.insert(0, MessageModel(text: query, sender: 'user'));
      });
    }
    setState(() {
      _isTyping = true;
      widget.isFormRoute = false;
    });
    fetchData(query);
  }

  Future<void> fetchData(String qry) async {
    try {
      final String key = openai ? apiKey! : '';
      String fetchRes = await ApiService.fetchApi(key, qry);

      setState(() {
        _isTyping = false;
        msgList.insert(0, MessageModel(text: fetchRes, sender: 'AI'));
      });
    } catch (e) {
      if (kDebugMode) {
        print("Chat Screen error: $e");
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _aniController.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.queryController!.isNotEmpty) {
      sendMessage(widget.queryController!);
    }
    _aniController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kChatBackGround,
      appBar: AppBar(
        foregroundColor: kWhite,
        backgroundColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
              children: [
                Text(
                  'The Future',
                  style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  width: 16,
                ),
                Indicator(status: true)
              ],
            ),
            _isTyping ? const TypingAnimation() : Container(),
          ],
        ),
      ),
    );
  }
}
