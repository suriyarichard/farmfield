import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

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
                Column(
                  children: [
                    //     // title
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Weather",
                              style: GoogleFonts.robotoMono(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          Row(
                            children: [
                              const Icon(
                                Icons.cloud,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text("+22'c",
                                  style: GoogleFonts.robotoMono(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: const [
                            Icon(Icons.cloud),
                            Text("+22'c"),
                            Text('Soil Temp'),
                          ],
                        ),
                        Column(
                          children: const [
                            Icon(Icons.sunny),
                            Text("+22'c"),
                            Text('Soil Temp'),
                          ],
                        ),
                        Column(
                          children: const [
                            Icon(Icons.cloud),
                            Text("+22'c"),
                            Text('Soil Temp'),
                          ],
                        ),
                        Column(
                          children: const [
                            Icon(Icons.cloud),
                            Text("+22'c"),
                            Text('Soil Temp'),
                          ],
                        ),
                      ],
                    ),
                    // Container(
                    //   width: 100,
                    //   child: Lottie.network(img),
                    // ),
                    // const Center(
                    //     child: Text(
                    //   "locatorName",
                    //   // style: GoogleFonts.robotoMono(fontSize: 20),
                    // ))
                  ],
                ),
              ]),
        ));
  }
}
