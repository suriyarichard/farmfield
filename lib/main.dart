import 'package:farmfield/screens/Crop/infoPage.dart';
import 'package:farmfield/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import './screens/crop_predictor/result.dart';
import 'package:camera/camera.dart';
import './screens/disease_predictor/disease_pred.dart';


List<CameraDescription>? cameras;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FarmField',
      home: DashBoard(),
      routes: {
        '/histroyPage': (context) => const InfoScreen(),
        '/crop_pred_res': (context) => CropRecResult(),
        DiseasePred.routeName : (context) => DiseasePred()
      },
    );
  }
}
