import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/uber_driver_bloc/uber_driver_bloc.dart';
import 'package:tawsela_app/models/bloc_models/uber_driver_bloc/uber_driver_states.dart';

class DirectionWidget extends StatefulWidget {
  @override
  const DirectionWidget({super.key});
  @override
  State<DirectionWidget> createState() => _DirectionWidgetState();
}

class _DirectionWidgetState extends State<DirectionWidget> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    late UberDriverState uberDriverProvider;
    if (BlocProvider.of<UberDriverBloc>(context).state is UserErrorState) {
      uberDriverProvider = uberLastState;
    } else {
      uberDriverProvider =
          BlocProvider.of<UberDriverBloc>(context).state as UberDriverState;
    }

    if (uberDriverProvider.directions.isNotEmpty &&
        uberDriverProvider.destination != null) {
      return ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 1,
            child: Stepper(
              physics: const ClampingScrollPhysics(),
              steps: uberDriverProvider.directions.map((e) {
                final document = parse(e.instructions);
                final String parsedString =
                    parse(document.body!.text).documentElement!.text;
                return Step(
                    title: Text(e.duration!.text!),
                    subtitle: Text(e.distance!.text!),
                    content: Text(parsedString));
              }).toList(),
              onStepContinue: () {
                if (currentStep < uberDriverProvider.directions.length - 1) {
                  currentStep += 1;
                  setState(() {});
                }
              },
              onStepCancel: () {
                if (currentStep > 0) {
                  currentStep -= 1;
                  setState(() {});
                }
              },
              connectorColor:
                  WidgetStateProperty.resolveWith((states) => Colors.green),
              currentStep: currentStep,
            ),
          ),
        ],
      );
    } else if (uberDriverProvider.destination == null) {
      return const Center(
        child: Card(
          color: Colors.red,
          child: Text(
            'Unkown destination',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else if (uberDriverProvider.directions.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      );
    } else {
      return ErrorWidget('An Error has occured');
    }
  }
}