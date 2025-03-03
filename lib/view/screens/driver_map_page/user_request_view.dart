import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/uber_driver_bloc/uber_driver_events.dart';
import 'package:tawsela_app/models/bloc_models/uber_driver_bloc/uber_driver_states.dart';
import 'package:tawsela_app/models/bloc_models/uber_driver_bloc/uber_driver_bloc.dart';
import 'package:tawsela_app/models/timers/trip_request_timer.dart';

class UserRequestListView extends StatelessWidget {
  TripRequestTimer timer;
  UserRequestListView({required this.timer, super.key});

  void _onRefresh(BuildContext context) {
    BlocProvider.of<UberDriverBloc>(context).add(const GetPassengerRequests());
  }

  @override
  Widget build(BuildContext context) {
    late UberDriverState uberDriverProvider;
    if (BlocProvider.of<UberDriverBloc>(context).state is UserErrorState) {
      uberDriverProvider = uberLastState;
    } else if (BlocProvider.of<UberDriverBloc>(context).state is Loading) {
      uberDriverProvider = uberLastState;
    } else {
      uberDriverProvider =
          BlocProvider.of<UberDriverBloc>(context).state as UberDriverState;
    }
    return RefreshIndicator(
      onRefresh: () async => _onRefresh(context),
      child: ListView.builder(
        itemCount: uberDriverProvider.passengerRequests.isEmpty
            ? 0
            : uberDriverProvider.passengerRequests.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: const Color.fromARGB(255, 238, 230, 230),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('User Information'),
                        IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    ),
                    content: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                            ),
                            Text(
                                'name: ${uberDriverProvider.passengerRequests[index].f_name}'),
                            Text(
                                'location: ${uberDriverProvider.passengerRequests[index].Current_Location}'),
                            Text(
                                'destination: ${uberDriverProvider.passengerRequests[index].Desired_Location}')
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            style: ListTileStyle.list,
            title:
                Text(uberLastState.passengerRequests[index].f_name ?? 'User'),
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      if (uberDriverProvider.acceptedRequest == null) {
                        BlocProvider.of<UberDriverBloc>(context).add(
                            AcceptPassengerRequest(
                                passengerRequest: uberDriverProvider
                                    .passengerRequests[index]));
                        timer.startRequestTimer();
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                content: Text(
                                    'You can not accept more than one trip'),
                              );
                            });
                      }
                    },
                    child: const Text(
                      'accept',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )),
                const SizedBox(
                  width: 5,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      BlocProvider.of<UberDriverBloc>(context).add(
                          RejectPassengerRequest(
                              passengerRequest:
                                  uberLastState.passengerRequests[index]));
                    },
                    child: const Text('reject',
                        style: TextStyle(color: Colors.white, fontSize: 14)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}