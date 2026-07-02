enum TransportMode {
  bus,
  tram,
  commuterRail,
  catamaran;

  String toJson() => name;
  static TransportMode fromJson(String value) {
    if (value == 'commuter_rail') return TransportMode.commuterRail;
    return TransportMode.values.byName(value);
  }

  String toDb() {
    if (this == TransportMode.commuterRail) return 'commuter_rail';
    return name;
  }
}

enum Direction {
  outbound,
  inbound;

  String toJson() => name;
  static Direction fromJson(String value) => Direction.values.byName(value);
  String toDb() => name;
}

enum DayType {
  weekday,
  saturday,
  holiday;

  String toJson() => name;
  static DayType fromJson(String value) => DayType.values.byName(value);
  String toDb() => name;
}
