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
  List<dynamic> relatedPhotos = [];


  Future fetchResult(data) async {
    var url = "https://fastapi-fertilizerapi.bunnyenv.com/predict";
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

  Future<List<dynamic>> getRelatedPhotos(String query, String accessKey,
      {int perPage = 5}) async {
    final String url = 'https://api.unsplash.com/search/photos';
    final Map<String, String> headers = {
      'Accept-Version': 'v1',
      'Authorization': 'Client-ID $accessKey',
    };
    final Map<String, dynamic> params = {
      'query': query,
      'per_page': perPage.toString(),
    };

    final Uri uri = Uri.parse(url).replace(queryParameters: params);
    final response = await http.get(uri, headers: headers);
    relatedPhotos = jsonDecode(response.body)['results'];

    return relatedPhotos;
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
                        FutureBuilder(
                        future: getRelatedPhotos(respRes,
                            "meVVQQl8reHwlYlP0EFzShTH_OuIr3OTkm3hO2gE1tg"),
                        builder: (context, snapshot) {
                          return 
                          relatedPhotos != null 
                          ? Container(
                            height: 400,
                            width: MediaQuery.of(context).size.width * 1,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: relatedPhotos.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Image.network(
                                      relatedPhotos[index]['urls']['small'],
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }),
                          )
                          : const CircularProgressIndicator();
                        })
                    ]))
                  : const CircularProgressIndicator();
            }));
  }
}
