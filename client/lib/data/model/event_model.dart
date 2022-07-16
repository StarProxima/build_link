class Event {
  String name;
  DateTime from;
  DateTime to;

  Event(this.name, this.from, this.to);

  String getFrom() {
    return "${from.hour < 10 ? "0" : ""}${from.hour}:${from.minute < 10 ? "0" : ""}${from.minute}";
  }

  String getTo() {
    return "${to.hour < 10 ? "0" : ""}${to.hour}:${to.minute < 10 ? "0" : ""}${to.minute}";
  }
}
