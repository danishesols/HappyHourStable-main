import 'package:get/get.dart';
import 'package:happy_hour_app/data/models/happyhour_model.dart';
import 'package:happy_hour_app/data/providers/add_happyhour_provider.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessSearchResultController extends GetxController {
  final List<String> searchItem = Get.arguments[0];

  final List<HappyHourModel> hourSearch = Get.arguments[1];
  final List<HappyHourModel> citySearch = Get.arguments[2];

  final AddHappyHourProvider addHappyHourProvider = AddHappyHourProvider();
  List<HappyHourModel>? filterHours;
  // void clearSearchList() {
  //   searchItem.clear();
  // }

  void removeItem(index) {
    searchItem.removeAt(index);
    update();
  }

  onAdsTap(uri) {
    _launchURL(Uri.parse(uri));
  }

  void onDirectionTap(uri) {
    _launchURL(Uri.parse(uri));
  }

  void _launchURL(url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.find<GlobalGeneralController>().errorSnackbar(
        title: "Error",
        description: 'Could not Find Location $url',
      );
    }
  }
}

  // List<SearchModel> fetchList = [];
  // onDataGet() {
  //   addHappyHourProvider.fetchSearchHours().listen((hours) {
  //     fetchList.addAll(hours);
  //   });
  // }

  //  _addHappyHourProvider.fetchHours().listen(
  //     (hours) {
  //       for (final hour in hours) {
  //         addMarker = Marker(
  //           markerId: MarkerId(hour.name.toString()),
  //           infoWindow: InfoWindow(title: hour.name),
  //           position: LatLng(hour.latitude, hour.longitude),
  //           icon: BitmapDescriptor.fromBytes(mapMarker),
  //           //* we will use our oen icon there  BitmapDescriptor.fromBytes(mapMarker)
  //           onTap: () {
  //             // Get.toNamed(Routes.happyHourDetailScreen, arguments: hour);
  //           },
  //         );
  //       }
  //     },
  //   );

// get the collection reference or query
  // var collectionReference = FirebaseFirestore.instance.collection('locations');

  // double radius = 50;
  // String field = 'position';
  // GeoFirePoint center =
  //     Geoflutterfire().point(latitude: 12.960632, longitude: 77.641603);

  // Stream<List<DocumentSnapshot>> stream = Geoflutterfire()
  //     .collection(
  //         collectionRef: FirebaseFirestore.instance.collection('locations'))
  //     .within(
  //         center:
  //             Geoflutterfire().point(latitude: 12.960632, longitude: 77.641603),
  //         radius: 50,
  //         field: "Position");

  //                                   stream.listen((List<DocumentSnapshot> documentList) {
  //  return 0
  // });

  // final List<Map<String, dynamic>> _allUsers = Get.arguments;
  // List<Map<String, dynamic>> foundUser = [];

  // void filter(String word) {
  //   List<Map<String, dynamic>> results = [];
  //   if (word.isEmpty) {
  //     results = _allUsers;
  //   } else {
  //     results = _allUsers
  //         .where((element) =>
  //             element["name"].toLowerCase().contains(word.toLowerCase()))
  //         .toList();
  //   }
  //   foundUser = results;
  //   update();
  // }

  // @override
  // void onInit() {
  //   foundUser = _allUsers;
  //   print(_allUsers);
  //   super.onInit();
  // }

  // List<Map<String, dynamic>> searchresults = [];
  // void filter(String word) async {
  //   final result = await FirebaseFirestore.instance
  //       .collection("happyhours")
  //       .where("businessName", isEqualTo: word)
  //       .get();
  //   searchresults = result.docs.map((e) => e.data()).toList();

  //   print(searchresults);
  // }

  // @override
  // void onInit() {
  //   filter(Get.find<HappyHourFilterScreenController>().searchController.text);
  //   super.onInit();
  // }
  



// sortProperties() {
   
//     List<Property> properties =
//         List.from(Get.find<PropertiesController>().properties);
//     List<Property> pairedProperties = properties
//         .where((element) => element.propertyNumber == null
//             ? false
//             : element.propertyNumber!.split(",").length > 1)
//         .toList();
//     print(pairedProperties.length);
//     filteredProperties = properties
//         .where((element) => element.purpose == filter.purpose)
//         .toList();
//     if(filter.propertyType!= null) {
//       filteredProperties = filteredProperties!
//           .where((element) => element.propertyType == filter.propertyType)
//           .toList();
//     }
//     if (filter.city != null) {
//       filteredProperties = filteredProperties!
//           .where((element) => element.city == filter.city)
//           .toList();
//     }
//     if (filter.society != null) {
//       filteredProperties = filteredProperties!
//           .where((element) => element.society == filter.society)
//           .toList();
//     }
//     if (filter.propertySubType != null) {
//       filteredProperties = filteredProperties!
//           .where((element) => element.propertySubType == filter.propertySubType)
//           .toList();
//     }
//     if (minPrice.text != "") {
//       filteredProperties = filteredProperties!
//           .where((element) =>
//               double.parse(element.propertyPrice.toString()) >=
//               double.parse(minPrice.text))
//           .toList();
//     }
//     if (maxPrice.text != "") {
//       filteredProperties = filteredProperties!
//           .where((element) =>
//               double.parse(element.propertyPrice.toString()) <=
//               double.parse(maxPrice.text))
//           .toList();
//     }
//     if (filter.area != null && filter.areaType != null) {
//       if (filter.area!.isNotEmpty && filter.areaType!.isNotEmpty) {
//         double calculatingArea =
//             Property.getCalculatingArea(filter.areaType!, filter.area!);
//         filteredProperties = filteredProperties!
//             .where((element) => element.calculatingArea == calculatingArea)
//             .toList();
//       }
//     }

//     if (filter.phase != null) {
//       if (filter.phase!.isNotEmpty) {
//         filteredProperties = filteredProperties!
//             .where((element) =>
//                 element.phase!.toString().toLowerCase().trim().removeAllWhitespace ==
//                 filter.phase!.toLowerCase().trim().removeAllWhitespace)
//             .toList();
//       }
//     }
//     if (filter.block != null) {
//       if (filter.block!.isNotEmpty) {
//         filteredProperties = filteredProperties!
//             .where((element) =>
//                 element.block!.toLowerCase().trim() ==
//                 filter.block!.toLowerCase().trim())
//             .toList();
//       }
//     }
//     if (filter.sector != null) {
//       if (filter.sector!.isNotEmpty) {
//         filteredProperties = filteredProperties!
//             .where((element) =>
//                 element.sector!.toLowerCase().trim() ==
//                 filter.sector!.toLowerCase().trim())
//             .toList();
//       }
//     }
//     if (filter.road != null) {
//       if (filter.road!.isNotEmpty) {
//         filteredProperties = filteredProperties!
//             .where((element) =>
//                 element.road!.toLowerCase().trim() ==
//                 filter.road!.toLowerCase().trim())
//             .toList();
//       }
//     }
//     if (filter.street != null) {
//       if (filter.street!.isNotEmpty) {
//         filteredProperties = filteredProperties!
//             .where((element) =>
//                 element.street!.toLowerCase().trim() ==
//                 filter.street!.toLowerCase().trim())
//             .toList();
//       }
//     }

//      if (filter.bedrooms != null) {
//       if (filter.bedrooms!.isNotEmpty) {
//         filteredProperties = filteredProperties!
//             .where((element) => element.bedrooms == filter.bedrooms)
//             .toList();
//       }
//     }
//     if (filter.bathrooms != null) {
//       filteredProperties = filteredProperties!
//           .where((element) => element.bathrooms == filter.bathrooms)
//           .toList();
//     }
//     if (filter.floor != null) {
//       filteredProperties = filteredProperties!
//           .where((element) => element.floor == filter.floor)
//           .toList();
//     }
//     if (filter.propertyNumber != null) {
//       filteredProperties = filteredProperties!
//           .where((element) => element.propertyNumber == filter.propertyNumber)
//           .toList();
//     }

//     if (filter.features!.contains("Pair") ||
//         filter.features!.contains("Triple") ||
//         filter.features!.contains("Tetra")) {
//       filteredProperties = filteredProperties!
//           .where((element) =>
//               element.propertyNumber!.split(",").length == 2 &&
//                   filter.features!.contains("Pair") ||
//               element.propertyNumber!.split(",").length == 3 &&
//                   filter.features!.contains("Triple") ||
//               element.propertyNumber!.split(",").length == 4 &&
//                   filter.features!.contains("Tetra"))
//           .toList();
//       filter.features!.remove("Pair");
//       filter.features!.remove("Triple");
//       filter.features!.remove("Tetra");
//     }


//     if (filter.propertyStatus!.contains("Pair") ||
//         filter.propertyStatus!.contains("Triple") ||
//         filter.propertyStatus!.contains("Tetra")) {
//       filteredProperties = filteredProperties!
//           .where((element) =>
//       element.propertyNumber!.split(",").length == 2 &&
//           filter.propertyStatus!.contains("Pair") ||
//           element.propertyNumber!.split(",").length == 3 &&
//               filter.propertyStatus!.contains("Triple") ||
//           element.propertyNumber!.split(",").length == 4 &&
//               filter.propertyStatus!.contains("Tetra"))
//           .toList();
//       filter.propertyStatus!.remove("Pair");
//       filter.propertyStatus!.remove("Triple");
//       filter.propertyStatus!.remove("Tetra");
//     }



//     if (filter.features!.length > 0) {
//       filteredProperties = filteredProperties!
//           .where((element) =>
//               element.propertyFeatures!
//                   .toSet()
//                   .intersection(filter.features!.toSet())
//                   .length >
//               0)
//           .toList();
//     }


//     if (filter.propertyStatus!.length > 0) {
//       filteredProperties = filteredProperties!
//           .where((element) =>
//       element.status!
//           .toSet()
//           .intersection(filter.propertyStatus!.toSet())
//           .length >
//           0)
//           .toList();
//     }



//     List<Property> sortedProperties = [];
//     sortedProperties.addAll(
//         filteredProperties!.where((element) => element.featureType == 0));
//     sortedProperties.addAll(
//         filteredProperties!.where((element) => element.featureType == 1));
//     sortedProperties
//         .addAll(filteredProperties!.where((element) => !element.featured!));
//     // sortedProperties
//     //     .addAll(filteredProperties!.where((element) => element.featured!));
//     // sortedProperties
//     //     .addAll(filteredProperties!.where((element) => element.featureType == null));

//     filteredProperties!.clear();
//     filteredProperties!.addAll(sortedProperties);
//     Get.back();
//     update();
//   }