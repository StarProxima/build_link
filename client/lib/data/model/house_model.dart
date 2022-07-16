class House {
  String description;
  String address;
  double squareMeters;
  int roomCount;
  double ceilingHeight;
  bool repair;
  double cost;
  String state;
  String housingComplex;
  String maxDate;
  String minDate;
  String planUrl;
  List<String>? images;

  House({
    required this.description,
    required this.address,
    required this.squareMeters,
    required this.roomCount,
    required this.ceilingHeight,
    required this.repair,
    required this.cost,
    required this.state,
    required this.housingComplex,
    required this.maxDate,
    required this.minDate,
    required this.planUrl,
    required this.images,
  });

  static House fromJson(dynamic json, dynamic imageJson,) {
    List<String> readyJson = [];
    for (int i = 0; i < imageJson.length; i++ ) {
      readyJson.add((imageJson[i]).toString().trimRight());
    }
    
    return House(
      description: json["description"] != null ? json["description"].trimRight() : "",
      address: json["address"] != null ? json["address"].trimRight() : "",
      squareMeters: json["square_meters"],
      roomCount: json["room_count"],
      ceilingHeight: json["ceiling_height"],
      repair: json["repair"],
      cost: json["cost"],
      state: json["status"] != null ? json["status"].trimRight(): "",
      housingComplex: json["housing_complex"] != null ? json["housing_complex"].trimRight() : "",
      maxDate: json["max_date"] != null ? json["max_date"].trimRight() : "",
      minDate: json["min_date"] != null ? json["min_date"].trimRight() : "",
      planUrl: json["plan"] != null ? json["plan"].trimRight() : "",
      images: readyJson,
    );
  }

  String get title {
    return "$roomCount-к квартира $squareMeters м²";
  }
}
