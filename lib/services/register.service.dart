// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

class RegisterService {
  final usersCol = FirebaseFirestore.instance.collection("users");

  Future<dynamic> add(register) async {
    register["uid"] = FirebaseAuth.instance.currentUser?.uid;
    register["phone"] = FirebaseAuth.instance.currentUser?.phoneNumber;

    await usersCol.doc(FirebaseAuth.instance.currentUser?.uid).set(register);
  }
}
