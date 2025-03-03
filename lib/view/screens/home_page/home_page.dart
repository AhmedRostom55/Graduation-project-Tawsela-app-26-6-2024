import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:tawsela_app/models/bloc_models/user_preferences/user_preference_bloc.dart';
import 'package:tawsela_app/models/data_models/user_states.dart';
import 'package:tawsela_app/view/screens/driver_map_page/driver_page.dart';
import 'package:tawsela_app/view/screens/passenger_map_page/passenger_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/data_models/location_model/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserState userState = UserState.DRIVER;
  final textController = TextEditingController();
  List<Location_t> locations = [];
  LatLng currentLocation = const LatLng(29, 32);
  late Future<String> points;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = BlocProvider.of<UserPreferenceBloc>(context);

    if (userProvider.state.userState == UserState.DRIVER) {
      return const DriverPage();
    } else {
      return const PassengerPage();
    }
  }
}