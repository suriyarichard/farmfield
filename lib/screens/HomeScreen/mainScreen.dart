import 'package:farmfield/widgets/dashboard/weatherCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 50,
      ),
      Padding(
        padding: const EdgeInsets.all(20.0),
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
      Lottie.network(
          // "https://assets4.lottiefiles.com/private_files/lf30_4lyswkde.json"),
          "https://assets4.lottiefiles.com/packages/lf20_sgn7zslb.json"),
      // Sensors(),
      // const SizedBox(height: 20),
      WeatherCard(),
      // const Center(child: WeatherCard()),
      // SenorCard(),
    ]);
  }
}
