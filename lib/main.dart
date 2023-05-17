import 'package:farmfield/auth/auth.dart';
import 'package:farmfield/e-commers/model/cart_model.dart';
import 'package:farmfield/e-commers/pages/home_page.dart';
import 'package:farmfield/firebase_options.dart';
import 'package:farmfield/provider/authProvider.dart';
import 'package:farmfield/screens/Crop/infoPage.dart';
import 'package:farmfield/screens/dashboard/dashboard.dart';
import 'package:farmfield/screens/maps/mapScreen.dart';
import 'package:farmfield/screens/trade/tradeScreen.dart';
import 'package:farmfield/widgets/trade/trade.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
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
        ChangeNotifierProvider(
          create: (context) => CartModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FarmField',
        home: AuthCheck(),
        routes: {
          // '/histroyPage': (context) => const InfoScreen(),
          '/return': (context) => const DashBoard(),
          '/trade': (context) => TradeScreen(),
          '/store': (context) => Ecommer(),
          '/map': (context) => PropertyFieldMap(),
        },
      ),
    );
  }
}
