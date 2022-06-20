import 'package:intl/intl.dart';
import '../schedule.dart';

// * Offer card info
class OfferCardInfo {
  final int scheduleId;
  final String name;
  final String date;
  final String time;
  final String carRegistration;
  final int partySize;
  final String address;
  final double distance;

  OfferCardInfo(Schedule schedule)
      : scheduleId = schedule.id!,
        name = schedule.destinationLocation.name,
        date = DateFormat('dd-MM-yyyy').format(schedule.startTripDateTime),
        time = DateFormat.jm().format(schedule.startTripDateTime),
        carRegistration = "TEMP-01", // TODO: get car registration
        partySize = schedule.party.maximumPassengers,
        address = schedule.destinationLocation.address,
        distance = schedule.distance;
}

// * Appointment card info
class AppointmentCardInfo {
  int scheduleId;
  String date;
  String time;
  String carRegistration;
  int partySize;
  String address;
  DateTime startTripDateTime;
  double distance;

  AppointmentCardInfo(Schedule schedule)
      : scheduleId = schedule.id!,
        date = DateFormat('dd-MM-yyyy').format(schedule.startTripDateTime),
        time = DateFormat.jm().format(schedule.startTripDateTime),
        carRegistration = "TEMP-02", // TODO: get car registration
        partySize = schedule.party.maximumPassengers,
        address = schedule.destinationLocation.address,
        startTripDateTime = schedule.startTripDateTime,
        distance = schedule.distance;
}
