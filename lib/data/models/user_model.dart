import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String uid;
  late String username;
  late String email;
  late String? firstName;
  late String? lastName;
  late String? mobilenumber;
  late String? profileImage;
  late List<dynamic> favoriteHours;
  late List<dynamic> claimHours;
  late bool hasSubscription;
  late bool isBusiness;
  late bool? isAccountSuspended;
  late String? stripeCustomerId;
  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    this.firstName,
    this.lastName,
    this.mobilenumber,
    this.profileImage,
    required this.claimHours,
    required this.favoriteHours,
    required this.isBusiness,
    this.isAccountSuspended,
    required this.hasSubscription,
    this.stripeCustomerId,
  });

  UserModel.fromDocument(DocumentSnapshot<Map<String, Object?>> doc) {
    uid = doc.id;
    username =
        doc.data()!.containsKey("username") ? doc["username"] as String : "";
    email = doc.data()!.containsKey("email") ? doc["email"] as String : "";
    firstName =
        doc.data()!.containsKey('firstname') ? doc["firstname"] ?? "" : "";
    lastName = doc.data()!.containsKey('lastname') ? doc["lastname"] ?? '' : "";
    mobilenumber = doc.data()!.containsKey('mobilenumber')
        ? doc["mobilenumber"] as String
        : "";
    profileImage = doc.data()!.containsKey('profile_image')
        ? doc["profile_image"] ?? ''
        : "";
    favoriteHours = doc.data()!.containsKey("favorite_hours")
        ? doc["favorite_hours"] as List<dynamic>
        : [];
    claimHours = doc.data()!.containsKey("claim_hours")
        ? doc["claim_hours"] as List<dynamic>
        : [];
    isBusiness = doc.data()!.containsKey("isBusiness")
        ? doc["isBusiness"] as bool
        : false;

    isAccountSuspended = doc.data()!.containsKey("isAccountSuspended")
        ? doc["isAccountSuspended"] as bool
        : false;
    isAccountSuspended = isAccountSuspended ?? false;

    hasSubscription = doc.data()!.containsKey("has_subscription")
        ? doc["has_subscription"] as bool
        : false;
    stripeCustomerId = doc.data()!.containsKey("stripe_customer_id")
        ? doc["stripe_customer_id"] as String
        : "";
  }
}


//
// Active Specials. Please make sure the current updates on the times for Active Specials are applied to all three accounts. Guest account does not show the updates and please verify Standard account is up to date.
//
// There are still errors on Active Special page but we will come back to it after we fix the other issues.
//
// When someone signs up for an account on Standard or Business I specifically asked you to put "Upload Profile Picture". That is not what you did...see attached image. Please fix for both sign up types. Plus get rid of the words "Please Enter the Details".
//
// I tested signing up for a standard account. It still requires an image. It should not require this. Its should keep the default image if no new image is picked. I also tested business account signup. This did not require an image but it did not keep the default image if no new image was picked.
//
// Flagging Issue. I think there is a miss understanding. A picture is not required. Basically text is requires in the text part or an image. If someone writes something then an image is not required.
//
// On the Favorite page for Standard and Business accounts. If the business has an Active Time (Happy Hour, Late Happy Hour or Daily Special) it can show that time (similar to Active special page except the Favorites do not disappear if no time is Active).
//
// Please still work on these:
// 6. The point about the claim is still remaining which will be worked on tomorrow.
// 7. Side menu on the business account to see their claimed businesses, this point is remaining and will be worked on tomorrow.
//
// Lastly I have updated the food list. I condensed it to a smaller list. Can you please update in all the places needed.
//
// Food
//
// Bone in Wings
//
// Boneless Wings
//
// Pizza
//
// Flat Bread
//
// Burger
//
// Sliders
//
// Nachos
//
// Nachos Chicken/Steak-Delete
//
// Nachos- Ahi
//
// Tacos
//
// Taquitos/Flautas
//
// Quesadilla On the App this Says Margarita can you update the spelling to Quesadilla. Just update text…do not delete and make a new item.
//
// Fries
//
// Fries- Loaded-Delete
//
// Pretzels
//
// Garlic Bread/Knots/Cheese Bread
//
// Cheese Bread-Delete
//
// Bruschetta
//
// Mozzarella Sticks
//
// Dip – Cheese
//
// Dip- Spinach and/or Artichoke
//
// Dip- Salsa
//
// Dip- Guacamole
//
// Dip- Artichoke-Delete
//
// Dip- Hummus
//
// Chicken- Tenders-Delete
//
// Chicken- Fried/Tenders
//
// Chicken- Grilled
//
// Potato Skins-Delete
//
// Potatoes- Skins/Baked/Loaded
//
// Tater Tots-Plain/Loaded
//
// Tater Tots- Loaded-Delete
//
// Chips/Crisps
//
// Onion Rings/Blossom
//
// Onion Blossom-Delete
//
// Zucchini
//
// Jalapeno Poppers
//
// Pickles- Fried
//
// Mac and Cheese Bites
//
// Combo Platter
//
// Egg Roll
//
// Dumpling/ Wonton/ Pot Sticker
//
// Pita
//
// Wrap
//
// Sandwich- Cold
//
// Sandwich- Hot
//
// Soup
//
// Salad
//
// Pasta- Ravioli/Spaghetti/Other
//
// Ravioli-Delete
//
// Meatballs
//
// Meatloaf
//
// Kabab/Skewer
//
// Steak
//
// Ribs
//
// BBQ-Other
//
// Cheese Plate/Platter-Delete
//
// Cheese and/or Meat Platter
//
// Carpaccio-Delete
//
// Sushi- Roll/Sashimi/Nigiri/Handroll
//
// Sushi- Sashimi or Nigiri-Delete
//
// Sushi- Handroll-Delete
//
// Sushi- Platter-Delete
//
// Poke
//
// Edamame
//
// Calamari
//
// Shrimp
//
// Oysters
//
// Scallops
//
// Mussels
//
// Crab- Cakes/Meat/Legs/Other
//
// Crab- Meat-Delete
//
// Crab- Leggs-Delete
//
// Crab- Whole-Delete
//
// Fish and Chips
//
// Other Fish Dish
//
// Burrito
//
// Empanadas
//
// Tapas
//
// Meat Pie
//
// Mushrooms
//
// Hotdog/Corn Dog
//
// Fondue