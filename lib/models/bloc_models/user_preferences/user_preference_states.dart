import 'package:equatable/equatable.dart';

import 'package:tawsela_app/models/data_models/user_states.dart';

class NeverEqualState extends Equatable {
  const NeverEqualState();
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class UserPreferenceState extends NeverEqualState {
  final bool darkMode;
  final UserState userState;

  const UserPreferenceState(
      {this.darkMode = false, this.userState = UserState.DRIVER});

  @override
  List<Object?> get props => [
        userState,
        darkMode,
      ];
}
