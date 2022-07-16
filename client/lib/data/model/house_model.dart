class House {
  String name;
  String address;
  double squareMeters;
  int roomCount;
  double ceilingHeight;
  bool repair;
  double cost;
  String state;

  House({
    required this.name,
    required this.address,
    required this.squareMeters,
    required this.roomCount,
    required this.ceilingHeight,
    required this.repair,
    required this.cost,
    required this.state,
  });

  static House fromJson(dynamic json) {
    return House(
      name: json["name"] != null ? json["name"].trimRight() : "",
      address: json["address"] != null ? json["address"].trimRight(): "",
      squareMeters: json["square_meters"],
      roomCount: json["room_count"],
      ceilingHeight: json["ceiling_height"],
      repair: json["repair"],
      cost: json["cost"],
      state: json["status"] != null ? json["status"].trimRight(): "",
    );
  }
}
