import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneService {
  var uid = FirebaseAuth.instance.currentUser?.uid;
  final phoneCol = FirebaseFirestore.instance.collection("phone");

  Future<List<dynamic>> get(context) async {
    DocumentSnapshot phoneSnapshot = await phoneCol.doc(uid).get();

    List<dynamic> phoneNumbers = [];
    if (phoneSnapshot.exists) {
      Map<String, dynamic> data = phoneSnapshot.data() as Map<String, dynamic>;
      phoneNumbers = data["data"];
    } else {
      print('Document does not exist!');
    }
    return phoneNumbers;
  }

  Future<dynamic> add(context, phoneNumber) async {
    DocumentSnapshot phoneSnapshot = await phoneCol.doc(uid).get();

    if (phoneSnapshot.data() != null) {
      Map<String, dynamic> data = phoneSnapshot.data() as Map<String, dynamic>;
      List<dynamic> phoneNumbers = data["data"] as List<dynamic>;

      phoneNumbers.add(phoneNumber);
      phoneCol
          .doc(uid)
          .update(data)
          .then((DocumentSnapshot) => print("Phone Number Added"));
    }
  }

  Future<dynamic> delete(context, phoneNumber) async {
    DocumentSnapshot phoneSnapshot = await phoneCol.doc(uid).get();
    Map<String, dynamic> data = phoneSnapshot.data() as Map<String, dynamic>;
    data["data"].removeWhere((phone) => phone['phone'] == phoneNumber);
    await phoneCol.doc(uid).update(data);
  }
}
