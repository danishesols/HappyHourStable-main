import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class SearchProvider {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final geo = Geoflutterfire();
  Stream<List<DocumentSnapshot>> fetchHours(
      {required List<dynamic> foods, required double radius}) {
    var _queryRef = _firebase.collection("happyhours").where(
      "drinkitemName",
      arrayContainsAny: [
        "Mexican Beer",
        "Wine",
        // "Domestic",
        // "Pizza",
        // "Pool Table",
        // "Bar-Types",
      ],
    );

    GeoFirePoint center =
        geo.point(latitude: 33.704526937198345, longitude: 73.07165924459697);

    String field = 'position';

    return geo
        .collection(collectionRef: _queryRef)
        .within(center: center, radius: radius, field: field, strictMode: true);
  }
}
