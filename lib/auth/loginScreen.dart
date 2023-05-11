import 'package:farmfield/widgets/auth/login/backgroundImage.dart';
import 'package:farmfield/widgets/auth/login/loginCard.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              // child: Center(
              child: Container(
                width: 400,
                height: 450,
                padding: const EdgeInsets.all(10.0),
                child: const LoginCard(),
              )),
        ),
        // )
      ],
    );
  }
}
