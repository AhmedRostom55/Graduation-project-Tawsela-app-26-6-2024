import 'package:flutter/material.dart';

class MicrobusSuggestedLinesPage extends StatelessWidget {
  const MicrobusSuggestedLinesPage({super.key});
  static String id = 'MicrobusSuggestedLinesPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.all(0),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}