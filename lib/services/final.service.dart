import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class CropServiceF {
  final cropData = FirebaseFirestore.instance.collection('users');
  var uid = FirebaseAuth.instance.currentUser?.uid;

  Future<dynamic> get() async {
    List<dynamic> cropList = [];

    DocumentSnapshot cropSnapshot = await cropData.doc(uid).get();
    if (cropSnapshot.exists) {
      Map<String, dynamic> data = cropSnapshot.data() as Map<String, dynamic>;
      cropList = data['crop'];
      
    } else {
      print("object");
    }
    return cropList;
  }

  Future<dynamic> add(context, phoneNumber) async {
    DocumentSnapshot phoneSnapshot = await cropData.doc(uid).get();

    if (phoneSnapshot.data() != null) {
      Map<String, dynamic> data = phoneSnapshot.data() as Map<String, dynamic>;
      List<dynamic> phoneNumbers = data["crop"] as List<dynamic>;

      phoneNumbers.add(phoneNumber);
      cropData
          .doc(uid)
          .update(data)
          .then((DocumentSnapshot) => print("Phone Number Added"));
    }
  }

// Add timeline
  Future<dynamic> addTime(context, cropname, name, amount) async {
    DocumentSnapshot cropDatas = await cropData.doc(uid).get();
int? number = int.tryParse(amount);

    Map<String, dynamic> timelineData = {
      'name': name,
      'amount': number,
      'createdAt': DateTime.now(),
    };
      print("timelineData $timelineData ");


    if (cropData != null) {
      List<dynamic> crops = cropDatas["crop"] as List<dynamic>;

      for (int i = 0; i < crops.length; i++) {
        var crop = crops[i];
        if (crop['cropname'] == cropname) {
          // print("jjd${crop['cropname'] == cropname}");
          crop['timeline'].add(timelineData);

        

          int totalAmt = 0;
          var timelinehistory = crop['timeline'];
          for (var timeline in timelinehistory) {
            if (timeline.containsKey('amount') && timeline['amount'] is int) {
              totalAmt += timeline['amount'] as int;
            }
          }
          

          // if(crop.containsKey('totalAmount')){
          //   totalAmt = crop['totalAmount'];
          // }
          crop['totalAmount']= totalAmt;


          print("amount $totalAmt ");

        // if(crops.containsKey('totalAmount')) {}



        }
      }
      print("Crops $crops");



      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'crop': crops})
          .then((_) => print("Data added to the timeline"))
          .catchError((error) => print("Error updating document: $error"));
    }
  }

  // Future<dynamic> addTime(context, phoneNumber, cropname) async {
  //   DocumentSnapshot phoneSnapshot = await cropData.doc(uid).get();

  //   if (phoneSnapshot.data() != null) {
  //     Map<String, dynamic> data = phoneSnapshot.data() as Map<String, dynamic>;
  //     List<dynamic> phoneNumbers = data["crop"] as List<dynamic>;
  //     for (int i = 0; i < phoneNumbers.length; i++) {
  //       var item = phoneNumbers[i];
  //       if (item['cropname'] == cropname) {
  //         item['timeline'].add(phoneNumber);
  //       }
  //     }
  //     phoneNumbers.add(phoneNumber);
  //     cropData
  //         .doc(uid)
  //         .update(data)
  //         .then((DocumentSnapshot) => print("Added for u"));
  //   }
  // }

  Future<dynamic> getTime() async {
    List<dynamic> cropList = [];

    DocumentSnapshot cropSnapshot = await cropData.doc(uid).get();
    if (cropSnapshot.exists) {
      Map<String, dynamic> data = cropSnapshot.data() as Map<String, dynamic>;
      cropList = data['crop'];
      for (int i = 0; i < data.length; i++) {
        var item = data[i];
        print("ssh ${data[0]}");
      }
    } else {
      print("object");
    }
    return cropList;
  }
}
