// import 'package:cloud_firestore/cloud_firestore.dart';

// class SearchModel {
//   String? id;
//   String? businessName;
//   String? businessAddress;
//   String? description;
//   String? phoneNumber;
//   String? businessCard;
//   String? businessLogo;
//   String? businessImage;
//   String? menuImage;
//   List? day;
//   List? time;
//   List? foodName;
//   List? drinkitemName;
//   List? amenities;
//   List? barType;
//   String? eventname;
//   String? eventday;
//   String? eventtime;
//   List? businessHour;
//   double? latitude;
//   double? longitude;
//   List? reviewText;

//   SearchModel(
//     this.id,
//     this.businessName,
//     this.businessAddress,
//     this.description,
//     this.phoneNumber,
//     this.businessCard,
//     this.businessLogo,
//     this.businessImage,
//     this.menuImage,
//     this.day,
//     this.time,
//     this.foodName,
//     this.drinkitemName,
//     this.amenities,
//     this.barType,
//     this.eventname,
//     this.eventday,
//     this.eventtime,
//     this.businessHour,
//     this.latitude,
//     this.longitude,
//     this.reviewText,
//   );

//   SearchModel.fromDocument(DocumentSnapshot doc) {
//     id = doc.id;
//     businessName = doc['businessName'];
//     businessAddress = doc['businessAddress'];
//     description = doc['description'];
//     // phoneNumber = doc['phonenumber'];
//     businessCard = doc['businessCard'];
//     businessLogo = doc['businessLogo'];
//     businessImage = doc['businessImage'];
//     menuImage = doc['menuImage'];
//     day = doc['day'];
//     time = doc['time'];
//     foodName = doc['foodName'];
//     drinkitemName = doc['drinkitemName'];
//     amenities = doc['amenities'];
//     barType = doc['barType'];
//     //eventname = doc['eventname'];
//     //eventday = doc['eventday'];
//     // eventtime = doc['eventtime'];
//     // businessHour = doc['businesshour'];
//     latitude = doc['latitude'];
//     longitude = doc['longitude'];
//     // reviewText = doc['ReviewText'];
//   }
// }
