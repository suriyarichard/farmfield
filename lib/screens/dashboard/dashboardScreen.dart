import 'package:farmfield/widgets/dashboard/moister.dart';
import 'package:farmfield/widgets/dashboard/weatherCard.dart';
import 'package:farmfield/widgets/pieChart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashBoradScreen extends StatefulWidget {
  const DashBoradScreen({super.key});

  @override
  State<DashBoradScreen> createState() => _DashBoradScreenState();
}

class _DashBoradScreenState extends State<DashBoradScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      // ),
      backgroundColor: Color(0xFFfbfcfa),
      body: Column(children: [
        SizedBox(
          height: 60,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Welcome!",
                style: GoogleFonts.robotoMono(
                    fontSize: 25, fontWeight: FontWeight.w800),
              ),
              Icon(Icons.notifications_none_outlined)
            ],
          ),
        ),
        // const SizedBox(height: 20),
        WeatherCard(),
        // const Center(child: WeatherCard()),
        SenorCard(),
      ]),
    );
  }
}
