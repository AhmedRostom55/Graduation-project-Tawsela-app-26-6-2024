import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/models/bloc_models/driver_map_bloc/driver_map_bloc.dart';
import 'package:tawsela_app/models/bloc_models/driver_map_bloc/driver_map_events.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/uber_driver_bloc/uber_driver_events.dart';
import 'package:tawsela_app/models/bloc_models/uber_driver_bloc/uber_driver_states.dart';
import 'package:tawsela_app/models/bloc_models/uber_driver_bloc/uber_driver_bloc.dart';
import 'package:tawsela_app/models/timers/trip_request_timer.dart';
import 'package:url_launcher/url_launcher.dart';

class UserInformation extends StatelessWidget {
  bool showDirection;
  TripRequestTimer timer;
  UserInformation({super.key, this.showDirection = false, required this.timer});
  @override
  Widget build(BuildContext context) {
    final driverMapProvider = BlocProvider.of<DriverMapBloc>(context);

    late UberDriverState uberDriverProvider;
    if (BlocProvider.of<UberDriverBloc>(context).state is UserErrorState) {
      uberDriverProvider = uberLastState;
    } else if (BlocProvider.of<UberDriverBloc>(context).state is Loading) {
      uberDriverProvider = uberLastState;
    } else {
      uberDriverProvider =
          BlocProvider.of<UberDriverBloc>(context).state as UberDriverState;
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
                                    Text(uberDriverProvider
                                        .acceptedRequest!.f_name!),
                                  ],
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                ),
                                Card(
                                  shadowColor: Colors.green,
                                  color: Colors.white,
                                  surfaceTintColor: Colors.white,
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          fit: FlexFit.loose,
                                          child: Text(uberDriverProvider
                                              .acceptedRequest!
                                              .Desired_Location!),
                                        )
                                      ],
                                    ),
                                  ),
                                )
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
                                    host: uberDriverProvider
                                        .acceptedRequest!.phone_num);
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
                                BlocProvider.of<UberDriverBloc>(context).add(
                                    CancelTrip(
                                        passengerRequest: uberDriverProvider
                                            .acceptedRequest!));
                                timer.stopRequestTimer();
                                BlocProvider.of<UberDriverBloc>(context)
                                    .add(const GetPassengerRequests());
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
                      if (showDirection == true)
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            onPressed: () {
                              driverMapProvider.add(const HideTopSheet());
                              Future.delayed(const Duration(seconds: 2));
                              BlocProvider.of<UberDriverBloc>(context)
                                  .add(const GetPassengerDirections());
                              driverMapProvider.add(const ShowBottomSheet());
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.directions,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Directions',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )),
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