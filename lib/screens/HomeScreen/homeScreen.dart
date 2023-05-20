import 'package:farmfield/widgets/dashboard/moister.dart';
import 'package:farmfield/widgets/dashboard/sensors.dart';
import 'package:farmfield/widgets/dashboard/weatherCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';


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

  bool isLocationEnabled = false;
  Future<LocationPermission> permission =
      Geolocator.checkPermission() as Future<LocationPermission>;
  var responseRes;

  void getParams(double lat, double lon) async {
    var url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=b4b035e79b44eeefd57ea1289ae67f35";

    var response = http
        .get(Uri.parse(url))
        .then((resp) => {
              setState(() {
                responseRes = json.decode(resp.body);
              }),
              print(responseRes)
            })
        .catchError((onError) => {print(onError)});
  }


  Future checkPermission() async {
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
      return false;
    } else if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return false;
    } else {
      isLocationEnabled = true;
      var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print('${position.latitude} , ${position.longitude}');
      getParams(position.latitude as double, position.longitude as double);
      return true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(children: [
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
                              side: const BorderSide(color: Colors.black)))),
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
        WeatherCard(
          weatherDetails: responseRes,
        ),
        // const Center(child: WeatherCard()),
        // SenorCard(),
      ]),
    ));
  }
}
