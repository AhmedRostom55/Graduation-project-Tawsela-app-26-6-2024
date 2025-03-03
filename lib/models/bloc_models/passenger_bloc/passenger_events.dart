import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';
import 'package:tawsela_app/models/data_models/user_request_model/request_model.dart';

abstract class PassengerEvent extends GoogleMapEvent {
  const PassengerEvent();
}

class GetNearestPathToServiceLine extends PassengerEvent {
  const GetNearestPathToServiceLine();
}

class RequestUberDriver extends PassengerEvent {
  final UserRequest passengerRequest;
  const RequestUberDriver({required this.passengerRequest});
}

class GetWalkDirections extends PassengerEvent {
  final LatLng passengerDestination;
  const GetWalkDirections({required this.passengerDestination});
}

class GetDestination extends PassengerEvent {
  final LatLng destination;
  final String destinationDescription;
  const GetDestination(
      {required this.destination, required this.destinationDescription});
}

class ShowAllLines extends PassengerEvent {
  const ShowAllLines();
}

class ShowLine extends PassengerEvent {
  final int lineNumber;
  const ShowLine(this.lineNumber);
}

class CancelUberRequest extends PassengerEvent {
  const CancelUberRequest();
}

class DriverCancelledRequest extends PassengerEvent {
  const DriverCancelledRequest();
}

class DriverEndedTrip extends PassengerEvent {
  const DriverEndedTrip();
}

class DriverStartedTrip extends PassengerEvent {
  const DriverStartedTrip();
}