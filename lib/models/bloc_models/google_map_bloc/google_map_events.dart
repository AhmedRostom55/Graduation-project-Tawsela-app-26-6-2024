import 'package:equatable/equatable.dart';

import 'package:tawsela_app/models/data_models/user_states.dart';

abstract class GoogleMapEvent extends Equatable {
  const GoogleMapEvent();
  @override
  List<Object> get props => [];
}

// ************************* User Events *******************
class GoogleMapGetCurrentPosition extends GoogleMapEvent {
  const GoogleMapGetCurrentPosition();
}

class SwitchMode extends GoogleMapEvent {
  final UserState userState;
  const SwitchMode({required this.userState});
}

// *********************** Passenger Events *****************

// ************** Driver Events *************************//