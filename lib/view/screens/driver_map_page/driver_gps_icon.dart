import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';
import 'package:tawsela_app/models/bloc_models/uber_driver_bloc/uber_driver_bloc.dart';

class DriverGpsIcon extends StatelessWidget {
  const DriverGpsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        style: IconButton.styleFrom(backgroundColor: Colors.green),
        onPressed: () {
          BlocProvider.of<UberDriverBloc>(context)
              .add(const GoogleMapGetCurrentPosition());
        },
        icon: const Icon(
          Icons.gps_fixed,
          color: Colors.white,
        ));
  }
}