import 'package:farmfield/pallets/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class CropTile extends StatelessWidget {
  const CropTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        // color: Colors.white,
        color: AppColor.backgroundColor,
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
                                "https://upload.wikimedia.org/wikipedia/commons/9/9d/Tomato.png"),
                          ),
                          Text("Apple",
                              style: GoogleFonts.robotoMono(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
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
