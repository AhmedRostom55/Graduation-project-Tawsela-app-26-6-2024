import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/passenger_bloc/passenger_bloc.dart';
import 'package:tawsela_app/models/bloc_models/passenger_bloc/passenger_states.dart';
import 'package:tawsela_app/models/get_it.dart/key_chain.dart';

class PassengerGoogleMapWidget extends StatelessWidget {
  final isTripStarted;
  const PassengerGoogleMapWidget({required this.isTripStarted, super.key});
  @override
  Widget build(BuildContext context) {
    late PassengerState passengerState;
    if (BlocProvider.of<PassengerBloc>(context).state is UserErrorState) {
      passengerState = passengerLastState;
    } else if (BlocProvider.of<PassengerBloc>(context).state is Loading) {
      passengerState = passengerLastState;
    } else {
      passengerState =
          BlocProvider.of<PassengerBloc>(context).state as PassengerState;
    }
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
          height: (passengerState.destination != null)
              ? constraints.maxHeight * 0.93
              : constraints.maxHeight,
          child: (isTripStarted)
              ? StreamBuilder<Position>(
                  stream: Geolocator.getPositionStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData == true) {
                      return GoogleMap(
                          onMapCreated: (GoogleMapController controller) {
                            passengerState.controller = controller;
                          },
                          markers: {
                            ...passengerState.markers,
                            Marker(
                                markerId: const MarkerId('moving-passenger'),
                                position: LatLng(snapshot.data!.latitude,
                                    snapshot.data!.longitude),
                                icon: KeyChain.passenger_image ??
                                    BitmapDescriptor.defaultMarkerWithHue(
                                        BitmapDescriptor.hueAzure))
                          },
                          polylines: (passengerState.lines.isNotEmpty)
                              ? {...passengerState.lines}
                              : {},
                          initialCameraPosition: CameraPosition(
                              target: LatLng(snapshot.data!.latitude,
                                  snapshot.data!.longitude)));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  })
              : GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    passengerState.controller = controller;
                  },
                  markers: passengerState.markers,
                  polylines: (passengerState.lines.isNotEmpty)
                      ? {...passengerState.lines}
                      : {},
                  initialCameraPosition:
                      CameraPosition(target: passengerState.currentPosition))),
    );
  }
}