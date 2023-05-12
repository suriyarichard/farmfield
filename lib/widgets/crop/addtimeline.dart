import 'package:farmfield/services/crop.services.dart';
import 'package:farmfield/services/final.service.dart';
import 'package:farmfield/services/infoCrop.service.dart';
import 'package:farmfield/widgets/auth/login/customButton.dart';
import 'package:farmfield/widgets/crop/copy.dart';
import 'package:farmfield/widgets/snackbar/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTimeline extends StatefulWidget {
  final Function refresh;
  const AddTimeline({super.key, required this.refresh});

  @override
  State<AddTimeline> createState() => _AddTimelineState();
}

class _AddTimelineState extends State<AddTimeline> {
  InfoCropService infoCropService = InfoCropService();
  CropServiceF cropServiceF = CropServiceF();

  PhoneService phoneService = PhoneService();
  TextEditingController nameevent = TextEditingController();
  TextEditingController amount = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController img = TextEditingController();
  var croptimeline;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Add Crop",
                style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w600,
                    fontSize: 21,
                    color: const Color(0xFF000000)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Crop Name",
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black),
                      )),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    controller: nameevent,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Description';
                      }
                      if (value.length < 3) {
                        return 'Please Enter min 3 characters';
                      }
                      if (value.length > 30) {
                        return 'Max 30 characters only Allowed';
                      }
                      return null;
                    },
                    // maxLength: 30,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      // contentPadding: EdgeInsets.symmetric(vertical: 100),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Amount",
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black),
                      )),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    controller: amount,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Description';
                      }
                      if (value.length < 3) {
                        return 'Please Enter min 3 characters';
                      }
                      if (value.length > 30) {
                        return 'Max 30 characters only Allowed';
                      }
                      return null;
                    },
                    // maxLength: 30,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      // contentPadding: EdgeInsets.symmetric(vertical: 100),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      // if (_formKey.currentState!.validate()) {
                      //   croptimeline = {
                      //     "name": nameevent.text,
                      //     'phone': amount.text,
                      //   };
                      //   await phoneService.add(context, croptimeline);
                      //   widget.refresh();
                      //   showSnackBar(
                      //       context, "New Process added Successfully ");
                      //   Navigator.of(context).pop();
                      // }
                      if (_formKey.currentState!.validate()) {
                        croptimeline = {
                          // 'cropname': [
                          //   {
                          //     "cropname": 'text',
                          //     "createdAt": DateTime.now(),
                          //     'uid': FirebaseAuth.instance.currentUser?.uid,
                          //     'crop': [{}],
                          //     'img': '',
                          //   }
                          // ],
                          // 'timeline': [
                          //   {
                          //     "eventname": nameevent.text,
                          //     "amount": amount.text,
                          //   }
                          // ],

                          "eventname": nameevent.text,
                          "amount": amount.text,

                          // "eventname": nameevent.text,
                          // "amount": amount.text,
                          // 'uid': FirebaseAuth.instance.currentUser?.uid,
                          // "createdAt": DateTime.now(),
                        };
                        // await cropsService.add

                        await cropServiceF.addTime(
                            context, croptimeline, nameevent);
                        widget.refresh();
                        showSnackBar(
                            context, "New Process added Successfully ");
                        Navigator.of(context).pop();
                      }
                    },
                    child: CustomButton(
                      child: Text(
                        "Add the Crop",
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 45),
                  // TextButton(
                  //     onPressed: () async {
                  //       if (_formKey.currentState!.validate()) {
                  //         croptimeline = {
                  //           "eventname": nameevent.text,
                  //           "amount": amount.text,
                  //           "createdAt": DateTime.now(),
                  //         };
                  //         // await cropsService.add

                  //         await infoCropService.add(context, croptimeline);
                  //         widget.refresh();
                  //         showSnackBar(
                  //             context, "New Announcement added Successfully ");
                  //         Navigator.of(context).pop();
                  //       }
                  //     },
                  //     child: Text(
                  //       "Announce Now",
                  //       style: GoogleFonts.rubik(
                  //           fontWeight: FontWeight.w600,
                  //           fontSize: 18,
                  //           color: Colors.white),
                  //     )),

                  const SizedBox(
                    height: 6,
                  ),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: const Color(0xFF000000)),
                      )),
                  // const SizedBox(
                  //     // height: 10,
                  //     ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
