import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/models/bloc_models/user_preferences/user_preference_events.dart';
import 'package:tawsela_app/models/bloc_models/user_preferences/user_preference_states.dart';
import 'package:tawsela_app/models/data_models/user_states.dart';

class UserPreferenceBloc
    extends Bloc<UserPreferenceEvent, UserPreferenceState> {
  UserPreferenceBloc() : super(UserPreferenceState()) {
    on<EnableDarkMode>(
        (event, emit) => emit(UserPreferenceState(darkMode: true)));
    on<DisableDarkMode>(
        (event, emit) => emit(UserPreferenceState(darkMode: false)));
    on<SwitchUserMode>((event, emit) => emit(UserPreferenceState(
        userState: state.userState == UserState.DRIVER
            ? UserState.PASSENGER
            : UserState.DRIVER)));
  }
}