import 'package:farmfield/services/crop.services.dart';
import 'package:farmfield/widgets/snackbar/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCrop extends StatefulWidget {
  final Function refresh;
  const AddCrop({super.key, required this.refresh});

  @override
  State<AddCrop> createState() => _AddCropState();
}

class _AddCropState extends State<AddCrop> {
  CropService cropService = CropService();
  TextEditingController titleAnnouncement = TextEditingController();
  TextEditingController announceDescription = TextEditingController();
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
                    controller: titleAnnouncement,
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
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black),
                      )),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    controller: announceDescription,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Description';
                      }
                      if (value.length < 3) {
                        return 'Please Enter min 3 characters';
                      }
                      if (value.length > 500) {
                        return 'Max 30 characters only Allowed';
                      }
                      return null;
                    },
                    maxLength: 500,
                    maxLines: 10,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,

                      hintStyle:
                          const TextStyle(color: Colors.black, fontSize: 14),
                      hintText:
                          "Enter your complaint here (max 500 characters)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      // contentPadding: EdgeInsets.symmetric(vertical: 100),
                    ),
                  ),
                  // const SizedBox(height: 45),
                  TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          cropList = {
                            "crop": titleAnnouncement.text,
                            "decsription": announceDescription.text,
                            "createdAt": DateTime.now(),
                            'img':
                                'https://upload.wikimedia.org/wikipedia/commons/9/9d/Tomato.png',
                          };
                          // await cropsService.add

                          await cropService.add(context, cropList);
                          widget.refresh();
                          showSnackBar(
                              context, "New Announcement added Successfully ");
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        "Announce Now",
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white),
                      )),
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
