import 'package:farmfield/widgets/dashboard/moister.dart';
import 'package:farmfield/widgets/dashboard/sensors.dart';
import 'package:farmfield/widgets/dashboard/weatherCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List navigateOptions = [
    "Overview",
    "Corn",
    "Maize",
    "Community",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(children: [
        // const SizedBox(
        //   height: 60,
        // ),
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
              const Icon(Icons.notifications_none_outlined)
            ],
          ),
        ),
        Container(
          height: 70,
          margin: const EdgeInsets.all(18),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: navigateOptions.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(10),
                width: 140,
                child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                              side: BorderSide(color: Colors.black)))),
                  child: Text(
                    "${navigateOptions[index]}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Sensors(),
        // const SizedBox(height: 20),
        WeatherCard(),
        // const Center(child: WeatherCard()),
        SenorCard(),
      ]),
    ));
  }
}
