import 'package:flutter/material.dart';

class BottomSheetHandle extends StatelessWidget {
  const BottomSheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 50,
      child: Divider(
        color: Colors.grey,
        thickness: 5,
      ),
    );
  }
}