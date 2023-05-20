import 'dart:convert';

import 'package:farmfield/pallets/color.dart';
import 'package:farmfield/widgets/charts/crop_chart.dart';
import 'package:farmfield/widgets/cropview/cropview.dart';
import 'package:farmfield/widgets/dashboard/moister.dart';
import 'package:farmfield/widgets/dashboard/weatherCard.dart';
import 'package:farmfield/widgets/home/customicon.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:lottie/lottie.dart';
import 'package:farmfield/services/final.service.dart';
import 'package:farmfield/widgets/charts/pie.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  CropServiceF cropServiceF = CropServiceF();
  List croplist = [];
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

  // List navigateOptions = [
  //   "Overview",
  //   "Corn",
  //   "Maize",
  //   "Community",
  //   "Profile",
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Column(children: [
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
          FutureBuilder(
            future: cropServiceF.get(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading spinner while waiting for data
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Display an error message if the future throws an error
                return Text("Error: ${snapshot.error}");
              } else {
                // Call the function from the instance of MyClass and display the fetched data
                croplist = snapshot.data;
                if (croplist.length == 0) {
                  return Text("-");
                  // return NoData(text: 'No CropList Available');
                } else {
                  // return Text(snapshot.data[0]['cropname'].toString());
                  // return Text(
                  // snapshot.data[index]['cropname'].toString());
                  return Container(
                    height: 70,
                    margin: const EdgeInsets.all(18),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          width: 140,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return CropView(
                                  id: snapshot.data[index]['cropname']
                                      .toString(),
                                  title: snapshot.data[index]['cropname']
                                      .toString(),
                                );
                              }));
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                        side: const BorderSide(
                                            color: Colors.black)))),
                            child: FutureBuilder(
                              future: cropServiceF.get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // Display a loading spinner while waiting for data
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  // Display an error message if the future throws an error
                                  return Text("Error: ${snapshot.error}");
                                } else {
                                  // Call the function from the instance of MyClass and display the fetched data
                                  croplist = snapshot.data;
                                  if (croplist.length == 0) {
                                    return Text("null");
                                    // return NoData(text: 'No CropList Available');
                                  } else {
                                    // return Text(snapshot.data[0]['cropname'].toString());
                                    return Text(
                                      snapshot.data[index]['cropname']
                                          .toString(),
                                      style: GoogleFonts.robotoMono(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    );
                                  }
                                }
                              },
                            ),
                            // child: Text(
                            //   "${navigateOptions[index]}",
                            //   style: const TextStyle(
                            //     fontSize: 16,
                            //     fontWeight: FontWeight.bold,
                            //     color: Colors.black,
                            //   ),
                            // ),
                          ),
                        );
                      },
                    ),
                  );
                  //
                }
              }
            },
          ),

          Lottie.network(
              // "https://assets4.lottiefiles.com/private_files/lf30_4lyswkde.json"),
              "https://assets4.lottiefiles.com/packages/lf20_sgn7zslb.json"),
          // Sensors(),
          // const SizedBox(height: 20),
          WeatherCard(
            weatherDetails: responseRes,
          ),
          // const Center(child: WeatherCard()),
          // SenorCard(),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomIcon(
                  icon: const Icon(
                    Icons.map,
                    color: AppColor.iconColor,
                    size: 25,
                  ),
                  text: 'Field view',
                  onPressed: () {
                    Navigator.pushNamed(context, '/map');
                  },
                  background: AppColor.circleColor,
                ),
                CustomIcon(
                  icon: const Icon(
                    Icons.settings_suggest,
                    color: AppColor.iconColor,
                    size: 25,
                  ),
                  text: 'Suggest',
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  background: AppColor.circleColor,
                ),
                CustomIcon(
                  icon: const Icon(
                    Icons.crop,
                    color: AppColor.iconColor,
                    size: 25,
                  ),
                  text: 'Recommender',
                  onPressed: () {
                    Navigator.pushNamed(context, '/reco');
                  },
                  background: AppColor.circleColor,
                ),
                CustomIcon(
                  icon: const Icon(
                    Icons.store,
                    color: AppColor.iconColor,
                    size: 25,
                  ),
                  text: 'Market',
                  onPressed: () {
                    Navigator.pushNamed(context, '/store');
                  },
                  background: AppColor.circleColor,
                ),
              ],
            ),
          ),
          // Home(),
          const SizedBox(
            height: 50,
          ),
        ]),
      ),
    );
  }
}
