class ClientModel {
  String firstName;
  String lastName;
  String patronymic;
  String phoneNumber;
  String note;
  String state;

  ClientModel(
    this.firstName,
    this.lastName,
    this.patronymic,
    this.phoneNumber,
    this.note,
    this.state,
  );

  static ClientModel fromJson(dynamic json) {
    return ClientModel(
      (json["firstname"] as String).trimRight(),
      (json["lastname"] as String).trimRight(),
      (json["patronymic"] as String).trimRight(),
      (json["number"] as String).trimRight(),
      (json["note"] as String).trimRight(),
      (json["status"] as String).trimRight(),
    );
  }
}
