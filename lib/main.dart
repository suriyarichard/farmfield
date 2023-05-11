import 'package:farmfield/auth/auth.dart';
import 'package:farmfield/firebase_options.dart';
import 'package:farmfield/provider/authProvider.dart';
import 'package:farmfield/screens/Crop/infoPage.dart';
import 'package:farmfield/screens/dashboard/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FarmField',
        home: AuthCheck(),
        routes: {
          '/histroyPage': (context) => const InfoScreen(),
        },
      ),
    );
  }
}
