import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfield/pallets/color.dart';
import 'package:farmfield/services/user.service.dart';
import 'package:farmfield/widgets/crop/timelinecard.dart';
import 'package:farmfield/widgets/trade/callButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TradeCard extends StatefulWidget {
  final String tradeTitle;
  final String phoneNumber;
  final String kg;
  final String price;
  final GestureTapCallback onTap;
  final Timestamp createdDateAndTime;
  const TradeCard({
    super.key,
    required this.tradeTitle,
    required this.phoneNumber,
    required this.onTap,
    required this.createdDateAndTime,
    required this.kg,
    required this.price,
  });

  @override
  State<TradeCard> createState() => _TradeCardState();
}

class _TradeCardState extends State<TradeCard> {
  UserService userService = UserService();
  List<dynamic> name = [];
  final uid = FirebaseAuth.instance.currentUser!.uid;
  String FormattedDate = "N/A";

  @override
  void initState() {
    super.initState();
    formatDate();
  }

  void formatDate() {
    FormattedDate =
        DateFormat('yyyy-MM-dd ').format(widget.createdDateAndTime.toDate());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 325,
      height: 140,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        // color: Colors.amber,
        color: Color.fromRGBO(
                    Random().nextInt(222),
                    Random().nextInt(210),
                    Random().nextInt(200),
                    1,
                  ),
        elevation: 2,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://cdn-icons-png.flaticon.com/512/206/206865.png'),
                            maxRadius: 15,
                          ),
                          FutureBuilder(
                              future: userService.get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Text("Error: ${snapshot.error}");
                                } else {
                                  name = snapshot.data;
                                  if (name.length == 0) {
                                    return Text("-");
                                  } else {
                                    return SizedBox(
                                      width: 60,
                                      child: Text(
                                        ''
                                        // snapshot.data[0]['name'].toString(),
                                        // textAlign: TextAlign.center,
                                        // style: TextStyle(
                                          
                                        //   color: Colors.white
                                        // ),
                                      ),
                                    );
                                  }
                                }
                              }),
                        ],
                      ),

                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Product: ${widget.tradeTitle}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                          Text(
                            "Kg: ${widget.kg}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                          Text(
                            "Price: ₹${widget.price}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                          Text(
                            "Phone no:${widget.phoneNumber}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Container(
                        width: 70,
                        height: 70,

                        child:Center(
                          child: GestureDetector(
                                onTap: widget.onTap, child: Icon(Icons.call)),
                        ) ,
                      )
                      
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Created on - $FormattedDate',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
            // ),
          ],
        ),
      ),
    );
  }
}
