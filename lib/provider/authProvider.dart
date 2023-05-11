import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmfield/pallets/color.dart';
import 'package:farmfield/widgets/auth/login/verfiyOtp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  bool _isUserDocExist = false;
  bool get isUserDocExist => _isUserDocExist;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  AuthProvider() {
    checkSign();
  }
  void checkSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }

  // void signin() {}
  Future<void> signInWithPhone(BuildContext context, String phoneNumber) async {
    print("tyring to send OTP to $phoneNumber");
    try {
      _isLoading = true;
      notifyListeners();
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
            _isLoading = false;
            notifyListeners();
          },
          verificationFailed: (error) {
            print("OTP verificationFailed");
            print("OTP ${error.message}");
            _isLoading = false;
            notifyListeners();
            // throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            _isLoading = false;
            notifyListeners();
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: AppColor.bodyColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                elevation: 20,
                builder: (context) {
                  return VerifyOtpScreen(
                    verificationId: verificationId,
                    phone: phoneNumber,
                  );
                });
          },

          // Navigator.push(
          // context,
          // MaterialPageRoute(
          //   builder: (context) => GestureDetector(onTap: () {
          //     showModalBottomSheet(
          //         context: context,
          //         isScrollControlled: true,
          //         backgroundColor: AppColor.bodyColor,
          //         builder: (context) {
          //           return VerifyOtpScreen(
          //             verificationId: verificationId,
          //           );
          //         });
          //   }),
          // VerifyOtpScreen(verificationId: verificationId),
          //   ),
          // );
          // },
          codeAutoRetrievalTimeout: (verificationId) {
            _isLoading = false;
            notifyListeners();
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      _isLoading = false;
      notifyListeners();

      // showSnackBar(context, e.message.toString());
    }
  }

  // verify otp
  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);

      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;

      if (user != null) {
        // carry our logic
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      // showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future checkExistingUser() async {
    DocumentSnapshot snapshot = await _firebaseFirestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    print(FirebaseAuth.instance.currentUser?.uid);
    if (snapshot.exists) {
      print("USER EXISTS");
      _isUserDocExist = true;
    } else {
      print("NEW USER");
      _isUserDocExist = false;
    }
  }
}
