import 'package:farmfield/pallets/color.dart';
import 'package:farmfield/widgets/dashboard/moister.dart';
import 'package:farmfield/widgets/dashboard/weatherCard.dart';
import 'package:farmfield/widgets/home/customicon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CropView extends StatefulWidget {
  final String id;
  final String title;

  const CropView({super.key, required this.id, required this.title});

  @override
  State<CropView> createState() => _CropViewState();
}

class _CropViewState extends State<CropView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Crop',
                style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: AppColor.titleColor),
              ),
              subtitle: Text(
                'Let’s you Know details about you crop',
                style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColor.titleColor),
              ),
            ),
          ],
        ),
        elevation: 1,
        // backgroundColor: Colors.white,
        backgroundColor: AppColor.backgroundColor,
      ),
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Column(children: [
          // const SizedBox(
          //   height: 50,
          // ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Crop Name:${widget.title}",
                  style: GoogleFonts.robotoMono(
                      fontSize: 25, fontWeight: FontWeight.w800),
                ),
                // const Icon(Icons.notifications_none_outlined)
              ],
            ),
          ),

          // Sensors(),
          // const SizedBox(height: 20),
          WeatherCard(weatherDetails: null,),

          SenorCard(),
          
        ]),
      ),
    );
  }
}
