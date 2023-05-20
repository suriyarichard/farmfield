// import 'package:farmfield/widgets/pieChart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CropCard extends StatelessWidget {
  CropCard({super.key});
  final streamChart = FirebaseFirestore.instance
      .collection('charts')
      .snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context) {
    // final data = [
    //   {'domain': 'Flutter', 'measure': 28},
    //   {'domain': 'React Native', 'measure': 27},
    //   {'domain': 'Ionic', 'measure': 20},
    //   {'domain': 'Cordova', 'measure': 15},
    // ];
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
                          Text("Overall Crop Grown",
                              style: GoogleFonts.robotoMono(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    StreamBuilder(
                      stream: streamChart,
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.hasError) {
                          return const Text("some thing went wrong");
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text("Loading...");
                        }
                        if (snapshot.data == null) {
                          return Text("empty");
                        }
                        List listChart = snapshot.data!.docs.map((e) {
                          return {
                            'domain': e.data()['date'],
                            'measure': e.data()['income'],
                          };
                        }).toList();
                        return AspectRatio(
                          aspectRatio: 12 / 9,
                          child: DChartPie(
                            // data: data.map{(e){return['domain':e['study'],'measure':e['student']]};}.toList(),
                            fillColor: (pieData, index) => Colors.purple,
                            data: [
                              {
                                'id': 'Bar',
                                'data': listChart,
                              }
                            ],
                            labelLineColor: Colors.green,
                          ),
                        );
                      },
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(16),
                    //   child:
                    // ),
                    // ScatterChartPage(),
                  ]),
                ])));
  }
}
