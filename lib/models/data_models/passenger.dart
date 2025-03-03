import 'package:tawsela_app/models/data_models/user_data.dart';

class Passenger extends UserData {
  Passenger(
      {required super.firstName,
      required super.lastName,
      required super.location,
      required super.phone,
       super.age,
       super.email});
}