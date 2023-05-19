import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfield/pallets/color.dart';
import 'package:farmfield/services/trade.service.dart';
import 'package:farmfield/widgets/trade/addtrade.dart';
import 'package:farmfield/widgets/trade/trade.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class TradeScreen extends StatefulWidget {
  const TradeScreen({super.key});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  List<dynamic> chat = [];
  TradeService tradeService = TradeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        toolbarHeight: 90,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Trade',
                style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: AppColor.titleColor),
              ),
              subtitle: Text(
                'Stay Connected and Rate your Self',
                style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColor.titleColor),
              ),
            ),
          ],
        ),
        elevation: 1,
        backgroundColor: AppColor.bodyColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        // onPressed: () => Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return const CartPage();
        //     },
        //   ),
        // ),
        onPressed: () {
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
                return AddTrade(refresh: () => setState(() {}));
              });
        },
        child: const Icon(Icons.animation),
      ),
      body: SingleChildScrollView(
        // child: Padding(
        //   padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FutureBuilder(
                    future: tradeService.get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Display a loading spinner while waiting for data
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        // Display an error message if the future throws an error
                        return Text("Error: ${snapshot.error}");
                      } else {
                        chat = snapshot.data;
                        if (chat.length == 0) {
                          return Text("data");
                          // return NoData(text: 'No Announcements Available');
                        } else
                          // Call the function from the instance of MyClass and display the fetched data
                          // return Text(snapshot.data['data'][0]['phone'].toString());
                          print("ddsasseee" + snapshot.data.toString());
                        // return Text(snapshot.data.toString());
                        return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: 335,
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return TradeCard(
                                onTap: () async {
                                  Uri phoneno = Uri.parse(
                                      "tel:${snapshot.data[index]['phone']}");
                                  if (await launchUrl(phoneno)) {
                                    //dialer opened
                                  } else {
                                    //dailer is not opened
                                  }
                                },
                                phoneNumber: snapshot.data[index]['phone'],
                                createdDateAndTime: snapshot.data[index]
                                    ['createdAt'] as Timestamp,
                                // deatils: snapshot.data[index]['deatils'],
                                tradeTitle: snapshot.data[index]['product'],
                                kg: snapshot.data[index]['kg'],
                                price: snapshot.data[index]['price'],
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // AnnounceCard(
                  //   createdDateAndTime: '3/4/2023, 5:30 am',
                  //   information: 'The ration will be oped today and tomorrow',
                  //   titleText: 'Regarding ration opening',
                  // ),
                  // AnnounceCard(
                  //   createdDateAndTime: '3/4/2023, 5:30 am',
                  //   information: 'The ration will be oped today and tomorrow',
                  //   titleText: 'Regarding ration opening',
                  // ),
                  // AnnounceCard(
                  //   createdDateAndTime: '3/4/2023, 5:30 am',
                  //   information: 'The ration will be oped today and tomorrow',
                  //   titleText: 'Regarding ration opening',
                  // ),
                  // AnnounceCard(
                  //   createdDateAndTime: '3/4/2023, 5:30 am',
                  //   information: 'The ration will be oped today and tomorrow',
                  //   titleText: 'Regarding ration opening',
                  // ),
                  // AnnounceCard(
                  //   createdDateAndTime: '3/4/2023, 5:30 am',
                  //   information: 'The ration will be oped today and tomorrow',
                  //   titleText: 'Regarding ration opening',
                  // ),
                ]),
          ),
        ),
      ),
    );
  }
}
