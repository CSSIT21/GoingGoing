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

  OfferCardInfo(Schedule schedule, String carRegis, {bool maxSize = false})
      : scheduleId = schedule.id!,
        name = schedule.destinationLocation.name,
        date = DateFormat('dd-MM-yyyy').format(schedule.startTripDateTime),
        time = DateFormat.jm().format(schedule.startTripDateTime),
        carRegistration = carRegis,
        partySize = maxSize
            ? (schedule.party.maximumPassengers + 1)
            : (schedule.party.passengerIds.length + 1),
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

  AppointmentCardInfo(Schedule schedule, String carRegis)
      : scheduleId = schedule.id!,
        date = DateFormat('dd-MM-yyyy').format(schedule.startTripDateTime),
        time = DateFormat.jm().format(schedule.startTripDateTime),
        carRegistration = carRegis,
        partySize = (schedule.party.passengerIds.length + 1),
        address = schedule.destinationLocation.address,
        startTripDateTime = schedule.startTripDateTime,
        distance = schedule.distance;
}
