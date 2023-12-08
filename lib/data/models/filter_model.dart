class FilterModel {
  String? day;
  String? time;
  String? keyWord;
  double? range;
  String? drink;
  String? food;
  String? amenity;
  String? event;
  String?city;
  String? bartype;
  double? lat;
  double?lng;
  String locationUnit;// for miles and kilometer

  FilterModel({
    this.day='',
    this.time='',
    this.keyWord='',
    this.range,
    this.drink='',
    this.food='',
    this.locationUnit='km',
    this.city='',
    this.amenity='',
    this.event='',
    this.lat,
    this.lng,
    this.bartype='',
  });
}
