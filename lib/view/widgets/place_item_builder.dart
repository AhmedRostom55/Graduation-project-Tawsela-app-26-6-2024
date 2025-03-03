import 'package:flutter/material.dart';
import 'package:tawsela_app/constants.dart';

class PlacesItemBuilder extends StatelessWidget {
  PlacesItemBuilder({super.key, this.color = Colors.orange,required this.place});
  Color color;
  String place;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      title: Text(
        place,
        style: const TextStyle(
            fontFamily: font, fontSize: 12, fontWeight: FontWeight.w700),
      ),
    );
  }
}