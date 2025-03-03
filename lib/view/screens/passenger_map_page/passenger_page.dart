import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';
import 'package:tawsela_app/utilities.dart';
import 'package:tawsela_app/models/servers/main_server.dart';
import 'package:tawsela_app/models/timers/trip_request_timer.dart';

import 'package:tawsela_app/view/screens/passenger_map_page/bottom_sheet.dart';
import 'package:tawsela_app/view/screens/passenger_map_page/loading_page.dart';
import 'package:tawsela_app/view/screens/passenger_map_page/passenger_google_map_page.dart';
import 'package:tawsela_app/view/screens/passenger_map_page/passenger_gps_icon.dart';
import 'package:tawsela_app/view/screens/passenger_map_page/passenger_search_bar.dart';
import 'package:tawsela_app/view/widgets/handle.dart';
import 'package:tawsela_app/models/bloc_models/passenger_bloc/passenger_bloc.dart';
import 'package:tawsela_app/models/bloc_models/passenger_bloc/passenger_events.dart';
import 'package:tawsela_app/models/bloc_models/passenger_bloc/passenger_states.dart';

class PassengerPage extends StatefulWidget {
  static const String id = 'PassengerPage';
  const PassengerPage({super.key});
  @override
  State<PassengerPage> createState() => _PassengerPageState();
}

class _PassengerPageState extends State<PassengerPage> {
  final textController = TextEditingController();
  List<String> tripStates = ['Start', 'End'];
  bool isTripStarted = false;
  late TripRequestTimer timer;

  @override
  void initState() {
    super.initState();
    timer = TripRequestTimer(
        requestCallback: checkRequest,
        tripCallback: checkTrip,
        duration: const Duration(seconds: 5));
  }

  Future<bool> checkRequest() async {
    bool result = false;
    try {
      result = await MainServer.isRequestCancelled(
          passengerLastState.passengerRequest!.Req_ID!);
      if (result) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
                content: Container(
                    color: Colors.red,
                    width: 200,
                    height: 200,
                    child: const Text(
                      'Driver Cancelled request',
                      style: TextStyle(color: Colors.white),
                    )),
              );
            });
        BlocProvider.of<PassengerBloc>(context).add(const CancelUberRequest());
        timer.stopRequestTimer();
      }
    } catch (error) {
      result = false;
    }
    return result;
  }

  Future<bool> checkTrip() async {
    bool result = false;
    if (timer.isTripTimerOn()) {
      try {
        result = await MainServer.isTripEnded(
            passengerLastState.passengerRequest!.Req_ID!);
        if (result) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.exit_to_app, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                    content: Container(
                      color: Colors.red,
                      width: 200,
                      height: 200,
                      child: const Center(
                          child: Text(
                        'Driver Ended trip',
                        style: TextStyle(color: Colors.white),
                      )),
                    ));
              });
          BlocProvider.of<PassengerBloc>(context).add(const DriverEndedTrip());
          timer.stopTripTimer();
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.exit_to_app, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                    content: Container(
                      color: Colors.green,
                      width: 200,
                      height: 200,
                      child: const Center(
                          child: Text(
                        driverStartedTrip,
                        style: TextStyle(color: Colors.white),
                      )),
                    ));
              });
          BlocProvider.of<PassengerBloc>(context).add(const DriverEndedTrip());
        }
      } catch (error) {
        result = false;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PassengerBloc, MapUserState>(
      listener: (context, state) {
        if (state is UserErrorState) {
          if (state.message == driverStartedTrip) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.exit_to_app, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                      content: Container(
                        color: Colors.red,
                        width: 200,
                        height: 200,
                        child: const Center(
                            child: Text(
                          driverStartedTrip,
                          style: TextStyle(color: Colors.white),
                        )),
                      ));
                });
          } else {
            Flushbar(
              message: state.message,
              backgroundColor: Colors.red,
              messageColor: Colors.white,
              flushbarPosition: FlushbarPosition.BOTTOM,
              duration: const Duration(seconds: 5),
            ).show(context);
          }
        } else {}
      },
      builder: (context, state) {
        PassengerState passengerState;
        if (state is UserErrorState) {
          passengerState = passengerLastState;
        } else if (state is Loading) {
          passengerState = passengerLastState;
        } else {
          passengerState =
              BlocProvider.of<PassengerBloc>(context).state as PassengerState;
        }
        return Scaffold(
          // add back button
          appBar: AppBar(
            titleSpacing: 10,
            title: const PassengerSearchBar(),
            leading: IconButton(
              padding: const EdgeInsets.all(10),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.white),
                splashFactory: splashEffect,
              ),
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniStartFloat,
          floatingActionButton: (passengerState.destination != null &&
                  passengerState.directions.isNotEmpty)
              ? FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    if (isTripStarted == false) {
                      isTripStarted = true;
                      setState(() {});
                    } else {
                      isTripStarted = false;
                      BlocProvider.of<PassengerBloc>(context)
                          .add(const GoogleMapGetCurrentPosition());
                    }
                  },
                  child: Center(
                    child: Text(
                      (isTripStarted) ? tripStates[1] : tripStates[0],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
              : null,
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          body: Stack(
              children: [
                PassengerGoogleMapWidget(
                  isTripStarted: isTripStarted,
                ),
                if (passengerState.destination != null)
                  DraggableScrollableSheet(
                      initialChildSize: 0.25,
                      minChildSize: 0.07,
                      maxChildSize: 1,
                      snapSizes: const [0.25, 0.5, 0.75, 1],
                      snap: true,
                      builder: (context, scrollableController) {
                        return Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50))),
                          child: ListView(
                            physics: const ClampingScrollPhysics(),
                            controller: scrollableController,
                            children: [
                              const Column(
                                children: [BottomSheetHandle()],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              UserActionsPanel(timer: timer)
                            ],
                          ),
                        );
                      }),
                const SafeArea(
                  child: Column(
                    children: [PassengerGpsIcon()],
                  ),
                ),
                if (state is Loading) LoadingPage(state.message),
              ]),
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textController.dispose();
  }
}