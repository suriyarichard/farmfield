import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  // TextEditingController cityNameController = TextEditingController();
  bool isLocationEnabled = false;
  Future<LocationPermission> permission =
      Geolocator.checkPermission() as Future<LocationPermission>;
  var responseRes;

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

  void getParams(double lat, double lon) async {
    // var cityName = cityNameController.text;

    var url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=b4b035e79b44eeefd57ea1289ae67f35";
    // var url =
    //     "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=b4b035e79b44eeefd57ea1289ae67f35";
    var response = http.get(Uri.parse(url))
        .then((resp) => {
          setState(() {
            responseRes = json.decode(resp.body);
          }),
          print(responseRes)
        })
        .catchError((onError) => {
          print(onError)
        });
    // setState(() {
    //   responseRes = json.decode(response.body);
    // });
    // print(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.only(top:40),
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    isLocationEnabled
                        ? responseRes != null
                            ? Column(
                                children: [
                                  Container(
                                    height: 200,
                                    width: 200,
                                    child : responseRes['weather'][0]['main'] == 'Clouds'
                                      ? Image.asset('assets/images/clouds.png')
                                      : responseRes['weather'][0]['main'] == 'Rain'
                                        ? Image.asset('assets/images/rain.png')
                                        : responseRes['weather'][0]['main'] == 'Clear'
                                          ? Image.asset('assets/images/clear-sky.png')
                                          : responseRes['weather'][0]['main'] == 'Snow'
                                            ? Image.asset('assets/images/snow.png')
                                            : responseRes['weather'][0]['main'] == 'Thunderstorm'
                                              ? Image.asset('assets/images/thunderstorm.png')
                                              : responseRes['weather'][0]['main'] == 'Drizzle'
                                                ? Image.asset('assets/images/drizzle.png')
                                                : Image.asset('assets/images/mist.png')
                                  ),
                                  Text(
                                    responseRes['weather'][0]['main'],
                                    style: const TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    )
                                  ),
                                  Text(
                                    responseRes['weather'][0]['description'],
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                    )
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 12 , bottom:12),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                              "Temperature: ${responseRes['main']['temp']}°C",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              )
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                              "Feels Like: ${responseRes['main']['feels_like']}°C",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              )
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            "Pressure: ${responseRes['main']['pressure']} hPa",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            )
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                              "Humidity: ${responseRes['main']['humidity']}%",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              )
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    margin: const EdgeInsets.only(top : 60 , bottom:60),
                                    // height:300,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              const Text(
                                                "Wind Speed",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.all(8),
                                                child: const Icon(
                                                  Icons.speed,
                                                  size: 38,
                                                  color: Colors.green,
                                                )
                                              ),
                                              Text(
                                                "${responseRes['wind']['speed']} m/s",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const Text(
                                                "Wind Degree",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.all(8),
                                                child: const Icon(
                                                  Icons.arrow_upward,
                                                  size: 38,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              Text(
                                                "${responseRes['wind']['deg']}°",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const Text(
                                                "Cloudiness",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.all(8),
                                                child: const Icon(
                                                  Icons.cloud,
                                                  size: 38,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              Text(
                                                "${responseRes['clouds']['all']}%",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Not Precise Location?",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            checkPermission();
                                          },
                                          child: const Text("Refresh"),
                                        )
                                      ],
                                    ),
                                  ),
                                  
                                ],
                              )
                            : Column(
                              children: [
                                const CircularProgressIndicator(),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: const Text(
                                    "Fetching weather data",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            )
                        : ElevatedButton(
                            onPressed: () async {
                              await Geolocator.requestPermission();
                            },
                            child: const Text("Enable My Location"),
                          ),
                  ],
    )));
  }
}
