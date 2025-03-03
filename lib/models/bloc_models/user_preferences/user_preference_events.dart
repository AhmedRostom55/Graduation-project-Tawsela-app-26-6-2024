import 'package:equatable/equatable.dart';

abstract class UserPreferenceEvent extends Equatable {
  const UserPreferenceEvent();
  @override
  List<Object> get props => [];
}

class EnableDarkMode extends UserPreferenceEvent {
  const EnableDarkMode();
}

class DisableDarkMode extends UserPreferenceEvent {
  const DisableDarkMode();
}

class SwitchUserMode extends UserPreferenceEvent {
  const SwitchUserMode();
}