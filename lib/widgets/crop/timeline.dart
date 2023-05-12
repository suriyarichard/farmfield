import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfield/pallets/color.dart';
import 'package:farmfield/services/crop.dart';
import 'package:farmfield/services/final.service.dart';
import 'package:farmfield/services/infoCrop.service.dart';
import 'package:farmfield/widgets/button/smallbutton.dart';
import 'package:farmfield/widgets/crop/addtimeline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:farmfield/widgets/crop/timelinecard.dart';

class Timeline extends StatefulWidget {
  const Timeline({super.key});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  // InfoCropService infoCropService = InfoCropService();
  // CropServices cropServices = CropServices();
  CropServiceF cropServiceF = CropServiceF();
  var timelinehistroy;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Crop Status",
                style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColor.titleColor),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: AppColor.bodyColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      elevation: 20,
                      context: context,
                      builder: (context) {
                        return AddTimeline(refresh: () => setState(() {}));
                      });
                },
                child: SmallButton(
                  child: Text(
                    "Set up ",
                    style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          // Padding(
          //   padding: EdgeInsets.all(25.0),
          //   child: TimeLineCard(
          //     createdDateAndTime:[],
          //   ),
          // ),
          FutureBuilder(
              future: cropServiceF.getTime(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Display a loading spinner while waiting for data
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Display an error message if the future throws an error
                  return Text("Error: ${snapshot.error}");
                } else {
                  timelinehistroy = snapshot.data;
                  // print("hello ${snapshot.data['Name']}");
                  // Call the function from the instance of MyClass and display the fetched data
                  if (timelinehistroy.length == 0) {
                    return Text("hellp");
                    // return NoData(text: 'No Profile Available', img: 'https://assets3.lottiefiles.com/packages/lf20_2K2lEIcWwq.json',);
                  } else {
                    // Call the function from the instance of MyClass and display the fetched data

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(snapshot.data.toString()),
                    );

                    // return SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.75,
                    //   width: 325,
                    //   child: ListView.builder(
                    //     itemCount: snapshot.data.length,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return TimeLineCard(
                    //         // createdDateAndTime:
                    //         // snapshot.data[index]['createdAt'] as Timestamp,
                    //         eventName: snapshot.data.toString(),
                    //         amount: snapshot.data.toString(),
                    //       );
                    //     },
                    //   ),
                    // );
                  }
                }
              })
        ]);
  }
}
