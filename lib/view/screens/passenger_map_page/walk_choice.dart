import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:html/parser.dart';
import 'package:tawsela_app/models/bloc_models/passenger_bloc/passenger_bloc.dart';
import 'package:tawsela_app/models/bloc_models/passenger_bloc/passenger_states.dart';

class WalkChoice extends StatefulWidget {
  const WalkChoice({super.key});

  @override
  State<WalkChoice> createState() => _WalkChoiceState();
}

class _WalkChoiceState extends State<WalkChoice> {
  int current_step = 0;
  @override
  Widget build(BuildContext context) {
    late PassengerState googleMapProvider;
    if (BlocProvider.of<PassengerBloc>(context).state is UserErrorState) {
      googleMapProvider = passengerLastState;
    } else {
      googleMapProvider =
          BlocProvider.of<PassengerBloc>(context).state as PassengerState;
    }
    if (googleMapProvider.destination != null &&
        googleMapProvider.directions.isNotEmpty) {
      return LayoutBuilder(
          builder: (context, constrainsts) => Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: SingleChildScrollView(
                    child: Stepper(
                        physics: const ClampingScrollPhysics(),
                        connectorColor: WidgetStateProperty.resolveWith(
                            (states) => Colors.green),
                        currentStep: current_step,
                        onStepCancel: () {
                          if (current_step > 0) {
                            current_step -= 1;
                            setState(() {});
                          }
                        },
                        onStepContinue: () {
                          if (current_step <
                              googleMapProvider.directions.length-1) {
                            current_step += 1;
                            setState(() {});
                          }
                        },
                        onStepTapped: (value) {
                          current_step = value;
                          setState(() {});
                        },
                        steps: googleMapProvider.directions.map((e) {
                          final document = parse(e.instructions);
                          final String parsedString =
                              parse(document.body!.text).documentElement!.text;
                          return Step(
                              title: Text(e.duration!.text!),
                              subtitle: Text(e.distance!.text!),
                              content: Text(parsedString));
                        }).toList()),
                  ),
                ),
              ));
    } else if (googleMapProvider.destination == null) {
      return const Center(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          width: 200,
          height: 200,
          child: Card(
            color: Colors.red,
            child: Center(
                child: Text(
              'Please provide a destination',
              style: TextStyle(color: Colors.white),
            )),
          ),
        ),
      ));
    } else if (googleMapProvider.directions.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.green,
            semanticsLabel: 'Loading ...',
          ),
        ),
      );
    } else {
      return ErrorWidget('An Error has occured');
    }
  }
}