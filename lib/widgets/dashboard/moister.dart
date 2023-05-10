import 'package:farmfield/widgets/pieChart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SenorCard extends StatelessWidget {
  const SenorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 200,
        // padding: const EdgeInsets.all(
        //   8,
        // ),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Color(0xFffeceee6),
            elevation: 0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(children: [
                    //     // title
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Soil Moisture",
                              style: GoogleFonts.robotoMono(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // ScatterChartPage(),
                  ]),
                ])));
  }
}
