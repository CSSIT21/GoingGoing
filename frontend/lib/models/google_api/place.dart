import '../location.dart';

class Place {
  final String name;
  final String address;
  final Location location;

  const Place({
    required this.name,
    required this.address,
    required this.location,
  });

  @override
  String toString() {
    return 'Place(location: $location, name: $name, address: $address)';
  }
}
