import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InfoCropService {
  var uid = FirebaseAuth.instance.currentUser?.uid;
  final cropDatalist = FirebaseFirestore.instance.collection("timeline");

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

  Future add(context, details) {
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
}
