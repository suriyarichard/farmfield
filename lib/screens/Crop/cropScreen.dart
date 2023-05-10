import 'package:farmfield/pallets/color.dart';
import 'package:farmfield/widgets/crop/croptile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CropList extends StatefulWidget {
  const CropList({super.key});

  @override
  State<CropList> createState() => _CropListState();
}

class _CropListState extends State<CropList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: AppColor.backgroundColor,

      appBar: AppBar(
        toolbarHeight: 90,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Track the Crop',
                style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: AppColor.titleColor),
              ),
              subtitle: Text(
                'Let’s help you',
                style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColor.titleColor),
              ),
            ),
          ],
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        // backgroundColor: AppColor.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Your CropList",
                      style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: AppColor.titleColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        // showModalBottomSheet(
                        //     isScrollControlled: true,
                        //     backgroundColor: AppColor.bodyColor,
                        //     shape: const RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.only(
                        //             topLeft: Radius.circular(20),
                        //             topRight: Radius.circular(20))),
                        //     elevation: 20,
                        // context: context,
                        // builder: (context) {
                        //   // return AddComplaint(
                        //   //     refresh: () => setState(() {}));
                        // });
                      },
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Add New",
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: 340,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return CropTile();
                    },
                  ),
                ),

                // const Padding(
                //   padding: EdgeInsets.all(15.0),
                //   child: CropTile(),
                // ),

                // const SenorCard(),

                // FutureBuilder(
                //   future: complaintService.get(context),
                //   builder:
                //       (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       // Display a loading spinner while waiting for data
                //       return Center(child: CircularProgressIndicator());
                //     } else if (snapshot.hasError) {
                //       // Display an error message if the future throws an error
                //       return Text("Error: ${snapshot.error}");
                //     } else {
                //       // Call the function from the instance of MyClass and display the fetched data
                //       complaints = snapshot.data;
                //       if (complaints.length == 0) {
                //         return NoData(text: 'No CropList Available');
                //       } else {
                //         return SizedBox(
                //           height: MediaQuery.of(context).size.height * 0.75,
                //           width: 325,
                //           child: ListView.builder(
                //             itemCount: snapshot.data.length,
                //             itemBuilder: (BuildContext context, int index) {
                //               return ComplaintCard(
                //                 onTap: () {},
                //                 createdDateAndTime: snapshot.data[index]
                //                     ['createdAt'] as Timestamp,
                //                 statusMessage: snapshot.data[index]['status'],
                //                 complaintTitle: snapshot.data[index]
                //                     ['description'],
                //               );
                //             },
                //           ),
                //         );
                //       }
                //     }
                //   },
                // ),
              ]),
        ),
      ),
    );
  }
}
