import 'package:get/get.dart';
import 'package:happy_hour_app/data/providers/favorite_provider.dart';

class FavoriteController extends GetxController {
  final FavoriteProvider favoriteProvider = FavoriteProvider();
  final _isloading = true.obs;
  bool get isLoading => _isloading.value;
  set isLoading(val) => _isloading.value = val;
}
