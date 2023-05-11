import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final userDocs = FirebaseFirestore.instance.collection("users");
  var uid = FirebaseAuth.instance.currentUser?.uid;

  Future<dynamic> get() async {
    List<Map> userData = [];

    QuerySnapshot userSnapshot = await userDocs.get();
    // await userDocs.get();
    userSnapshot.docs.forEach((doc) {
      userData.add(doc.data() as Map);
    });
    return userData;
  }
}

// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:villageadmin/models/userModel.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class UserService {
//   final usersCol = FirebaseFirestore.instance.collection("users");

//   Future get() async {
//     print(FirebaseAuth.instance.currentUser?.uid);
//     DocumentSnapshot doc =
//         await usersCol.doc(FirebaseAuth.instance.currentUser?.uid).get();

//     print("user service");
//     dynamic docData = null;
//     print("docData is ${doc.data().toString()}");
//     if (doc.exists) {
//       docData = doc.data() as Map<String, dynamic>;
//       print("docData is ${docData.toString()}");
//     } else {
//       print("user doc not exists");
//     }

//     // List<dynamic> data = docData["data"] as List<dynamic>;
//     // print("data is ${data.toString()}");

//     // List<Map<String, dynamic>> mapList =
//     //     data.map((item) => Map<String, dynamic>.from(item)).toList();

//     return docData;
//   }
// }
