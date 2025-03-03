import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';
import 'package:tawsela_app/models/bloc_models/passenger_bloc/passenger_bloc.dart';
import 'package:tawsela_app/models/bloc_models/uber_driver_bloc/uber_driver_bloc.dart';
import 'package:tawsela_app/models/bloc_models/user_preferences/user_preference_bloc.dart';
import 'package:tawsela_app/models/data_models/user_states.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage(this.message, {super.key});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(78, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message, style: const TextStyle(fontSize: 20)),
            const CircularProgressIndicator(
              color: Colors.green,
            ),
            const SizedBox(
              height: 10,
            ),
            (BlocProvider.of<UberDriverBloc>(context).stream.last
                        is GoogleMapGetCurrentPosition ||
                    BlocProvider.of<PassengerBloc>(context).stream.last
                        is GoogleMapGetCurrentPosition)
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green),
                    onPressed: () {
                      if (BlocProvider.of<UserPreferenceBloc>(context)
                              .state
                              .userState ==
                          UserState.DRIVER) {
                        BlocProvider.of<UberDriverBloc>(context)
                            .add(const GoogleMapGetCurrentPosition());
                      } else {
                        BlocProvider.of<PassengerBloc>(context)
                            .add(const GoogleMapGetCurrentPosition());
                      }
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ))
                : const Text('')
          ],
        ),
      ),
    );
  }
}
