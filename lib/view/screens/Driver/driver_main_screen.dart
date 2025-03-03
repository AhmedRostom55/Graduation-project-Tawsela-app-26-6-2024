import 'package:flutter/material.dart';

class DriverMainScreen extends StatelessWidget {
  const DriverMainScreen({super.key});
  static String id = 'DriverMainScreen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Driver Main Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}