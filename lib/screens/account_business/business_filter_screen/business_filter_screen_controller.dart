import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/data/models/filter_model.dart';
import 'package:happy_hour_app/data/models/happyhour_model.dart';
import 'package:happy_hour_app/data/providers/add_happyhour_provider.dart';

class BusinessFilterScreenController extends GetxController {
  final searchController = TextEditingController();
  final AddHappyHourProvider addHappyHourProvider = AddHappyHourProvider();

  FilterModel filter = FilterModel();
  List<HappyHourModel> searchList = [];
  String days = "Sunday";
  String time = "01:00 PM";
  String distance = "mi";
  String drink = "Drinks";
  String food = "Foods";
  String amenities = "Amenities";
  String events = "Events";
  String barType = "BarType";

  List<String> searchListItem = [];

//============Fetch Radius List ============//
  final AddHappyHourProvider _addHappyHourProvider = AddHappyHourProvider();

  final RxList<HappyHourModel> _hoursRadiusList = <HappyHourModel>[].obs;
  List<HappyHourModel> get hoursInRadiusList => _hoursRadiusList;


  fetchHoursinRadius()async{
    Position currentLoc = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    _addHappyHourProvider
        .fetchHourInradius(
      lat: currentLoc.latitude,
      long: currentLoc.longitude,
      rad: range * 4,
    )
        .listen((hours) {
      List<HappyHourModel> _temp = [];
      for (var hour in hours) {
        _temp.add(
          HappyHourModel.fromDocument(
            hour as DocumentSnapshot<Map<String, dynamic>>,
            hour.id.toString(),
          ),
        );
      }
      _hoursRadiusList.value = _temp;
      if (kDebugMode) {
        print(_temp.length);
      }
    });
  }

  final Rx<double> _range = 10.0.obs;
  double get range => _range.value;
  set range(value) => _range.value = value;

  void setRange(double slide) {
    range = slide;
    fetchHoursinRadius();
    update();
  }

  Future<void> getAllHoursData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("happyhours").get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    //print("hfdsfkhdkjhskjhgfdf ghskjlfdhks");
    for (var element in allData) {
      HappyHourModel allHours =
          HappyHourModel.fromDoc(Map.from(element as Map));
      // var a = allHours.day!.where((e) => e['Hday']);
      // print(a);
      hoursModelList.add(allHours);
    }
  }

  @override
  void onInit() async {
    fetchHoursinRadius();
    await getAllHoursData();

    super.onInit();
  }

  final Rx<List<HappyHourModel>> _hourModelList = Rx<List<HappyHourModel>>([]);
  List<HappyHourModel> get hoursModelList => _hourModelList.value;
  set hoursModelList(value) => _hourModelList.value = value;

  //Filtered list
  final Rx<List<HappyHourModel>> _hourModelListFilter =
      Rx<List<HappyHourModel>>([]);
  List<HappyHourModel> get hoursCityListFilter => _hourModelListFilter.value;
  set hoursCityListFilter(value) => _hourModelListFilter.value = value;

  onSearch(String query) {
    // if (days.isNotEmpty) {
    //   for (var e in hoursModelList) {
    //     for (var day in e.day!) {
    //       if (day['Hday'].toLowerCase().toString() == days.toLowerCase()) {
    //         hoursCityListFilter = hoursModelList;
    //       }
    //     }
    //   }
    //   // hoursCityListFilter =
    //   //     hoursModelList.where((e) => e.day.toString() == days).toList();
    // }
    // if (time.isNotEmpty) {
    //   for (var e in hoursModelList) {
    //     for (var t in e.day!) {
    //       if (t['HfromTime'].toLowerCase().toString() == time.toLowerCase().toString()) {
    //         hoursCityListFilter = hoursModelList;
    //       }
    //     }
    //   }
    // }
    if (query.isNotEmpty) {
      hoursCityListFilter = hoursModelList.where((element) {
        return element.businessAddress!
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    } else {
      hoursCityListFilter = hoursModelList;
    }
  }

  var daysList = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  var timesList = [
    "01:00 AM",
    "02:00 AM",
    "03:00 AM",
    "04:00 AM",
    "05:00 AM",
    "06:00 AM",
    "07:00 AM",
    "08:00 AM",
    "09:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 AM",
    "01:00 PM",
    "02:00 PM",
    "03:00 PM",
    "04:00 PM",
    "05:00 PM",
    "06:00 PM",
    "07:00 PM",
    "08:00 PM",
    "09:00 PM",
    "10:00 PM",
    "11:00 PM",
    "12:00 PM",
  ];

  var distanceList = [
    'Mi',
    'Km',
  ];

  var drinkList = [
    "Domestic Beer",
    "Craft Beer",
    "Import Beer",
    "Mexican Beer",
    "Michelada",
    "Wine",
     "Old Fashion-Well",
     "Old Fashion- Premium",
    "Brandi",
    "You call it- Well",
    "You call it- Premium",
    "Mixed Drink- Well",
    "Mixed Drink- Premium",
    "Margarita-Well",
    "Margarita- Premium",
    "Martini- Well",
    "Martini- Premium",
    "Bloody Mary-Well",
    "Bloody Mary- Premium",
    "Mojito- Well",
    "Mojito- Premium",
    "Long Island- Well",
    "Long Island- Premium",
    "Pina Colada/ Daiquiri-Well",
    "Pina Colada/ Daiquiri- Premium",
    "Other Whisky/Bourbon Drink- Well",
    "Other Whisky/Bourbon Drink - Premium",
    "Other Vodka Drink- Well",
    "Other Vodka Drink- Premium",
    "Other Rum Drink- Well",
    "Other Rum Drink- Premium",
    "Other Gin Drink- Well",
    "Other Gin Drink- Premium",
    "Other Tequila/Mezcal Drink- Well",
    "Other Tequila/Mezcal Drink- Premium",
    "Sangria",
    "Sake",
    "Seltzer",
    "Mule",
  ];

  var foodsList = [
   "Bone in Wings",
    "Boneless Wings",
    "Pizza",
    "Flat Bread",
    "Burger",
    "Sliders",
    "Nachos",
    "Nachos- Ahi",
    "Tacos",
    "Taquitos/Flautas",
    "Quesadilla",
    "Fries",
    "Pretzels",
    "Garlic Bread/Knots/Cheese Bread",
    "Bruschetta",
    "Mozzarella Sticks",
    "Dip - Cheese",
    "Dip- Spinach and/or Artichoke",
    "Dip- Salsa",
    "Dip- Guacamole",
    "Dip- Hummus",
    "Chicken- Fried/Tenders",
    "Chicken- Grilled",
    "Chicken-Other",
    "Potatoes- Skins/Baked/Loaded",
    "Tater Tots-Plain/Loaded",
    "Chips/Crisps",
    "Onion Rings/Blossom",
    "Sprouts",
    "Zucchini",
    "Jalapeno Poppers",
    "Pickles- Fried",
    "Mac and Cheese Bites",
    "Combo Platter",
    "Egg Roll",
    "Dumpling/ Wonton/ Pot Sticker",
    "Pita",
    "Wrap",
    "Sandwich- Cold",
    "Sandwich- Hot",
    "Soup",
    "Salad",
    "Pasta- Ravioli/Spaghetti/Other",
    "Meatballs",
    "Meatloaf",
    "Kabab/Skewer",
    "Steak",
      "Prime Rib",
    "Ribs",
    "BBQ-Other",
    "Cheese and/or Meat Platter",
    "Olives",
    "Sushi- Roll/Sashimi/Nigiri/Handroll",
    "Poke",
     "Ceviche",
    "Edamame",
    "Calamari",
    "Shrimp",
    "Oysters",
    "Scallops",
    "Mussels",
        "Clams",
    "Crab- Cakes/Meat/Legs/Other",
      "Seafood-Other",
    "Fish and Chips",
    "Other Fish Dish",
    "Burrito",
    "Empanadas",
    "Tapas",
    "Meat Pie",
    "Mushrooms",
    "Hotdog/Corn Dog",
  ];

  var amenitiesList = [
    "Pool Table",
    "Dart Boards",
    "Juke Box",
    "Arcade",
    "Shuffle Board",
    "Board Games",
    "Outdoor Smoking",
    "Indoor Smoking",
    "No Smoking",
    "NFL Package",
    "NBA Package",
    "MLB Package",
    "Soccer/Football Package",
    "UFC PPV",
    "Boxing PPV",
    "Casino",
    "Large Screens",
    "Pool (Swimming)",
    "Outdoor Seating Assigned",
    "Outdoor Space Unassigned",
    "Beach/Water Front",
    "Amazing Views",
  ];

  List<Select> multiAmenitiesList = [
    Select(id: 1, name: "Pool Table"),
    Select(id: 2, name: "Dart Boards"),
    Select(id: 3, name: "Juke Box"),
    Select(id: 4, name: "Arcade"),
    Select(id: 5, name: "Shuffle Board"),
    Select(id: 6, name: "Board Games"),
    Select(id: 7, name: "Outdoor Smoking"),
    Select(id: 8, name: "Indoor Smoking"),
    Select(id: 9, name: "No Smoking"),
    Select(id: 10, name: "NFL Package"),
    Select(id: 12, name: "NBA Package"),
    Select(id: 13, name: "MLB Package"),
    Select(id: 14, name: "Soccer/Football Package"),
    Select(id: 15, name: "UFC PPV"),
    Select(id: 16, name: "Boxing PPV"),
    Select(id: 17, name: "Casino"),
    Select(id: 18, name: "Large Screens"),
    Select(id: 19, name: "Pool (Swimming)"),
    Select(id: 20, name: "Outdoor Seating Assigned"),
    Select(id: 21, name: "Outdoor Space Unassigned"),
    Select(id: 22, name: "Beach/Water Front"),
    Select(id: 23, name: "Amazing Views"),
  ];

  List<Select> multiEventList = [
    Select(id: 1, name: "Pool Tournament"),
    Select(id: 2, name: "Free Pool"),
    Select(id: 3, name: "Dart Tournament"),
    Select(id: 4, name: "Cornhole Tournament"),
    Select(id: 5, name: "Beer Pong Tournament"),
    Select(id: 6, name: "Other Tournament"),
    Select(id: 7, name: "Karaoke"),
    Select(id: 8, name: "Trivia Night"),
    Select(id: 9, name: "Live Music "),
    Select(id: 10, name: "Comedy Night"),
    Select(id: 12, name: "Open Mic"),
    Select(id: 13, name: "Paint and Sip"),
    Select(id: 14, name: "Ladies Night"),
    Select(id: 15, name: "Industry Night"),
  ];
  List<Select> multiBarList = [
    Select(id: 1, name: "Restaurant"),
    Select(id: 2, name: "Restaurant with Bar"),
    Select(id: 3, name: "Bar-Only"),
    Select(id: 4, name: "Bar with Food"),
    Select(id: 5, name: "Sports Bar"),
    Select(id: 6, name: "Brewery"),
    Select(id: 7, name: "Owner Owned"),
    Select(id: 8, name: "Corporate Owned"),
    Select(id: 9, name: "Dive"),
    Select(id: 10, name: "Upscale"),
    Select(id: 12, name: "Ulta High-End"),
    Select(id: 13, name: "Winery"),
    Select(id: 14, name: "Distillery"),
    Select(id: 15, name: "Pool Hall"),
    Select(id: 16, name: "Casino"),
    Select(id: 17, name: "Club"),
    Select(id: 18, name: "Strip Club"),
    Select(id: 19, name: "Roof Top"),
  ];

  List<Select> multiFoodList = [
 Select(id: 1, name: "Bone in Wings"),
    Select(id: 2, name: "Boneless Wings"),
    Select(id: 3, name: "Pizza"),
    Select(id: 4, name: "Flat Bread"),
    Select(id: 5, name: "Burger"),
    Select(id: 6, name: "Sliders"),
    Select(id: 7, name: "Nachos"),
    Select(id: 8, name: "Nachos- Ahi"),
    Select(id: 9, name: "Tacos"),
    Select(id: 10, name: "Taquitos/Flautas"),
    Select(
        id: 11,
        name:
            "Quesadilla"), // Updated spelling from "Margarita" as per your request
    Select(id: 12, name: "Fries"),
    Select(id: 13, name: "Pretzels"),
    Select(id: 14, name: "Garlic Bread/Knots/Cheese Bread"),
    Select(id: 15, name: "Bruschetta"),
    Select(id: 16, name: "Mozzarella Sticks"),
    Select(id: 17, name: "Dip - Cheese"),
    Select(id: 18, name: "Dip- Spinach and/or Artichoke"),
    Select(id: 19, name: "Dip- Salsa"),
    Select(id: 20, name: "Dip- Guacamole"),
    Select(id: 21, name: "Dip- Hummus"),
    Select(id: 22, name: "Chicken- Fried/Tenders"),
    Select(id: 23, name: "Chicken- Grilled"),
    Select(id: 24, name: "Chicken-Other"),
    Select(id: 26, name: "Potatoes- Skins/Baked/Loaded"),
    Select(id: 27, name: "Tater Tots-Plain/Loaded"),
    Select(id: 29, name: "Chips/Crisps"),
    Select(id: 30, name: "Onion Rings/Blossom"),
    Select(id: 31, name: "Sprouts"),
    Select(id: 32, name: "Zucchini"),
    Select(id: 33, name: "Jalapeno Poppers"),
    Select(id: 34, name: "Pickles- Fried"),
    Select(id: 35, name: "Mac and Cheese Bites"),
    Select(id: 36, name: "Combo Platter"),
    Select(id: 37, name: "Egg Roll"),
    Select(id: 38, name: "Dumpling/ Wonton/ Pot Sticker"),
    Select(id: 39, name: "Pita"),
    Select(id: 40, name: "Wrap"),
    Select(id: 41, name: "Sandwich- Cold"),
    Select(id: 42, name: "Sandwich- Hot"),
    Select(id: 43, name: "Soup"),
    Select(id: 44, name: "Salad"),
    Select(id: 45, name: "Pasta- Ravioli/Spaghetti/Other"),
    Select(id: 46, name: "Meatballs"),
    Select(id: 47, name: "Meatloaf"),
    Select(id: 48, name: "Kabab/Skewer"),
    Select(id: 49, name: "Steak"),
    Select(id: 50, name: "Prime Rib"),
    Select(id: 51, name: "Ribs"),
    Select(id: 28, name: "BBQ-Other"),
    Select(
        id: 52,
        name:
            "Cheese and/or Meat Platter"), // Updated spelling from "Cheese Plate/Platter" as per your request
    // Select(id: 51, name: "Cheese- Curds"), deleted
    Select(id: 53, name: "Olives"),
    Select(id: 54, name: "Sushi- Roll/Sashimi/Nigiri/Handroll"),
    Select(id: 55, name: "Poke"),
     Select(id: 56, name: "Ceviche"),
    Select(id: 57, name: "Edamame"),
    Select(id: 58, name: "Calamari"),
    Select(id: 59, name: "Shrimp"),
    Select(
        id: 60,
        name: "Oysters"), // Corrected spelling from "Oystersl" to "Oysters"
    Select(id: 61, name: "Scallops"),
    Select(id: 62, name: "Mussels"),
      Select(id: 63, name: "Clams"),
   
    Select(id: 64, name: "Crab- Cakes/Meat/Legs/Other"),
     Select(id: 65, name: "Seafood-Other"),
    // Select(id: 69, name: "Tater Tots-Plain/Loaded"), deleted
    Select(id: 66, name: "Fish and Chips"),
    Select(id: 67, name: "Other Fish Dish"),
    Select(id: 68, name: "Burrito"),
    Select(id: 69, name: "Empanadas"),
    Select(id: 70, name: "Tapas"),
    Select(id: 71, name: "Meat Pie"),
    Select(id: 72, name: "Mushrooms"),
    Select(id: 73, name: "Hotdog/Corn Dog"),
    // Added the missing item
  ];


  // List<Select> multiFoodList = [
  //   Select(id: 1, name: "Bone in Wings"),
  //   Select(id: 2, name: "Boneless Wings"),
  //   Select(id: 3, name: "Pizza"),
  //   Select(id: 4, name: "Flat Bread"),
  //   Select(id: 5, name: "Burger"),
  //   Select(id: 6, name: "Sliders"),
  //   Select(id: 7, name: "Nachos"),
  //   Select(id: 8, name: "Nachos Chicken/Steak"),
  //   Select(id: 9, name: "Nachos- Ahi"),
  //   Select(id: 10, name: "Tacos"),
  //   Select(id: 11, name: "Taquitos/Flautas"),
  //   Select(id: 12, name: "Quesadilla"),
  //   Select(id: 13, name: "Fries"),
  //   Select(id: 14, name: "Fries- Loaded"),
  //   Select(id: 15, name: "Pretzels"),
  //   Select(id: 16, name: "Garlic Bread/Knots"),
  //   Select(id: 17, name: "Cheese Bread"),
  //   Select(id: 18, name: "Bruschetta"),
  //   Select(id: 19, name: "Mozzarella Sticks"),
  //   Select(id: 20, name: "Dip - Cheese"),
  //   Select(id: 21, name: "Dip- Spinach"),
  //   Select(id: 22, name: "Dip- Salsa"),
  //   Select(id: 23, name: "Dip- Guacamole"),
  //   Select(id: 24, name: "Dip- Artichoke"),
  //   Select(id: 25, name: "Dip- Hummus"),
  //   Select(id: 26, name: "Chicken- Tenders"),
  //   Select(id: 27, name: "Chicken- Fried"),
  //   Select(id: 28, name: "Chicken- Grilled"),
  //   Select(id: 28, name: " Chicken-Other"),
  //   Select(id: 29, name: "Potato Skins"),
  //   Select(id: 30, name: "Potatos- Loaded"),
  //   Select(id: 31, name: "Tater Tots"),
  //   Select(id: 32, name: "Tater Tots- Loaded"),
  //   Select(id: 33, name: "Chips/Crisps"),
  //   Select(id: 34, name: "Onion Rings"),
  //   Select(id: 35, name: "Onion Blossom"),
  //   Select(id: 36, name: "Zucchini"),
  //   Select(id: 37, name: "Jalapeno Poppers"),
  //   Select(id: 38, name: "Pickles- Fried"),
  //   Select(id: 39, name: "Mac and Cheese Bites"),
  //   Select(id: 40, name: "Combo Platter"),
  //   Select(id: 41, name: "Egg Roll"),
  //   Select(id: 42, name: "Dumpling/ Wonton/ Pot Sticker"),
  //   Select(id: 43, name: "Pita"),
  //   Select(id: 44, name: "Wrap"),
  //   Select(id: 45, name: "Sandwich- Cold"),
  //   Select(id: 46, name: "Sandwich- Hot"),
  //   Select(id: 47, name: "Soup"),
  //   Select(id: 48, name: "Salad"),
  //   Select(id: 49, name: "Pasta"),
  //   Select(id: 50, name: "Ravioli"),
  //   Select(id: 51, name: "Meatballs"),
  //   Select(id: 52, name: "Meatloaf"),
  //   Select(id: 53, name: "Kabab/Skewer"),
  //   Select(id: 54, name: "Steak"),
  //   Select(id: 55, name: "Ribs"),
  //   Select(id: 56, name: "Cheese Plate/Platter"),
  //   Select(id: 56, name: " Cheese- Curds"),
  //   Select(id: 57, name: "Cheese and Meat Platter"),
  //   Select(id: 58, name: "Carpaccio"),
  //   Select(id: 59, name: "Sushi- Roll"),
  //   Select(id: 60, name: "Sushi- Sashimi or Nigiri"),
  //   Select(id: 61, name: "Sushi- Handroll"),
  //   Select(id: 62, name: "Sushi- Platter"),
  //   Select(id: 63, name: "Poke"),
  //   Select(id: 64, name: "Edamame"),
  //   Select(id: 65, name: "Calamari"),
  //   Select(id: 66, name: "Shrimp"),
  //   Select(id: 67, name: "Oystersl"),
  //   Select(id: 68, name: "Scallops"),
  //   Select(id: 69, name: "Mussels"),
  //   Select(id: 70, name: "Crab- Cakes"),
  //   Select(id: 71, name: "Crab- Meat"),
  //   Select(id: 72, name: "Crab- Leggs"),
  //   Select(id: 73, name: "Crab- Whole"),
  //   Select(id: 74, name: "Fish and Chips"),
  //   Select(id: 75, name: "Other Fish Dish"),
  //   Select(id: 76, name: "Burrito"),
  //   Select(id: 77, name: "Empanadas"),
  //   Select(id: 78, name: "Tapas"),
  //   Select(id: 79, name: "Meat Pie"),
  //   Select(id: 80, name: "Mushrooms"),
  //   Select(id: 81, name: "Hotdog/Corn Dog"),
  //   Select(id: 82, name: "Fondue"),
  // ];.
  var eventsList = [
    "Pool Tournament",
    "Free Pool",
    "Dart Tournament",
    "Cornhole Tournament",
    "Beer Pong Tournament",
    "Other Tournament",
    "Karaoke",
    "Trivia Night",
    "Live Music ",
    "Comedy Night",
    "Open Mic",
    "Paint and Sip",
    "Ladies Night",
    "Industry Night",
  ];

  var barList = [
    "Restaurant",
    "Restaurant with Bar",
    "Bar-Only",
    "Bar with Food",
    "Sports Bar",
    "Brewery",
    "Owner Owned",
    "Corporate Owned",
    "Dive",
    "Upscale",
    "Ulta High-End",
    "Winery",
    "Distillery",
    "Pool Hall",
    "Bowling Alley",
    "Casino",
    "Club",
    "Strip Club",
    "Roof Top",
  ];

  List<Select> multidrinkList = [
    Select(id: 1, name: "Domestic Beer"),
    Select(id: 2, name: "Craft Beer"),
    Select(id: 3, name: "Import Beer"),
    Select(id: 4, name: "Mexican Beer"),
    Select(id: 5, name: "Michelada"),
    Select(id: 6, name: "Wine"),
    Select(id: 7, name: "Brandi"),
    Select(id: 8, name: "You call it- Well"),
    Select(id: 9, name: "You call it- Premium"),
    Select(id: 10, name: "Mixed Drink- Well"),
    Select(id: 11, name: "Mixed Drink- Premium"),
    Select(id: 12, name: "Margarita-Well"),
    Select(id: 13, name: "Margarita- Premium"),
    Select(id: 14, name: "Martini- Well"),
    Select(id: 15, name: "Martini- Premium"),
    Select(id: 16, name: "Bloody Mary-Well"),
    Select(id: 17, name: "Bloody Mary- Premium"),
    Select(id: 18, name: "Mojito- Well"),
    Select(id: 19, name: "Mojito- Premium"),
    Select(id: 20, name: "Long Island- Well"),
    Select(id: 21, name: "Long Island- Premium"),
    Select(id: 22, name: "Pina Colada/ Daiquiri-Well"),
     Select(id: 23, name: "Pina Colada/ Daiquiri- Premium"),
    Select(id: 24, name: "Other Whisky/Bourbon Drink- Well"),
    Select(id: 25, name: " Other Whisky/Bourbon Drink - Premium"),
    Select(id: 26, name: "Other Vodka Drink- Well"),
    Select(id: 27, name: "Other Vodka Drink- Premium"),
    Select(id: 28, name: "Other Rum Drink- Well"),
    Select(id: 29, name: "Other Rum Drink- Premium"),
    Select(id: 30, name: "Other Gin Drink- Well"),
    Select(id: 31, name: "Other Gin Drink- Premium"),
    Select(id: 32, name: "Other Tequila/Mezcal Drink- Well"),
    Select(id: 33, name: "Other Tequila/Mezcal Drink- Premium"),
    Select(id: 34, name: "Sangria"),
    Select(id: 35, name: "Sake"),
    Select(id: 36, name: "Seltzer"),
    Select(id: 37, name: "Mule"),
  ];

  void addDrinkFromDropDownList(List<Select> p1) {
    for (var e in p1) {
      searchListItem.add(e.name);

      update();
    }
  }

  void addFoodFromDropDownList(List<Select> p1) {
    for (var e in p1) {
      searchListItem.add(e.name);

      update();
    }
  }

  void addAmenitiesFromDropDownList(List<Select> p1) {
    for (var e in p1) {
      searchListItem.add(e.name);

      update();
    }
  }

  void addEventFromDropDownList(List<Select> p1) {
    for (var e in p1) {
      searchListItem.add(e.name);

      update();
    }
  }

  void addBarTypeFromDropDownList(List<Select> p1) {
    for (var e in p1) {
      searchListItem.add(e.name);

      update();
    }
  }
}

//==============*New Search Method *================//

class Select {
  final int id;
  final String name;

  Select({
    required this.id,
    required this.name,
  });
}
