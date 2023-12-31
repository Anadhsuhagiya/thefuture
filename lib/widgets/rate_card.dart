import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thefuture/widgets/support_card.dart';

import '../data/constants.dart';

class RateCard extends StatefulWidget {
  const RateCard({super.key});

  @override
  State<RateCard> createState() => _RateCardState();
}

class _RateCardState extends State<RateCard> {
  double _rating = 4.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: kBlack,
              title: const Text(
                "Rate Us",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                    color: kWhite
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RatingBar.builder(
                    minRating: 1,
                    initialRating: _rating,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    unratedColor: Colors.grey[400],
                    itemCount: 5,
                    itemSize: 40.0,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                    updateOnDrag: true,
                  ),
                  const SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: kGrey,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: kRadiumGreen,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                              "Thank you for giving us $_rating ⭐",style: GoogleFonts.montserrat(textStyle: TextStyle()),
                          ),
                        ),);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
      child: const SupportCard(
        title: "Rate Us",
        disc: "Review on PlayStore",
        imgSrc: "images/rating.png",
        color: kSupportCard2,
      ),
    );
  }
}