import 'package:farmfield/pallets/color.dart';
import 'package:farmfield/services/trade.service.dart';
import 'package:farmfield/widgets/auth/login/customButton.dart';
import 'package:farmfield/widgets/snackbar/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTrade extends StatefulWidget {
  final Function refresh;
  const AddTrade({super.key, required this.refresh});

  @override
  State<AddTrade> createState() => _AddTradeState();
}

class _AddTradeState extends State<AddTrade> {
  TradeService tradeService = TradeService();
  TextEditingController productstitle = TextEditingController();
  TextEditingController price = TextEditingController();

  TextEditingController kg = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var announcementList;

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
                "Add Product to sale!!",
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
                        "Title",
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black),
                      )),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    controller: productstitle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter product name';
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
                      hintStyle:
                          const TextStyle(color: Colors.black, fontSize: 14),
                      hintText: "Enter your Product name",
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

                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Kg",
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black),
                      )),
                  TextFormField(
                    controller: kg,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter weight';
                      }
                      if (value.length > 10) {
                        return 'Max 10 characters only Allowed';
                      }
                      return null;
                    },
                    // maxLength: 500,
                    // maxLines: 10,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,

                      hintStyle:
                          const TextStyle(color: Colors.black, fontSize: 14),
                      hintText: "Kg",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      // contentPadding: EdgeInsets.symmetric(vertical: 100),
                    ),
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Price",
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black),
                      )),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    controller: price,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Price';
                      }
                      if (value.length > 10) {
                        return 'Max 10 characters only Allowed';
                      }
                      return null;
                    },
                    // maxLength: 30,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintStyle:
                          const TextStyle(color: Colors.black, fontSize: 14),
                      hintText: "Enter your Price",
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
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Phone",
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black),
                      )),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    controller: phoneNumber,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Phone Number';
                      }
                      if (value.length < 10) {
                        return 'Please Enter  10 characters';
                      }
                      if (value.length > 10) {
                        return 'Max 10 number only Allowed';
                      }
                      return null;
                    },
                    // maxLength: 30,
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                      hintStyle:
                          const TextStyle(color: Colors.black, fontSize: 14),
                      hintText: "Enter your Phone number",
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
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () async => {
                      if (_formKey.currentState!.validate())
                        {
                          announcementList = {
                            "product": productstitle.text,
                            "kg": kg.text,
                            'phone': phoneNumber.text,
                            'price': price.text,
                            "createdAt": DateTime.now()
                          },
                          await tradeService.add(context, announcementList),
                          widget.refresh(),
                          showSnackBar(
                              context, "New Trade added Successfully "),
                          Navigator.of(context).pop(),
                        }
                    },
                    child: CustomButton(
                        child: Text(
                      "Confrim to Trade",
                      style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white),
                    )),
                  ),
                  const SizedBox(
                    height: 2,
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
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
