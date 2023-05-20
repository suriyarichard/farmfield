import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FertilizerRecResult extends StatefulWidget {
  const FertilizerRecResult({super.key});

  static const routeName = '/fertilizer-rec-result';

  @override
  State<FertilizerRecResult> createState() => _FertilizerRecResultState();
}

class _FertilizerRecResultState extends State<FertilizerRecResult> {

  var respRes;


  Future fetchResult(data) async {
    var url = "https://farmflow-386217.ue.r.appspot.com/predict";
    print(data);
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    respRes = json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;


    return Scaffold(
        appBar: AppBar(title: Text('Results')),
        body: FutureBuilder(
            future: fetchResult(args),
            builder: (context, snapshot) {
              return respRes != null
                  ? Center(
                      child: Column(children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Text(
                          "Recommended Fertilizer - ${respRes.toString()}",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ]))
                  : const CircularProgressIndicator();
            }));
  }
}
