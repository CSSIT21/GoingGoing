import 'package:flutter/foundation.dart';
import 'package:going_going_frontend/models/home/information.dart';

class ScheduleProvider with ChangeNotifier {
  // List<OfferCardInfo> _histories = List.empty();
  // List<AppointmentCardInfo> _appointments = List.empty();
  List<AppointmentCardInfo> _appointments = [
    AppointmentCardInfo(
        id: 0,
        type: "pending",
        date: "2022-05-30",
        time: "01:00 PM",
        carRegistration: "AB-9316",
        partySize: 5,
        address: "address1",
        startTripDateTime: DateTime.parse("2022-05-30 13:00:00.000"),
        distance: 10.00),
    AppointmentCardInfo(
        id: 0,
        type: "confirmed",
        date: DateTime.now()
            .add(const Duration(hours: 2))
            .toString()
            .substring(0, 10),
        time:
            "${DateTime.now().add(const Duration(hours: 2)).toString().substring(11, 16)} PM",
        carRegistration: "CD-2290",
        partySize: 4,
        address: "address2",
        startTripDateTime: DateTime.now().add(const Duration(hours: 2)),
        distance: 20.00)
  ];
  List<OfferCardInfo> _histories = [
    OfferCardInfo(
        id: 0,
        name: "KMUTT, Bangmod",
        date: "23-03-2022",
        time: "6.00 PM",
        carRegistration: "AB-9316",
        partySize: 4,
        address: "KMUTT,  Pracha Uthit Rd.",
        distance: 100),
    OfferCardInfo(
        id: 1,
        name: "Seacon Bangkae",
        date: "23-03-2022",
        time: "6.00 PM",
        carRegistration: "AB-9316",
        partySize: 4,
        address: "Bangkae",
        distance: 10.00),
    OfferCardInfo(
        id: 2,
        name: "KMUTT, CS@SIT",
        date: "23-03-2022",
        time: "6.00 PM",
        carRegistration: "AB-9316",
        partySize: 4,
        address: "KMUTT,  Pracha Uthit Rd.",
        distance: 10.00)
  ];
  double _total = 0;
  double _price = 0;
  int _partySize = 0;

  List<AppointmentCardInfo> get appointments => _appointments;

  List<OfferCardInfo> get histories => _histories;

  double get total => _total;

  double get price => _price;

  int get partySize => _partySize;

  set appointments(List<AppointmentCardInfo> value) {
    _appointments = value;
    notifyListeners();
  }

  set histories(List<OfferCardInfo> value) {
    _histories = value;
    notifyListeners();
  }

  set total(double value) {
    _total = value;
    notifyListeners();
  }

  set price(double value) {
    _price = value;
  }

  set partySize(int value) {
    _partySize = value;
    notifyListeners();
  }

  void totalAndPrice(double distance) {
    _total = distance * 35.00;
    _price = _total / _partySize;
    notifyListeners();
  }
}
