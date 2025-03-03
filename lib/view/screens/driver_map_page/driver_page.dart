import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/models/bloc_models/DriverStateTextBloc/driver_state_text_bloc.dart';
import 'package:tawsela_app/models/bloc_models/DriverStateTextBloc/driver_state_text_state.dart';
import 'package:tawsela_app/models/bloc_models/imageCubit/image_cubit.dart';
import 'package:tawsela_app/models/bloc_models/uber_driver_bloc/uber_driver_bloc.dart';
import 'package:tawsela_app/models/bloc_models/uber_driver_bloc/uber_driver_events.dart';
import 'package:tawsela_app/models/bloc_models/uber_driver_bloc/uber_driver_states.dart';

import 'package:tawsela_app/models/bloc_models/driver_map_bloc/driver_map_bloc.dart';
import 'package:tawsela_app/models/bloc_models/driver_map_bloc/driver_map_states.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';
import 'package:tawsela_app/models/servers/main_server.dart';
import 'package:tawsela_app/models/timers/trip_request_timer.dart';
import 'package:tawsela_app/view/screens/Driver/driver_pickup_location.dart';
import 'package:tawsela_app/view/screens/Driver/driver_profile.dart';

import 'package:tawsela_app/view/screens/driver_map_page/driver_draggable_sheet.dart';
import 'package:tawsela_app/view/screens/driver_map_page/driver_gps_icon.dart';
import 'package:tawsela_app/view/screens/driver_map_page/driver_map_switch.dart';
import 'package:tawsela_app/view/screens/driver_map_page/driver_google_map_widget.dart';
import 'package:tawsela_app/view/screens/driver_map_page/user_information.dart';
import 'package:tawsela_app/view/screens/driver_map_page/user_request_view.dart';
import 'package:tawsela_app/view/screens/passenger_map_page/loading_page.dart';
import 'package:tawsela_app/view/widgets/custom_text_button.dart';

import '../../../utilities.dart';

class DriverPage extends StatefulWidget {
  static const String id = 'DriverPage';
  const DriverPage({super.key});
  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  List<String> tripStates = ['Start', 'End'];
  late TripRequestTimer timer;
  bool isTripStarted = false;
  late Timer isRequestCancelled;
  late Timer isTripEnded;
  @override
  void initState() {
    super.initState();
    timer = TripRequestTimer(
      requestCallback: checkRequest,
      tripCallback: () async {},
      duration: const Duration(seconds: 5),
    );
  }

  Future<bool> checkRequest() async {
    bool result = false;
    try {
      result = await MainServer.isRequestCancelled(
          uberLastState.acceptedRequest!.Req_ID!);

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
                      'Passenger Cancelled Request',
                      style: TextStyle(color: Colors.white),
                    )),
                  ));
            });
        BlocProvider.of<UberDriverBloc>(context)
            .add(const PassengerCancelledRequest());
        timer.stopRequestTimer();
      }
    } catch (error) {
      result = false;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final imageState = context.watch<ImageCubit>().state;
    final driverMapProvider = BlocProvider.of<DriverMapBloc>(context);
    late UberDriverState uberDriverProvider;
    return BlocConsumer<UberDriverBloc, MapUserState>(
      listener: (context, state) {
        if (state is UserErrorState) {
          Flushbar(
            message: state.message,
            backgroundColor: Colors.red,
            messageColor: Colors.white,
            flushbarPosition: FlushbarPosition.BOTTOM,
            duration: const Duration(seconds: 5),
          ).show(context);
        } else {}
      },
      builder: (context, state) {
        if (state is UserErrorState) {
          uberDriverProvider = uberLastState;
        } else if (state is Loading) {
          uberDriverProvider = uberLastState;
        } else {
          uberDriverProvider = state as UberDriverState;
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 8,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniStartFloat,
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (uberDriverProvider.destination != null &&
                  uberDriverProvider.directions.isNotEmpty)
                FloatingActionButton(
                  shape: const CircleBorder(side: BorderSide(color: Colors.white)),
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    if (isTripStarted == false) {
                      isTripStarted = true;
                      BlocProvider.of<UberDriverBloc>(context).add(StartTrip(
                          passengerRequest:
                              uberDriverProvider.acceptedRequest!));
                    } else {
                      isTripStarted = false;
                      BlocProvider.of<UberDriverBloc>(context).add(EndTrip(
                          passengerRequest:
                              uberDriverProvider.acceptedRequest!));

                      BlocProvider.of<UberDriverBloc>(context)
                          .add(const GoogleMapGetCurrentPosition());
                    }
                  },
                  child: Center(
                    child: Text(
                      (isTripStarted) ? tripStates[1] : tripStates[0],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          body: Stack(
              children: [
                DriverGoogleMapWidget(
                  isTripStarted: isTripStarted,
                ),
                if (uberDriverProvider.destination != null &&
                    driverMapProvider.state.bottomSheet == true)
                  DriverDraggableSheet(
                    timer: timer,
                  ),
                BlocConsumer<DriverMapBloc, DriverMapState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return SafeArea(
                      child: LayoutBuilder(
                        builder: (context, constraints) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: const EdgeInsets.all(0),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50))),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16, left: 16),
                                    child: InkWell(
                                      onTap: () => Navigator.pushNamed(
                                          context, DriverProfilePage.id),
                                      child: CircleAvatar(
                                        backgroundImage: isLoggedIn ? profileImage : imageState.avatarImg.image,
                                        radius: 25,
                                        backgroundColor:
                                            kGreenSmallButtonBorder,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Text(
                                  S.of(context).AreYouAvaibleNow,
                                  style: const TextStyle(
                                      fontFamily: font,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: kGrey),
                                ),
                              )),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BlocBuilder<DriverStateTextBloc,
                                            DriverStateTextState>(
                                        builder: (context, state) {
                                      return Text(
                                        state.text,
                                        style: TextStyle(
                                            fontFamily: font,
                                            color: state.color,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600),
                                      );
                                    }),
                                    const DriverMapSwitch(),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomTextButton(
                                        paddingVerti: 10,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        icon: Icons.tune,
                                        text: S
                                            .of(context)
                                            .DetermineSpecificLocation,
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              DriverPickupLocationPage.id);
                                        }),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Center(
                                  child: Text(S.of(context).thereNoOrdersNow,
                                      style: const TextStyle(
                                        fontFamily: font,
                                        color: kGreyLight,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      )),
                                ),
                              ),
                              const DriverGpsIcon(),
                              const SizedBox(
                                height: 10,
                              ),
                              if (driverMapProvider.state.topSheet == true)
                                SizedBox(
                                    height: constraints.maxHeight * 0.5,
                                    child:
                                        (uberDriverProvider.acceptedRequest ==
                                                null)
                                            ? UserRequestListView(timer: timer)
                                            : UserInformation(
                                                showDirection: true,
                                                timer: timer,
                                              ))
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                if (state is Loading) LoadingPage(state.message),
              ]),
        );
      },
    );
  }
}