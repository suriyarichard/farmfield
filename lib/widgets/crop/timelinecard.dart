import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TimeLineCard extends StatefulWidget {
  final createdDateAndTime;
  TimeLineCard({
    super.key,
    this.createdDateAndTime,
  });

  @override
  State<TimeLineCard> createState() => _TimeLineCardState();
}

class _TimeLineCardState extends State<TimeLineCard> {
  String FormattedDate = "N/A";
  // @override
  // void initState() {
  //   super.initState();
  //   formatDate();
  // }

  // void formatDate() {
  //   FormattedDate = DateFormat('yyyy-MM-dd hh:mm a')
  //       .format(widget.createdDateAndTime.toDate());
  // }
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Color(0xFFeceee6),
        elevation: 0,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Start",
                          style: GoogleFonts.robotoMono(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                      Text(
                        // FormattedDate,
                        "3/4/2023, 5:30 am",
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ]),
            ]
            )
            );
  }
}
