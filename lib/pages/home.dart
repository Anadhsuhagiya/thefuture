import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thefuture/data/constants.dart';
import 'package:thefuture/widgets/appTitle.dart';
import 'package:thefuture/widgets/dummyCard.dart';
import 'package:thefuture/widgets/made_with.dart';
import 'package:thefuture/widgets/mySearch.dart';
import 'package:thefuture/widgets/onlineStatus.dart';
import 'package:thefuture/widgets/support_us.dart';

import '../data/globals.dart';
import '../models/appDataModel.dart';
import '../services/apiService.dart';
import '../widgets/cardWidget.dart';
import 'chatPage.dart';
import 'myForm.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool isOnline = false;
  Timer? timer;
  List<AppData> appData = [];
  late AnimationController _aniController;
  final TextEditingController chatController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadApps();
    ApiService.serverStatus().then((status) {
      setState(() {
        isOnline = status;
      });
    });

    timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      ApiService.serverStatus().then((status) {
        if (status != isOnline) {
          setState(() {
            isOnline = status;
          });
        }
      });
    });

    _aniController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  void loadApps() async {
    try {
      var data = await ApiService.getApps(limit: 5);
      setState(() {
        appData = data;
      });
      if (kDebugMode) {
        print(appData);
      }
    } catch (err) {
      if (kDebugMode) {
        print("Home error: $err");
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _aniController!.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: kBackGroundColor,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: AppTitle(),
          actions: [onlineStatus(isOnline)],
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('images/bg.jpg'),
                fit: BoxFit.fitHeight,
              )),
            ),
            Positioned.fill(
                child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            )),
            Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text("This is AI Bot Ask Any Thing...",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: kWhite,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                MySearchBar(
                  chatController: chatController,
                  hintText: "Ask Anything You Want...",
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        _aniController
                            .forward()
                            .then((value) => _aniController.reset());

                        if (openai && isAPIValidated == false) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text('Enter a valid API Key'),
                              backgroundColor: kRed,
                              duration: Duration(seconds: 1),
                            ),
                          );
                        } else if (!isOnline) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                  'Server is Down 🔻. Please, try again later!!'),
                              backgroundColor: kGrey,
                              duration: Duration(seconds: 1),
                            ),
                          );
                        } else if (chatController.text.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                queryController: chatController.text,
                                isFormRoute: false,
                              ),
                            ),
                          ).then((value) => chatController.clear());
                        } else if (chatController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              width: 200,
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                'Please write something',
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                              backgroundColor: kGrey,
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }

                        FocusScope.of(context).unfocus();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color: kBlack,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: RotationTransition(
                            turns: Tween(begin: 0.0, end: 1.5)
                                .animate(_aniController!),
                            child: SvgPicture.asset(
                              'images/openai.svg',
                              color: Colors.white,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  onComplete: () {},
                  onChanged: () {},
                ),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child: Text(
                                  "Topics For You",
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: kWhite,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold)),
                                ),
                              )
                            ],
                          ),
                          appData.isEmpty
                              ? dummy_cards()
                              : GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: cardAspectRatio,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            itemCount: appData.length,
                                  itemBuilder: (context, index) {
                                    final data = appData[index];
                                    return CardWidget(
                                      id: data.id,
                                      data: data,
                                      pageRoute: MyForm(id: data.id, title: data.title),
                                    );
                                  },
                                ),
                          const SizedBox(
                            height: 20,
                          ),

                          SupportUs(),
                          MadeWith()
                        ],
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
