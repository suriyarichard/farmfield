import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfield/pallets/color.dart';
import 'package:farmfield/widgets/trade/callButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TradeCard extends StatefulWidget {
  final String tradeTitle;
  final String phoneNumber;
  final String deatils;
  final GestureTapCallback onTap;
  final Timestamp createdDateAndTime;
  const TradeCard({
    super.key,
    required this.tradeTitle,
    required this.phoneNumber,
    required this.onTap,
    required this.createdDateAndTime,
    required this.deatils,
  });

  @override
  State<TradeCard> createState() => _TradeCardState();
}

class _TradeCardState extends State<TradeCard> {
  String FormattedDate = "N/A";

  @override
  void initState() {
    super.initState();
    formatDate();
  }

  void formatDate() {
    FormattedDate =
        DateFormat('yyyy-MM-dd ').format(widget.createdDateAndTime.toDate());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 325,
      height: 130,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        // color: Colors.amber,
        color: Colors.primaries[Random().nextInt((Colors.primaries.length))],
        // random.nextInt(255),
        // random.nextInt(255),
        // random.nextInt(255),
        // 1,
        // ),
        elevation: 2,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/206/206865.png'),
                          maxRadius: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.tradeTitle,
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                          Text(
                            widget.deatils,
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                          Text(
                            widget.phoneNumber,
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.black,
                                onSurface: Colors.grey,
                              ),
                              onPressed: widget.onTap,
                              child: Text(
                                "Call",
                                style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                    color: Colors.white),
                              )),

                          // Text(
                          //   // FormattedDate,
                          //   "View more",
                          //   style: GoogleFonts.rubik(
                          //       fontWeight: FontWeight.w400,
                          //       fontSize: 14,
                          //       color: Colors.black),
                          // ),
                        ],
                      ),
                      // GestureDetector(
                      //   onTap: onTap,
                      //   child: CallButton(
                      //       child: Text(
                      //     "Call",
                      //     style: GoogleFonts.rubik(
                      //         fontWeight: FontWeight.w600,
                      //         fontSize: 16,
                      //         color: Colors.white),
                      //   )),
                      // ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        FormattedDate,
                        // "View more",
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            )
            // ),
          ],
        ),
      ),
    );
  }
}
