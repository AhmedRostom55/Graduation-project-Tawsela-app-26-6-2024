import 'package:equatable/equatable.dart';

abstract class DriverMapEvent extends Equatable {
  const DriverMapEvent();
  @override
  List<Object> get props => [];
}

class ShowTopSheet extends DriverMapEvent {
  const ShowTopSheet();
}

class ShowBottomSheet extends DriverMapEvent {
  const ShowBottomSheet();
}

class HideBottomSheet extends DriverMapEvent {
  const HideBottomSheet();
}

class HideTopSheet extends DriverMapEvent {
  const HideTopSheet();
}