import 'package:equatable/equatable.dart';

class NeverEqualState extends Equatable {
  const NeverEqualState();
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class DriverMapState extends NeverEqualState {
  final bool bottomSheet;
  final bool topSheet;

  const DriverMapState({this.bottomSheet = false, this.topSheet = true});

  @override
  List<Object?> get props => [
        bottomSheet,
        topSheet,
      ];
}