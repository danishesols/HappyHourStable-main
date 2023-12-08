import 'package:cloud_firestore/cloud_firestore.dart';

class HappyHourModel {
  String? id;
  String? hid;
  String? businessName;
  String? businessAddress;
  String? description;
  String? phoneNumber;
  String? businessCard;
  String? businessLogo;
  String? businessImage;
  String? menuImage;
  String? menuImage2;
  List? day;
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
  bool? promoted;
  String? status;
  String? showTime;
  List<String>? showTimeInCard;

  HappyHourModel(
    this.id,
    this.hid,
    this.businessName,
    this.businessAddress,
    this.description,
    this.phoneNumber,
    this.businessCard,
    this.businessLogo,
    this.businessImage,
    this.menuImage,
    this.menuImage2,
    this.day,
    this.dayLate,
    this.time,
    this.foodName,
    this.drinkitemName,
    this.amenities,
    this.barType,
    this.businessHour,
    this.latitude,
    this.longitude,
    this.reviewStar,
    this.countList,
    this.dailySpecils,
    this.event,
    this.fromTimeToTime,
    this.paid,
    this.addTime,
    this.promoted,
    this.status, {
    this.showTimeInCard,
        this.showTime,
  });

  HappyHourModel.fromJson(Map<String, dynamic> json, String id) {
    id = id;

    businessName = json['businessName'];
    businessAddress = json['businessAddress'];
    description = json['description'];
    phoneNumber = json['phonenumber'];
    businessCard = json['businessCard'];
    businessLogo = json['businessLogo'];
    businessImage = json['businessImage'];
    menuImage = json['menuImage'];
    menuImage2 = json['menuImage2'];
    day = json['day'];
    dayLate = json['day_late'] ?? [];
    time = json['time'];
    foodName = json['foodName'];
    drinkitemName = json['drinkitemName'];
    amenities = json['amenities'];
    barType = json['barType'];
    event = json['event'];
    fromTimeToTime = json['fromTimeToTime'];
    businessHour = json['businesshour'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    reviewStar = json['reviewStar'];
    countList = json['countList'];
    dailySpecils = json['dailyspecial'];
    paid = json['paid'] ?? "";
    addTime = json['addHappyhourTime'] ?? "";
    promoted = json['promoted'] ?? false;

    String? _status;
    if (json.keys.contains('status')) {
      _status = json['status'];
    }
    status = _status ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['businessName'] = businessName;
    data['businessAddress'] = businessAddress;
    data['description'] = description;
    data['phonenumber'] = phoneNumber;
    data['businessCard'] = businessCard;
    data['businessLogo'] = businessLogo;
    data['businessImage'] = businessImage;
    data['menuImage'] = menuImage;
    data['menuImage2'] = menuImage2;
    data['day'] = day;
    data['day_late'] = dayLate;
    data['time'] = time;
    data['foodName'] = foodName;
    data['drinkitemName'] = drinkitemName;
    data['amenities'] = amenities;
    data['barType'] = barType;
    data['event'] = event;
    data['fromTimeToTime'] = fromTimeToTime;
    data['businesshour'] = businessHour;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['reviewStar'] = reviewStar;
    data['countList'] = countList;
    data['dailyspecial'] = dailySpecils;
    data['promoted'] = promoted;
    String? _status;
    if (data.keys.contains('status')) {
      _status = data['status'];
    }
    status = _status == null || _status == '' ? 'pending' : _status;
    data['status'] = status;
    return data;
  }

  HappyHourModel.fromDoc(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['businessName'];
    businessAddress = json['businessAddress'];
    description = json['description'];
    phoneNumber = json['phonenumber'];
    businessCard = json['businessCard'];
    businessLogo = json['businessLogo'];
    businessImage = json['businessImage'];
    menuImage = json['menuImage'];
    menuImage2 = json['menuImage2'];
    day = json['day'];
    dayLate = json['day_late'];
    time = json['time'];
    foodName = json['foodName'];
    drinkitemName = json['drinkitemName'];
    amenities = json['amenities'];
    barType = json['barType'];
    event = json['event'];
    fromTimeToTime = json['fromTimeToTime'];
    businessHour = json['businesshour'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    reviewStar = json['reviewStar'];
    countList = json['countList'];
    dailySpecils = json['dailyspecial'];
    paid = json['paid'] ?? "";
    promoted = json['promoted'] ?? false;
    String? _status;
    if (json.keys.contains('status')) {
      _status = json['status'];
    }
    status = _status ?? '';
  }

  HappyHourModel.fromDocument(
      DocumentSnapshot<Map<String, dynamic>> json, String hids) {
    hid = hids;
    id = json['id'];
    businessName = json['businessName'];
    businessAddress = json['businessAddress'];
    description = json['description'];
    phoneNumber =
        json.data()!.containsKey("phonenumber") ? json['phonenumber'] : "";
    businessCard = json['businessCard'];
    businessLogo = json['businessLogo'];
    businessImage = json['businessImage'];
    menuImage = json['menuImage'];
    menuImage2 =
        json.data()!.containsKey("menuImage2") ? json['menuImage2'] : "";
    day = json['day'];
    dayLate = json.data()!.containsKey("day_late") ? json['day_late'] : [];
    time = json['time'];
    foodName = json['foodName'];
    drinkitemName =
        json.data()!.containsKey("drinkitemName") ? json['drinkitemName'] : [];
    amenities = json.data()!.containsKey("amenities") ? json['amenities'] : [];
    barType = json['barType'];
    event = json['event'];
    businessHour =
        json.data()!.containsKey("businesshour") ? json['businesshour'] : [];
    latitude = json['latitude'];
    longitude = json['longitude'];
    reviewStar =
        json.data()!.containsKey("reviewStar") ? json['reviewStar'] : [];
    countList = json.data()!.containsKey("countList") ? json['countList'] : [];
    dailySpecils = json['dailyspecial'];
    fromTimeToTime = json['fromTimeToTime'];
    promoted = false;
    String? _status;
    if (json.data()!.containsKey('status')) {
      _status = json['status'];
    }
    status = _status ?? '';
  }

  HappyHourModel.mapDocument(DocumentSnapshot json) {
    id = json['id'];
    businessName = json['businessName'];
    businessAddress = json['businessAddress'];
    description = json['description'];

    businessCard = json['businessCard'];
    businessLogo = json['businessLogo'];
    businessImage = json['businessImage'];
    menuImage = json['menuImage'];
    // menuImage2 = json['menuImage2'];
    day = json['day'];
    // dayLate = json['day_late'] ?? [];
    time = json['time'];
    foodName = json['foodName'];
    drinkitemName = json['drinkitemName'];
    // amenities = json['amenities'];
    barType = json['barType'];
    event = json['event'];
    // businessHour = json['businesshour'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    // reviewStar = json['reviewStar'];
    //countList = json['countList'];
    dailySpecils = json['dailyspecial'];
    fromTimeToTime = json['fromTimeToTime'];
    String? _status;
    if ((json.data()! as Map<String, dynamic>).containsKey('status')) {
      _status = json['status'];
    }
    status = _status ?? '';
    //paid = json['paid'] ?? "";
    // promoted = json['promoted'] ?? false;
  }
}
