import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfield/pallets/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CropTile extends StatefulWidget {
  final String img;
  final String title;
  final String subtitle;
  final Timestamp createdDateAndTime;

  const CropTile(
      {super.key,
      required this.img,
      required this.title,
      required this.subtitle,
      required this.createdDateAndTime});

  @override
  State<CropTile> createState() => _CropTileState();
}

class _CropTileState extends State<CropTile> {
  String FormattedDate = "N/A";

  @override
  void initState() {
    super.initState();
    formatDate();
  }

  void formatDate() {
    FormattedDate = DateFormat('yyyy-MM-dd hh:mm a')
        .format(widget.createdDateAndTime.toDate());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.white,
        // color: AppColor.backgroundColor,
        elevation: 0,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(children: [
                // Image.network(
                //     "https://upload.wikimedia.org/wikipedia/commons/9/9d/Tomato.png"),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 40,
                            child: Image.network(
                              widget.img,
                              // "https://upload.wikimedia.org/wikipedia/commons/9/9d/Tomato.png"
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.title,
                                  // "Apple",
                                  style: GoogleFonts.robotoMono(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800)),
                              Text(widget.subtitle,
                                  // "Tempature of the soil is high",
                                  style: GoogleFonts.robotoMono(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500)),
                            ],
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/histroyPage');
                        },
                        child: Row(
                          children: const [
                            // Text(
                            //   // FormattedDate,
                            //   "View more",
                            //   style: GoogleFonts.rubik(
                            //       fontWeight: FontWeight.w400,
                            //       fontSize: 16,
                            //       color: Colors.black),
                            // ),
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 14,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ]));
  }
}
