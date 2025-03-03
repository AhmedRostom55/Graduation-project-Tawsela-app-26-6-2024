import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserData {
  final String firstName;
  final String lastName;
  final LatLng location;
  final String phone;
  final int? age;
  final String? email;
  const UserData(
      {required this.firstName,
      required this.lastName,
      required this.location,
      required this.phone,
      this.age,
      this.email});
}