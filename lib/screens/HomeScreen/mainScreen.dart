import 'dart:convert';

import 'package:farmfield/pallets/color.dart';
import 'package:farmfield/widgets/charts/crop_chart.dart';
import 'package:farmfield/widgets/cropview/cropview.dart';
import 'package:farmfield/widgets/dashboard/moister.dart';
import 'package:farmfield/widgets/dashboard/weatherCard.dart';
import 'package:farmfield/widgets/home/customicon.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
                  style: TextStyle(
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
                return Text("Error: ${snapshot.error}");
              } else {
                croplist = snapshot.data;
                if (croplist.length == 0) {
                  return Text("-");
                } else {
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
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    );
                                  }
                                }
                              },
                            ),
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
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Explore More features here',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width:150,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black,
                  ),
                  padding: EdgeInsets.all(10),
                  // width: MediaQuery.of(context).size.width * 0.3,
                  alignment: Alignment.center,
                  child: Center(
                    child: InkWell(
                       onTap: () {
                        Navigator.pushNamed(context, '/fertilizer-rec');
                      },
                      child: Column(children: [
                          Icon(
                            Icons.medical_information,
                            color: AppColor.iconColor,
                            size: 25,
                          ),
                          SizedBox(height:5),
                          const Text(
                            'Fertilizer Recommender',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            ),
                          )
                      ]),
                    ),
                  ),
                ),
                Container(
                  width:150,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black,
                  ),
                  padding: EdgeInsets.all(10),
                  // width: MediaQuery.of(context).size.width * 0.3,
                  alignment: Alignment.center,
                  child: Center(
                    child: InkWell(
                       onTap: () {
                        Navigator.pushNamed(context, '/reco');
                      },
                      child: Column(children: [
                          Icon(
                            Icons.compare_arrows_sharp,
                            color: AppColor.iconColor,
                            size: 25,
                          ),
                          SizedBox(height:5),
                          const Text(
                            'Crop Recommender',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            ),
                          )
                      ]),
                    ),
                  ),
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
