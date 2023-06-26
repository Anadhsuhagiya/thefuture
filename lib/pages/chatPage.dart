import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thefuture/widgets/message.dart';
import 'package:thefuture/widgets/mySearch.dart';

import '../data/constants.dart';
import '../data/globals.dart';
import '../data/secrets.dart';
import '../models/MessageModel.dart';
import '../services/apiService.dart';
import '../widgets/indicator.dart';
import '../widgets/typingAnimation.dart';

class ChatScreen extends StatefulWidget {
  final String? queryController;
  bool isFormRoute;

  ChatScreen(
      {Key? key, required this.queryController, required this.isFormRoute})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
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
      typing = true;
      widget.isFormRoute = false;
    });
    fetchData(query);
  }

  Future<void> fetchData(String qry) async {
    try {
      final String key = openai ? apiKey! : devApiKey!;
      String fetchRes = await ApiService.fetchApi(key, qry);
      print("key === $key");
      print("response message ==== $fetchRes");
      setState(() {
        _isTyping = false;
        typing = false;
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
        backgroundColor: kBlack.withOpacity(0.3),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'The Future',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(fontWeight: FontWeight.w600)),
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
        actions: [
          InkWell(
              onTap: () {
                showDialog(
                  barrierColor: kBlack.withOpacity(0.9),
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: kCodeBgColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      title: Text(
                        "Clear this Chat ?",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: kWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ),
                      content: Text(
                        "This action can not be undone",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(color: kWhite, fontSize: 14)),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              msgList.clear();
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Clear',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            )),
                      ],
                    );
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(
                  'images/delete.png',
                  width: 20,
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              reverse: true,
              physics: BouncingScrollPhysics(),
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              itemCount: msgList.length,
              itemBuilder: (context, index) {
                return Message(
                    text: msgList[index].text, sender: msgList[index].sender);
              },
            ),
          ),

          SizedBox(height: 16,),

          MySearchBar(chatController: newQueryController, hintText: "Ask Anything you want...", suffixIcon: Padding(padding: EdgeInsets.all(8),
          child: InkWell(
            onTap: () {
              HapticFeedback.heavyImpact();
              _aniController.forward().then((value) => _aniController.reset());
              if (newQueryController.text.isNotEmpty && !_isTyping) {
                sendMessage(newQueryController.text);
                newQueryController.clear();
              }
              FocusScope.of(context).unfocus();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23),
                color: _isTyping ? kGrey : kBlack,
              ),
              child: Padding(padding: EdgeInsets.all(6),
              child: RotationTransition(turns: Tween(begin: 0.0,end: 1.5).animate(_aniController),child: SvgPicture.asset('images/openai.svg',color: kWhite,width: 30,),),),
            ),
          ),), onComplete: () {

          }, onChanged: () {

          },),

          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
