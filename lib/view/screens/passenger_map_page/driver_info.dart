import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/passenger_bloc/passenger_bloc.dart';
import 'package:tawsela_app/models/bloc_models/passenger_bloc/passenger_events.dart';
import 'package:tawsela_app/models/bloc_models/passenger_bloc/passenger_states.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverInfo extends StatelessWidget {
  const DriverInfo({super.key});
  @override
  Widget build(BuildContext context) {
    late PassengerState passengerProvider;

    if (BlocProvider.of<PassengerBloc>(context).state is UserErrorState) {
      passengerProvider = passengerLastState;
    } else if (BlocProvider.of<PassengerBloc>(context).state is Loading) {
      passengerProvider = passengerLastState;
    } else {
      passengerProvider =
          BlocProvider.of<PassengerBloc>(context).state as PassengerState;
    }

    return Column(
      children: [
        Column(
          children: [
            Card(
              shadowColor: Colors.green,
              elevation: 4,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CircleAvatar(
                                      child: Icon(Icons.person),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(passengerLastState
                                        .driverData!.firstName)
                                  ],
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                ),
                              ],
                            )
                          ]),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                              onPressed: () async {
                                final url = Uri(
                                    scheme: 'tel',
                                    host: passengerProvider.driverData!.phone);
                                await launchUrl(url);
                              },
                              child: const Row(children: [
                                Icon(
                                  Icons.call,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Call',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ])),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () {
                                BlocProvider.of<PassengerBloc>(context)
                                    .add(const CancelUberRequest());
                              },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}