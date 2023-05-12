import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CropRecResult extends StatefulWidget {
  const CropRecResult({super.key});

  static const routeName = '/crop_pred_res';

  @override
  State<CropRecResult> createState() => _CropRecResultState();
}

class _CropRecResultState extends State<CropRecResult> {
  Future fetchResult(data) async {
    var url = "https://plain-needles-glow.loca.lt/predict";
    var response = await http.post(Uri.parse(url), body: json.encode(data));
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Crop Recommendation Result page"),
      ),
      body: FutureBuilder(
        future: fetchResult(args),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data);
            return Text(
                  "Recommended Crop - ${data['prediction']}",
                  style: const TextStyle(fontSize: 20),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
