import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherCard extends StatefulWidget {
  const WeatherCard({super.key});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  bool isLocationEnabled = false;
  late Position position;
  late final latitude;
  late final longitude;


  Future<LocationPermission> permission = Geolocator.checkPermission();

  Future fetchWeather() async {
    var url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&appid=b4b035e79b44eeefd57ea1289ae67f35";
    var response = await http.get(Uri.parse(url));
    print(response.body);
    return response.body;
  }

  void checkPermission() async {
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    } else if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
    } else if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      isLocationEnabled = true;
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude = position.latitude;
      longitude = position.longitude;
      fetchWeather();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkPermission();
    fetchWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
