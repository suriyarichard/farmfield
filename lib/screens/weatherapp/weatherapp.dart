import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {

  TextEditingController cityNameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child : Column(
          children: [
            TextField(
              controller: cityNameController,
              decoration: InputDecoration(
                hintText: "Enter City Name",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.all(8),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                var cityName = cityNameController.text;
                var url = "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=b4b035e79b44eeefd57ea1289ae67f35";
                var response = http.get(Uri.parse(url))
                    .then((response) => print(response.body))
                    .catchError((onError) => print(onError));
                print(response);
              },
              child: const Text("Search"),

            ),
            const Text(
              "Your Search Results:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        )
        )
      );
    
  }
}
