import 'package:cloud_firestore/cloud_firestore.dart';

class HoursFavoriteModel {
  final String hid;
  final String businessName;
  final String description;
  final String menuImage;
  final String? businessImage;
  final String? businessAddress;
  final List? reviewList;
  final List? day;
  String? phoneNumber;
  String? businessCard;
  String? businessLogo;
  String? menuImage2;
  List? dayLate;
  List? time;
  List? foodName;
  List? drinkitemName;
  List? amenities;
  List? barType;
  List? event;
  List? businessHour;
  double? latitude;
  double? longitude;
  List? reviewStar;
  List? countList;
  List? dailySpecils;
  List? fromTimeToTime;
  String? paid;
  Timestamp? addTime;

  HoursFavoriteModel({
    required this.hid,
    required this.businessName,
    required this.description,
    required this.menuImage,
    this.businessImage,
    this.businessAddress,
    this.reviewList,
    this.day,
    this.phoneNumber,
    this.businessCard,
    this.businessLogo,
    this.menuImage2,
    this.dayLate,
    this.time,
    this.foodName,
    this.drinkitemName,
    this.amenities,
    this.barType,
    this.businessHour,
    this.latitude,
    this.longitude,
    this.countList,
    this.dailySpecils,
    this.event,
    this.fromTimeToTime,
    this.paid,
    this.addTime,
  });

  HoursFavoriteModel.fromJson(DocumentSnapshot<Map<String, Object?>> doc)
      : this(
          hid: doc.id,
          businessName: doc.data()!.containsKey("businessName")
              ? doc["businessName"] as String
              : "Name not Found",
          menuImage: doc.data()!.containsKey("menuImage")
              ? doc["menuImage"] as String
              : "",
          description: doc.data()!.containsKey("description")
              ? doc["description"] as String
              : "",
          businessAddress: doc.data()!.containsKey("businessAddress")
              ? doc['businessAddress'] as String
              : "",
          businessImage: doc.data()!.containsKey("businessImage")
              ? doc["businessImage"].toString()
              : "",
          businessCard: doc.data()!.containsKey("businessCard")
              ? doc["businessCard"].toString()
              : "",
          businessLogo: doc.data()!.containsKey("businessLogo")
              ? doc["businessLogo"].toString()
              : "",
          menuImage2: doc.data()!.containsKey("menuImage2")
              ? doc["menuImage2"].toString()
              : "",
          day: doc.data()!.containsKey("day") ? doc['day'] : [],
          dayLate: doc.data()!.containsKey("day_late") ? doc['day_late'] : [],
          reviewList:
              doc.data()!.containsKey("reviewStar") ? doc['reviewStar'] : [],
          time: doc.data()!.containsKey("time") ? doc['time'] : [],
          foodName: doc.data()!.containsKey("foodName") ? doc['foodName'] : [],
          drinkitemName: doc.data()!.containsKey("drinkitemName")
              ? doc['drinkitemName']
              : [],
          amenities:
              doc.data()!.containsKey("amenities") ? doc['amenities'] : [],
          barType: doc.data()!.containsKey("barType") ? doc['barType'] : [],
          event: doc.data()!.containsKey("event") ? doc['event'] : [],
          fromTimeToTime: doc.data()!.containsKey("fromTimeToTime")
              ? doc['fromTimeToTime']
              : [],
          businessHour: doc.data()!.containsKey("businesshour")
              ? doc['businesshour']
              : [],
          latitude: doc['latitude'],
          longitude: doc['longitude'],
          countList:
              doc.data()!.containsKey("countList") ? doc['countList'] : [],
          dailySpecils: doc.data()!.containsKey("foodNdailyspecialame")
              ? doc['dailyspecial']
              : [],
          paid: doc['paid'] ?? "",
          addTime: doc['addHappyhourTime'] ?? "",
        );
}
