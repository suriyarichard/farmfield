import 'package:farmfield/auth/auth.dart';
import 'package:farmfield/pallets/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: ((context) => AuthCheck()
              //  Wrapper()
              )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bodyColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 200.0,
            height: 200.0,
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/logo.png")),
                // color: Colors.blue,
                borderRadius: const BorderRadius.all(Radius.circular(30.0))),
          ),
          Text(
            "Farm. Tech .Thrive",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 50),
          const SpinKitCircle(
            color: Colors.green,
            size: 50,
          )
        ]),
      ),
    );
  }
}
