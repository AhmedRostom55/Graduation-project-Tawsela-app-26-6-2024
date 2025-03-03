import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/passenger_bloc/passenger_bloc.dart';
import 'package:tawsela_app/models/bloc_models/passenger_bloc/passenger_states.dart';

class ServiceChoice extends StatefulWidget {

  static const String id = 'service_choice';
  const ServiceChoice({super.key});

  @override
  State<ServiceChoice> createState() => _ServiceChoiceState();
}

class _ServiceChoiceState extends State<ServiceChoice> {
  int current_step = 0;
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
    return (passengerState.destination == null ||
            passengerState.directions.isEmpty)
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          )
        : SingleChildScrollView(
            child: Stepper(
                key: Key(Random.secure().nextDouble().toString()),
                physics: const ClampingScrollPhysics(),
                connectorColor:
                    WidgetStateProperty.resolveWith((states) => Colors.green),
                currentStep: current_step,
                onStepCancel: () {
                  if (current_step > 0) {
                    current_step -= 1;
                    setState(() {});
                  }
                },
                onStepContinue: () {
                  if (current_step < passengerState.directions.length-1) {
                    current_step += 1;
                    setState(() {});
                  }
                },
                onStepTapped: (value) {
                  current_step = value;
                  setState(() {});
                },
                steps: passengerState.directions.map((e) {
                  final document = parse(e.instructions);
                  final String parsedString =
                      parse(document.body!.text).documentElement!.text;
                  return Step(
                      title: Text(e.duration!.text!),
                      subtitle: Text(e.distance!.text!),
                      content: Text(parsedString));
                }).toList()),
          );
  }
}