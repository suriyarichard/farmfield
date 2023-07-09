import 'package:farmfield/pallets/color.dart';
import 'package:farmfield/services/crop.services.dart';
import 'package:farmfield/widgets/auth/login/customButton.dart';
import 'package:farmfield/widgets/button/smallbutton.dart';
import 'package:farmfield/services/final.service.dart';
import 'package:farmfield/widgets/snackbar/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddCrop extends StatefulWidget {
  final Function refresh;
  const AddCrop({super.key, required this.refresh});

  @override
  State<AddCrop> createState() => _AddCropState();
}

class _AddCropState extends State<AddCrop> {
  CropService cropService = CropService();
  CropServiceF cropServiceF = CropServiceF();
  TextEditingController croptitle = TextEditingController();
  TextEditingController croptype = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController img = TextEditingController();
  var cropList;

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
                style: TextStyle(
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
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black),
                      )),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    controller: croptitle,
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
                        "Description",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black),
                      )),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    controller: croptype,
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
                  // const SizedBox(height: 45),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        cropList = {
                          "cropname": croptitle.text,
                          "createdAt": DateTime.now(),
                          'uid': FirebaseAuth.instance.currentUser?.uid,
                          'timeline': [],
                          'img': 'https://cdn.pixabay.com/photo/2022/09/19/20/01/wheat-7466358_1280.png',
                        };
                        await cropServiceF.add(context, cropList);
                        widget.refresh();
                        showSnackBar(context, "New Crop added Successfully ");
                        Navigator.of(context).pop();
                      }
                    },
                    child: CustomButton(
                      child: Text(
                        "Add the Crop",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  // TextButton(
                  //     onPressed: () async {
                  //       if (_formKey.currentState!.validate()) {
                  //         cropList = {
                  //           "crop": croptitle.text,
                  //           "decsription": croptype.text,
                  //           "createdAt": DateTime.now(),
                  //           'img':
                  //               'https://upload.wikimedia.org/wikipedia/commons/9/9d/Tomato.png',
                  //         };
                  //         // await cropsService.add

                  //         await cropService.add(context, cropList);
                  //         widget.refresh();
                  //         showSnackBar(
                  //             context, "New Announcement added Successfully ");
                  //         Navigator.of(context).pop();
                  //       }
                  //     },
                  //     child: Text(
                  //       "Announce Now",
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.w600,
                  //           fontSize: 18,
                  //           color: Colors.white),
                  //     )),

                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
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
