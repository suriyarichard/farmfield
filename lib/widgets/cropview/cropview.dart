import 'package:farmfield/pallets/color.dart';
import 'package:farmfield/widgets/dashboard/moister.dart';
import 'package:farmfield/widgets/dashboard/weatherCard.dart';
import 'package:farmfield/widgets/home/customicon.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CropView extends StatefulWidget {
  final String id;
  final String title;

  const CropView({super.key, required this.id, required this.title});

  @override
  State<CropView> createState() => _CropViewState();
}

class _CropViewState extends State<CropView> {

  var responseRes;

  bool isLocationEnabled = false;
  Future<LocationPermission> permission =
      Geolocator.checkPermission() as Future<LocationPermission>;
  // var responseRes;

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
      appBar: AppBar(
        toolbarHeight: 90,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Crop',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: AppColor.titleColor),
              ),
              subtitle: Text(
                'Let’s you Know details about you crop',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColor.titleColor),
              ),
            ),
          ],
        ),
        elevation: 1,
        // backgroundColor: Colors.white,
        backgroundColor: AppColor.backgroundColor,
      ),
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Column(children: [
          // const SizedBox(
          //   height: 50,
          // ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Crop Name:${widget.title}",
                  style: TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w800),
                ),
                // const Icon(Icons.notifications_none_outlined)
              ],
            ),
          ),

          // Sensors(),
          // const SizedBox(height: 20),
           WeatherCard(
            weatherDetails: responseRes,
          ),

          SenorCard(),
          
        ]),
      ),
    );
  }
}
