import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherCard extends StatelessWidget {
  dynamic weatherDetails;

  WeatherCard( {
    required this.weatherDetails,
  });

  @override
  Widget build(BuildContext context) {
    return weatherDetails != null
    ? SizedBox(
        width: 300,
        height: 200,
        // padding: const EdgeInsets.all(
        //   8,
        // ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: const Color(0xFffeceee6),
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
                          Text("${weatherDetails['weather'][0]['main']}",
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
                              Text(
                                " ${weatherDetails['main']['temp']} °C",
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
                          children:  [
                            const Icon(Icons.wifi_protected_setup_sharp),
                            Text("${weatherDetails['main']['pressure']} hPa"),
                            Text('Pressure'),
                          ],
                        ),
                        Column(
                          children:  [
                            Icon(Icons.shop_outlined),
                            Text("${weatherDetails['main']['humidity']} %"),
                            Text('Humidity'),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.speed),
                            Text("${weatherDetails['wind']['speed']} m/s"),
                            Text('Wind Speed'),
                          ],
                        ),
                        Column(
                          children: const [
                            Icon(Icons.thermostat_auto),
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
        ))
        : Center(
          child: Column(
            children: const [
              CircularProgressIndicator(),
              Text(
                "Loading...",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        );

  }
}
