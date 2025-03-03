import 'package:tawsela_app/models/data_models/user_data.dart';

class UberDriver extends UserData {
  final double rating;
  UberDriver(
      {required this.rating,
      required super.firstName,
      required super.lastName,
      required super.location,
      required super.phone,
      super.age,
      super.email});
}