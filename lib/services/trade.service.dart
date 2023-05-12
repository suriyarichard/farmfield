import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class TradeService {
  var uid = FirebaseAuth.instance.currentUser?.uid;
  final TradeDocs = FirebaseFirestore.instance.collection("trade");

  Future<dynamic> get() async {
    List<Map> TradeCon = [];

    QuerySnapshot announcementSnapshot = await TradeDocs.get();

    announcementSnapshot.docs.forEach((doc) {
      TradeCon.add(doc.data() as Map);
    });
    return TradeCon;
  }

  Future<dynamic> add(context, announcement) async {
    announcement["uid"] = uid;
    await TradeDocs.add(announcement);
  }

  Future<dynamic> delete(announcementId) async {
    await TradeDocs.doc(announcementId).delete();
  }
}
