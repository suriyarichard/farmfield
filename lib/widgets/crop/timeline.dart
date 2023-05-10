import 'package:farmfield/pallets/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:farmfield/widgets/crop/timelinecard.dart';

class Timeline extends StatelessWidget {
  const Timeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Crop Status",
                style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColor.titleColor),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Set up",
                  style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.green),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Padding(
            padding: EdgeInsets.all(25.0),
            child: TimeLineCard(),
          ),
        ]);
  }
}
