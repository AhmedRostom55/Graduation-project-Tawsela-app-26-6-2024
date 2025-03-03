import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';
import 'package:tawsela_app/models/data_models/user_request_model/request_model.dart';

abstract class DriverEvent extends GoogleMapEvent {
  const DriverEvent();
}

class GetPassengerRequests extends DriverEvent {
  const GetPassengerRequests();
}

class AcceptPassengerRequest extends DriverEvent {
  final UserRequest passengerRequest;
  const AcceptPassengerRequest({required this.passengerRequest});
}

class RejectPassengerRequest extends DriverEvent {
  final UserRequest passengerRequest;
  const RejectPassengerRequest({required this.passengerRequest});
}

class CallPassenger extends DriverEvent {
  const CallPassenger();
}

class CancelTrip extends DriverEvent {
  final UserRequest passengerRequest;
  const CancelTrip({required this.passengerRequest});
}

class StartTrip extends DriverEvent {
  final UserRequest passengerRequest;
  const StartTrip({required this.passengerRequest});
}

class EndTrip extends DriverEvent {
  final UserRequest passengerRequest;
  const EndTrip({required this.passengerRequest});
}

class GetPassengerDirections extends DriverEvent {
  const GetPassengerDirections();
}

class PassengerCancelledRequest extends DriverEvent {
  const PassengerCancelledRequest();
}