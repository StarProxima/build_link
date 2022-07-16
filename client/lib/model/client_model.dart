class ClientModel {
  int clientID;
  int agentID;
  String firstName;
  String lastName;
  String patronymic;
  String phoneNumber;
  String note;
  String state;

  ClientModel(
    this.clientID,
    this.agentID,
    this.firstName,
    this.lastName,
    this.patronymic,
    this.phoneNumber,
    this.note,
    this.state,
  );

  static ClientModel fromJson(dynamic json) {
    return ClientModel(
      json["id"],
      json["id_agent"],
      json["firstname"],
      json["lastname"],
      json["patronymic"],
      json["number"],
      json["note"],
      json["state"],
    );
  }
}
