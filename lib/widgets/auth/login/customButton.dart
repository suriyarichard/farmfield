import 'package:farmfield/pallets/color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  // final Function onPressed;

  const CustomButton({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColor.buttonColor,
        ),
        child: Center(
          child: child,
          // child: Text(
          //   // name!,
          //   // "Verify OTP",
          //   style: GoogleFonts.rubik(
          //       fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
          // ),
        ));
  }
}
