import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/data_models/trip_model/trip.dart';
import 'package:tawsela_app/models/data_models/user_request_model/request_model.dart';
import 'package:tawsela_app/models/data_models/uber_driver.dart';
import 'package:tawsela_app/models/data_models/user_states.dart';

class UberDriverState extends GoogleMapState {
  final UberDriver? driver;
  final List<UserRequest> passengerRequests;
  final UserRequest? acceptedRequest;
  final Trip? startedTrip;
  UberDriverState(
      {required super.controller,
      required UserState userState,
      required super.currentPosition,
      super.destination,
      this.startedTrip,
      super.currentLocationDescription,
      super.destinationDescription,
      required super.lines,
      required super.markers,
      required super.directions,
      required this.driver,
      this.passengerRequests = const [],
      this.acceptedRequest})
      : super(
          userState: UserState.DRIVER,
        );
}