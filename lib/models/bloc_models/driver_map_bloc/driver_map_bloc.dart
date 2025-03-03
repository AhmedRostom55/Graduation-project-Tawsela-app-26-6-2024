import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/models/bloc_models/driver_map_bloc/driver_map_events.dart';
import 'package:tawsela_app/models/bloc_models/driver_map_bloc/driver_map_states.dart';

class DriverMapBloc extends Bloc<DriverMapEvent, DriverMapState> {
  DriverMapBloc() : super(DriverMapState(bottomSheet: false, topSheet: false)) {
    on<ShowBottomSheet>((event, emit) =>
        emit(DriverMapState(bottomSheet: true, topSheet: state.topSheet)));
    on<ShowTopSheet>((event, emit) =>
        emit(DriverMapState(bottomSheet: state.bottomSheet, topSheet: true)));
    on<HideBottomSheet>((event, emit) =>
        emit(DriverMapState(bottomSheet: false, topSheet: state.topSheet)));
    on<HideTopSheet>((event, emit) =>
        emit(DriverMapState(bottomSheet: state.bottomSheet, topSheet: false)));
  }
}