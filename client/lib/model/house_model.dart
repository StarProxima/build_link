class HouseModel {
  String name;
  String address;
  double squareMeters;
  int roomCount;
  double ceilingHeight;
  bool repair;
  double cost;
  String state;

  HouseModel(
    this.name,
    this.address,
    this.squareMeters,
    this.roomCount,
    this.ceilingHeight,
    this.repair,
    this.cost,
    this.state,
  );

  static HouseModel fromJson(dynamic json) {
    return HouseModel(
      json["name"],
      json["address"],
      json["square_meters"],
      json["room_count"],
      json["ceiling_height"],
      json["repair"],
      json["cost"],
      json["status"],
    );
  }
}
