import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InfoCropService {
  var uid = FirebaseAuth.instance.currentUser?.uid;
  final cropDatalist = FirebaseFirestore.instance.collection("cropss");

  Future<dynamic> get() async {
    List<Map> cropList = [];

    // DocumentSnapshot userSnapshot = await historyData.doc(uid).get();

    // QuerySnapshot historySnapshot = await userSnapshot.reference
    //     .collection("calcu")
    //     .where("userId", isEqualTo: uid)
    //     .get();
    QuerySnapshot cropSnapshot = await cropDatalist.get();

    cropSnapshot.docs.forEach((doc) {
      cropList.add(doc.data() as Map);
    });
    return cropList;
  }

  Future adds(context, details) {
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    // final uid = FirebaseAuth.instance.currentUser?.uid;

    // UserDataModel user = userProvider.user as UserDataModel;
    // String villageId = user.villageId.replaceAll(' ', '');
    // details["uid"] = uid;
    // details["villageId"] = villageId;

    return FirebaseFirestore.instance
        .collection("timeline")
        .add(details)
        .then((res) => {print("Successfully added")})
        .catchError((onError) => {print("Error ")});
  }

  Future<dynamic> adddd(context, register) async {
    register["uid"] = FirebaseAuth.instance.currentUser?.uid;
    register["phone"] = FirebaseAuth.instance.currentUser?.phoneNumber;

    await cropDatalist
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(register);
  }

  Future<dynamic> add(context, phoneNumber) async {
    DocumentSnapshot phoneSnapshot = await cropDatalist.doc(uid).get();

    if (phoneSnapshot.data() != null) {
      Map<String, dynamic> data = phoneSnapshot.data() as Map<String, dynamic>;
      List<dynamic> phoneNumbers = data["crop"] as List<dynamic>;

      phoneNumbers.add(phoneNumber);
      cropDatalist
          .doc(uid)
          .update(data)
          .then((DocumentSnapshot) => print("Phone Number Added"));
    }
  }
}
