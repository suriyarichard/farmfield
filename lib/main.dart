import 'package:farmfield/auth/auth.dart';
import 'package:farmfield/e-commers/model/cart_model.dart';
import 'package:farmfield/firebase_options.dart';
import 'package:farmfield/provider/authProvider.dart';
import 'package:farmfield/screens/Crop/infoPage.dart';
import 'package:farmfield/screens/dashboard/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import './screens/crop_predictor/result.dart';
import 'package:camera/camera.dart';
import './screens/disease_predictor/disease_pred.dart';

List<CameraDescription>? cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => CartModel(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FarmField',
          home: AuthCheck(),
          routes: {
            '/histroyPage': (context) => const InfoScreen(),
            '/return': (context) => const DashBoard(),
            DiseasePred.routeName: (context) => DiseasePred()
          },
        ));
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'FarmField',
    //   home: DashBoard(),
    //   routes: {
    //     '/histroyPage': (context) => const InfoScreen(),
    //     '/crop_pred_res': (context) => CropRecResult(),
    //     DiseasePred.routeName : (context) => DiseasePred()
    //   },
    // );
  }
}
