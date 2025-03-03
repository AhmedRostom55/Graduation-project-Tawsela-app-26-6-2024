// driver_state_text_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'driver_state_text_event.dart';
import 'driver_state_text_state.dart';


class DriverStateTextBloc extends Bloc<DriverStateTextEvent, DriverStateTextState> {
  DriverStateTextBloc()
      : super(DriverStateTextState(
          text: S().YouDoNotReceivePassengerRequeststTheMoment,
          color: kRed,
        )) {
    on<ToggleText>((event, emit) {
      if (state.text == S().YouDoNotReceivePassengerRequeststTheMoment) {
        emit(DriverStateTextState(
          text: S().YouReceivePassengerRequeststTheMoment,
          color: kGreen,
        ));
      } else {
        emit(DriverStateTextState(
          text: S().YouDoNotReceivePassengerRequeststTheMoment,
          color: kRed,
        ));
      }
    });
  }
}