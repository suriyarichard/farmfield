import 'package:farmfield/pallets/color.dart';
import 'package:farmfield/provider/authProvider.dart';
import 'package:farmfield/screens/dashboard/dashboard.dart';
import 'package:farmfield/widgets/auth/login/customButton.dart';
import 'package:farmfield/widgets/auth/login/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String verificationId;
  final String phone;
  const VerifyOtpScreen(
      {super.key, required this.verificationId, required this.phone});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  String? otpCode;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          //isLoading == true
          //     ? const Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     :
          SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            // const SizedBox(
            //   height: 20,
            // ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Verify OTP",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 21,
                      color: const Color(0xFF000000)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Enter Your OTP",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: const Color(0xFF3A3E38)),
                      )),
                  const SizedBox(
                    height: 6,
                  ),
                  Pinput(
                    length: 6,
                    showCursor: true,
                    defaultPinTheme: PinTheme(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onCompleted: (value) {
                      setState(() {
                        otpCode = value;
                      });
                    },
                  ),
                  // TextFormField(
                  //   // controller: ,
                  //   keyboardType: TextInputType.number,
                  //   decoration: InputDecoration(
                  //       filled: true,
                  //       fillColor: Colors.white,
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //         borderSide: BorderSide.none,
                  //       )),
                  // ),
                  const SizedBox(height: 15),
                  Text(
                    "You'll be getting a sweet little 6-digit number sent your way to  ${widget.phone}  When you get it, just pop it into the input and hit verify OTP ",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: const Color(0xFF2E2E2E)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // if (isLoading) const CircularProgressIndicator(),
                  if (isLoading)
                    SpinKitCircle(
                      color: Colors.blue,
                      size: 50,
                    ),

                  if (!isLoading)
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
                        //     context: context,
                        //     builder: (context) {
                        //       return RegisterScreen();
                        //     });
                        // RegisterScreen();
                        // otpScreen(context);
                        if (otpCode != null) {
                          verifyOtp(context, otpCode!);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Enter 6-digit code"),
                            ),
                          );
                        }
                      },
                      child: CustomButton(
                          child: Text(
                        "Verify OTP",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white),
                      )),
                    ),

                  const SizedBox(
                    height: 5,
                  ),
                  if (!isLoading)
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Change Phone Number",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: const Color(0xFF000000)),
                        )),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void verifyOtp(BuildContext context, String userOtp) {
    setState(() {
      isLoading = true;
    });
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () async {
        setState(() {
          isLoading = false;
        });
        // checking whether user exists in the db
        await ap.checkExistingUser();
        print("bug4 ${ap.isUserDocExist}");
        if (ap.isUserDocExist == true) {
          print("bug4 true");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const DashBoard()),
              (route) => false);
        } else {
          print("bug4 else");
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
                return const RegisterScreen();
              });
          //             // new user
        }
      },
    );
  }
}
