// import 'package:farmfield/widgets/pieChart.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SenorCard extends StatelessWidget {
  const SenorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 300,
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
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: DChartBar(
                          data: [
                            {
                              'id': 'Bar',
                              'data': [
                                {'domain': '2020', 'measure': 3},
                                {'domain': '2021', 'measure': 4},
                                {'domain': '2022', 'measure': 6},
                                {'domain': '2023', 'measure': 0.3},
                              ],
                            },
                          ],
                          domainLabelPaddingToAxisLine: 16,
                          axisLineTick: 2,
                          axisLinePointTick: 2,
                          axisLinePointWidth: 10,
                          axisLineColor: Colors.green,
                          measureLabelPaddingToAxisLine: 16,
                          barColor: (barData, index, id) => Colors.green,
                          showBarValue: true,
                        ),
                      ),
                    ),
                    // ScatterChartPage(),
                  ]),
                ])));
  }
}
