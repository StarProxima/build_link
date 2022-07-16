class Client {
  String firstName;
  String lastName;
  String patronymic;
  String phoneNumber;
  String note;
  String state;

  Client(
    this.firstName,
    this.lastName,
    this.patronymic,
    this.phoneNumber,
    this.note,
    this.state,
  );

  static Client fromJson(dynamic json) {
    return Client(
      (json["firstname"] as String).trimRight(),
      (json["lastname"] as String).trimRight(),
      (json["patronymic"] as String).trimRight(),
      (json["number"] as String).trimRight(),
      (json["note"] as String).trimRight(),
      (json["status"] as String).trimRight(),
    );
  }
}
