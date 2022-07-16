class House {
  String description;
  String address;
  double squareMeters;
  int roomCount;
  double ceilingHeight;
  bool repair;
  double cost;
  String state;
  String housing_complex;
  String max_date;
  String min_date;

  House({
    required this.description,
    required this.address,
    required this.squareMeters,
    required this.roomCount,
    required this.ceilingHeight,
    required this.repair,
    required this.cost,
    required this.state,
    required this.housing_complex,
    required this.max_date,
    required this.min_date,
  });

  static House fromJson(dynamic json) {
    return House(
      description: json["description"] != null ? json["description"].trimRight() : "",
      address: json["address"] != null ? json["address"].trimRight() : "",
      squareMeters: json["square_meters"],
      roomCount: json["room_count"],
      ceilingHeight: json["ceiling_height"],
      repair: json["repair"],
      cost: json["cost"],
      state: json["status"] != null ? json["status"].trimRight() : "",
      housing_complex: json["housing_complex"] != null ? json["housing_complex"].trimRight() : "",
      max_date: json["max_date"] != null ? json["max_date"].trimRight() : "",
      min_date: json["min_date"] != null ? json["min_date"].trimRight() : "",
    );
  }

  String get title {
    return "$roomCount-к квартира $squareMeters м²";
  }
}
