import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:farmfield/pallets/color.dart';
import 'package:geolocator/geolocator.dart';
import './result.dart';

class FertRecommendizer extends StatefulWidget {
  const FertRecommendizer({super.key});

  static const routeName = '/fertilizer-rec';

  @override
  State<FertRecommendizer> createState() => _FertRecommendizerState();
}

class _FertRecommendizerState extends State<FertRecommendizer> {
  TextEditingController temperature = TextEditingController();
  TextEditingController phosphorus = TextEditingController();
  TextEditingController potassium = TextEditingController();
  TextEditingController moisture = TextEditingController();
  TextEditingController soil = TextEditingController();
  TextEditingController nitrogen = TextEditingController();
  TextEditingController crop = TextEditingController();
  TextEditingController humidity = TextEditingController();
  TextEditingController ph = TextEditingController();
  TextEditingController rainfall = TextEditingController();

  Future<LocationPermission> permission =
      Geolocator.checkPermission() as Future<LocationPermission>;
  var responseRes;
  bool isLocationEnabled = false;
  bool setLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fertilizer Recommender'),
      ),
      body: SingleChildScrollView(
        child: setLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  // Container(
                  //     margin: const EdgeInsets.all(10),
                  //     padding: const EdgeInsets.all(10),
                  //     child: const Text(
                  //       'Check your best recommended crop!',
                  //       textAlign: TextAlign.center,
                  //       style: TextStyle(
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.bold,
                  //           letterSpacing: 1),
                  //     )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: temperature,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'temperature',
                        // hintText: 'Enter the ratio of nitrogen content',
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
                      controller: humidity,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'humidity',
                        hintText: '',
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
                      controller: moisture,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Moisture',
                        hintText: '',
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
                      controller: soil,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText:
                            'Black	0 , Clayey	1 , Loamy	2 , Red	3 ,Sandy 4',
                        hintText: 'Soil type',
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
                      controller: crop,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText:
                            'Barley	0 , Cotton	1 , Ground Nuts	2 , Maize	3 , Millets	4 , Oil seeds	5 , Paddy	6 , Pulses	7 , Sugarcane	8 , Tobacco	9 , Wheat	',
                        hintText: 'Crop Type',
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
                      controller: nitrogen,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'ntrogen',
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
                      controller: potassium,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'pottassium',
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
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: phosphorus,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Phosphorus',
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
                          'temp': temperature.text,
                          'humi': humidity.text,
                          'mois': moisture.text,
                          'soil': soil.text,
                          'crop': crop.text,
                          'nitro': nitrogen.text,
                          'pota': potassium.text,
                          'phosp': phosphorus.text
                        };
                        Navigator.of(context).pushNamed(
                            FertilizerRecResult.routeName,
                            arguments: data);
                      },
                    ),
                  ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.of(context).pushNamed(DiseasePred.routeName);
                  //     },
                  //     child: const Text('Predict Crop Disease'))
                ],
              ),
      ),
    );
  }
}
