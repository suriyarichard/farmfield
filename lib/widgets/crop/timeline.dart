import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfield/pallets/color.dart';
import 'package:farmfield/services/final.service.dart';
import 'package:farmfield/services/infoCrop.service.dart';
import 'package:farmfield/widgets/button/smallbutton.dart';
import 'package:farmfield/widgets/crop/addtimeline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:farmfield/widgets/crop/timelinecard.dart';

class Timeline extends StatefulWidget {
  // const Timeline({super.key});
  final String id;

  const Timeline({
    super.key,
    required this.id,
  });

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  // InfoCropService infoCropService = InfoCropService();
  // CropServices cropServices = CropServices();
  CropServiceF cropServiceF = CropServiceF();
  var timelinehistory;
  var cropDetails;
  int totalAmt = 0;

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
                        return AddTimeline(
                            id: widget.id, refresh: () => setState(() {}));
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
          SingleChildScrollView(
            child: FutureBuilder(
                future: cropServiceF.getTime(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading spinner while waiting for data
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Display an error message if the future throws an error
                    return Text("Error: ${snapshot.error}");
                  } else {
                    // timelinehistory = snapshot.data;
                    cropDetails = snapshot.data;
                    // print("CropDetails $cropDetails");
                    for (var crop in cropDetails) {
                      if (crop['cropname'] == widget.id) {
                        timelinehistory = crop['timeline'];
                        if (crop.containsKey('totalAmount') &&
                            crop['totalAmount'] is int) {
                          totalAmt = crop['totalAmount'] as int;
                        }
                      }
                    }
                    // print(timelinehistory);
          
                    // Calculate subTotal
          
                    // for (var timeline in timelinehistory) {
                    //   if (timeline.containsKey('amount') &&
                    //       timeline['amount'] is int) {
                    //     totalAmt += timeline['amount'] as int;
                    //   }
                    // }
                    print("amount $totalAmt ");
          
                    // print("hello ${snapshot.data['Name']}");
                    // Call the function from the instance of MyClass and display the fetched data
                    if (timelinehistory.length == 0) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                                    "No Timeline added, Add Timeline Activity",
                                    style: GoogleFonts.rubik(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: const Color.fromARGB(255, 27, 29, 26)),
                                  ),
                        ],
                      );
                      // return NoData(text: 'No Profile Available', img: 'https://assets3.lottiefiles.com/packages/lf20_2K2lEIcWwq.json',);
                    } else {
                      // Call the function from the instance of MyClass and display the fetched data
          
                      //  timelinehistory= cropDetails['timeline'];
                      // return Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(timelinehistory['timeline'].toString()),
                      // );
          
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Total Amount",
                                style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: const Color.fromARGB(255, 27, 29, 26)),
                              ),
                              Text(
                                totalAmt.toString(),
                                style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: AppColor.titleColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.75,
                            width: 325,
                            child: ListView.builder(
                              itemCount: timelinehistory.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TimeLineCard(
                                  createdAt: snapshot.data[index]['createdAt']
                                      as Timestamp,
                                  eventName:
                                      timelinehistory[index]['name'].toString(),
                                  amount:
                                      timelinehistory[index]['amount'].toString(),
                                );
                              },
                            ),
                          ),
                          
                        ],
                      );
                    }
                  }
                }),
          ),
        ]);
  }
}
