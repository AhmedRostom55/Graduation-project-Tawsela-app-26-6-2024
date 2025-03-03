import 'package:google_directions_api/google_directions_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/data_models/passenger.dart';
import 'package:tawsela_app/models/data_models/uber_driver.dart';
import 'package:tawsela_app/models/data_models/user_request_model/request_model.dart';
import 'package:tawsela_app/models/data_models/user_states.dart';

class PassengerState extends GoogleMapState {
  final Passenger passengerData;
  final UberDriver? driverData;
  final UserRequest? passengerRequest;
  PassengerState({
    required GoogleMapController? controller,
    required LatLng currentPosition,
    this.driverData,
    this.passengerRequest,
    LatLng? destination,
    String currentLocationDescription = 'Unknown',
    String destinationDescription = 'Unknown',
    required List<Polyline> lines,
    required Set<Marker> markers,
    required List<Step> directions,
    required this.passengerData,
  }) : super(
            controller: controller,
            currentPosition: currentPosition,
            lines: lines,
            markers: markers,
            directions: directions,
            destination: destination,
            currentLocationDescription: currentLocationDescription,
            destinationDescription: destinationDescription,
            userState: UserState.DRIVER);
}