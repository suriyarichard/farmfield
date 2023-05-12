import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CropService {
  var uid = FirebaseAuth.instance.currentUser?.uid;
  final cropData = FirebaseFirestore.instance.collection("crops");

  Future<dynamic> get() async {
    List<Map> cropList = [];

    // DocumentSnapshot userSnapshot = await historyData.doc(uid).get();

    // QuerySnapshot historySnapshot = await userSnapshot.reference
    //     .collection("calcu")
    //     .where("userId", isEqualTo: uid)
    //     .get();
    QuerySnapshot cropSnapshot = await cropData.get();

    cropSnapshot.docs.forEach((doc) {
      cropList.add(doc.data() as Map);
    });
    return cropList;
  }

  Future add(context, details) {
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    // final uid = FirebaseAuth.instance.currentUser?.uid;

    // UserDataModel user = userProvider.user as UserDataModel;
    // String villageId = user.villageId.replaceAll(' ', '');
    // details["uid"] = uid;
    // details["villageId"] = villageId;

    return FirebaseFirestore.instance
        .collection("crops")
        .add(details)
        .then((res) => {print("Successfully added")})
        .catchError((onError) => {print("Error ")});
  }
  // Future<dynamic> add(context, announcement) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   UserDataModel user = userProvider.user as UserDataModel;
  //   String villageId = user.villageId.replaceAll(' ', '');

  //   announcement["villageId"] = villageId;
  //   await announcementCol.add(announcement);
  // }

   Future<dynamic> dadd(context, phoneNumber) async {
    DocumentSnapshot phoneSnapshot = await cropData.doc(uid).get();

    if (phoneSnapshot.data() != null) {
      Map<String, dynamic> data = phoneSnapshot.data() as Map<String, dynamic>;
      List<dynamic> phoneNumbers = data["data"] as List<dynamic>;

      phoneNumbers.add(phoneNumber);
      cropData
          .doc(uid)
          .update(data)
          .then((DocumentSnapshot) => print("Phone Number Added"));
    }
  }
}
