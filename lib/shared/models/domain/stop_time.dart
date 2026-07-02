import '../enums.dart';

class StopTimeModel {
  final String tripId;
  final String stopId;
  final int sequence;
  final String arrivalTime;
  final String departureTime;
  final DayType dayType;

  StopTimeModel({
    required this.tripId,
    required this.stopId,
    required this.sequence,
    required this.arrivalTime,
    required this.departureTime,
    required this.dayType,
  });
}

class TripModel {
  final String id;
  final String routeId;
  final Direction direction;

  TripModel({required this.id, required this.routeId, required this.direction});
}
