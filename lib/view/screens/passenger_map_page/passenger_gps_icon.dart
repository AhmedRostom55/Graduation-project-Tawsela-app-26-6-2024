import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';
import 'package:tawsela_app/models/bloc_models/passenger_bloc/passenger_bloc.dart';

class PassengerGpsIcon extends StatelessWidget {
  const PassengerGpsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        style: IconButton.styleFrom(backgroundColor: Colors.white),
        onPressed: () {
          BlocProvider.of<PassengerBloc>(context)
              .add(const GoogleMapGetCurrentPosition());
        },
        icon: const Icon(
          Icons.gps_fixed,
          color: Colors.green,
        ));
  }
}