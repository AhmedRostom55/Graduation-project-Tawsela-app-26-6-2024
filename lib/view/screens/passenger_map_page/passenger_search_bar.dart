import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/models/bloc_models/passenger_bloc/passenger_bloc.dart';
import 'package:tawsela_app/models/bloc_models/passenger_bloc/passenger_events.dart';
import 'package:tawsela_app/models/get_it.dart/key_chain.dart';

class PassengerSearchBar extends StatefulWidget {
  const PassengerSearchBar({super.key});

  @override
  State<PassengerSearchBar> createState() => _PassengerSearchBarState();
}

class _PassengerSearchBarState extends State<PassengerSearchBar> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GooglePlaceAutoCompleteTextField(
      textStyle: const TextStyle(fontFamily: font),
      inputDecoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: kSearchBarColor)),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: kSearchBarColor)),
        contentPadding: const EdgeInsets.only(left: 0),
        hintText: S.of(context).whereUwantoGo,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide()),
      ),
      textEditingController: textController,
      googleAPIKey: KeyChain.google_server_key!,
      boxDecoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      countries: const ['eg'],
      itemBuilder: (context, index, prediction) {
        return ListTile(
          titleTextStyle: const TextStyle(fontFamily: font, color: kGreyFont),
          subtitleTextStyle:
              const TextStyle(fontFamily: font, color: kGreyFont),
          leadingAndTrailingTextStyle:
              const TextStyle(fontFamily: font, color: kGreyFont),
          leading: const Icon(
            Icons.location_on,
            color: kGreenBigButtons,
          ),
          title: Text(prediction.description!),
        );
      },
      showError: true,
      itemClick: (prediction) async {
        FocusScope.of(context).unfocus();
        if (prediction.description != null) {
          List<Location> location =
              await locationFromAddress(prediction.description!);

          BlocProvider.of<PassengerBloc>(context).add(GetDestination(
              destinationDescription: prediction.description!,
              destination:
                  LatLng(location[0].latitude, location[0].longitude)));
        }
      },
    );
  }
}