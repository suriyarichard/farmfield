import 'package:farmfield/screens/crop_predictor/result.dart';
import 'package:farmfield/screens/disease_predictor/disease_pred.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';

class CropRec extends StatefulWidget {
  const CropRec({super.key});

  @override
  State<CropRec> createState() => _CropRecState();
}

class _CropRecState extends State<CropRec> {
  TextEditingController nitrogen = TextEditingController();
  TextEditingController phosphorus = TextEditingController();
  TextEditingController potassium = TextEditingController();
  TextEditingController temperature = TextEditingController();
  TextEditingController humidity = TextEditingController();
  TextEditingController ph = TextEditingController();
  TextEditingController rainfall = TextEditingController();

  Future<LocationPermission> permission =
      Geolocator.checkPermission() as Future<LocationPermission>;
  var responseRes;
  bool isLocationEnabled = false;
  bool setLoading = false;

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
    super.initState();
    checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: setLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Check your best recommended crop!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: nitrogen,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Ratio of Nitrogen Content',
                      hintText: 'Enter the ratio of nitrogen content',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (val) {
                      if (val!.isEmpty || val == null) {
                        return 'Please enter the ratio of nitrogen content';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: phosphorus,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Ratio of Phosphorous Content',
                      hintText: 'Enter the ratio of Phosphorous content',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (val) {
                      if (val!.isEmpty || val == null) {
                        return 'Please enter the ratio of Phosporous content';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: potassium,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Ratio of Pottassium Content',
                      hintText: 'Enter the ratio of Pottassium content',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (val) {
                      if (val!.isEmpty || val == null) {
                        return 'Please enter the ratio of Pottassium content';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: temperature,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Temperature(in degree C)',
                      hintText: 'Enter the temperature in degree',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (val) {
                      if (val!.isEmpty || val == null) {
                        return 'Please enter the temperature value';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: humidity,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Humidity(in percentage)',
                      hintText: 'Enter the humidity value',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (val) {
                      if (val!.isEmpty || val == null) {
                        return 'Please enter the humidity percent';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: ph,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'pH value',
                      hintText: 'Enter the pH value',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (val) {
                      if (val!.isEmpty || val == null) {
                        return 'Please enter the pH value';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: rainfall,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Rainfall(in mm)',
                      hintText: 'Enter the rainfall value',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (val) {
                      if (val!.isEmpty || val == null) {
                        return 'Please enter the rainfall value';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  height: 60,
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () async {
                      Map data = {
                        'nitrogen': nitrogen.text,
                        'phosphorus': phosphorus.text,
                        'potassium': potassium.text,
                        'temperature': temperature.text,
                        'humidity': humidity.text,
                        'ph': ph.text,
                        'rainfall': rainfall.text,
                      };
                      Navigator.of(context)
                          .pushNamed(CropRecResult.routeName, arguments: data);
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(DiseasePred.routeName);
                    },
                    child: const Text('Predict Crop Disease'))
              ],
            ),
    );
  }
}
