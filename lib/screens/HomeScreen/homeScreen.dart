import 'package:farmfield/widgets/dashboard/moister.dart';
import 'package:farmfield/widgets/dashboard/weatherCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfbfcfa),
      body: Column(children: [
        const SizedBox(
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
              const Icon(Icons.notifications_none_outlined)
            ],
          ),
        ),
        const WeatherCard(),
        const SizedBox(height: 20),
        // const Center(child: WeatherCard()),
        const SenorCard(),
      ]),
    );
  }
}
