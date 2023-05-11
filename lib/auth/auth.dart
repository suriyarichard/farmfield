import 'package:farmfield/auth/loginScreen.dart';
import 'package:farmfield/pallets/color.dart';
import 'package:farmfield/screens/dashboard/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool isLoggedIn = FirebaseAuth.instance.currentUser != null ? true : false;
  // bool showLoginPage = true;
  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      return const DashBoard();
    } else if (isLoggedIn == false) {
      return const LoginScreen();
    } else {
      return Scaffold(
        backgroundColor: AppColor.bodyColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: const [
                CircularProgressIndicator(
                  color: Colors.blue,
                  // strokeWidth: 1.5,
                ),
                Text("Loading...")
              ],
            ),
          ),
        ),
      );
    }
  }
}
