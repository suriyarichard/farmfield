import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoData extends StatelessWidget {
  final String text;

  NoData({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      color: const Color(0xFFEBFFD8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.network('https://assets5.lottiefiles.com/datafiles/eZXzHZZ2e9Apt25/data.json'),
            // Image.asset(
            //   'assets/nodata.png',
            //   width: 180.0,
            //   height: 180.0,
            // ),
            SizedBox(height: 3.0),
            Text(
              text,
              style: TextStyle(fontSize: 17.0, color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }
}
