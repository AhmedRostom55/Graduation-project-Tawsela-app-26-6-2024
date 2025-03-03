import 'package:flutter/material.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';

import 'package:tawsela_app/utilities.dart';
import 'package:tawsela_app/view/widgets/custom_circle_container.dart';
import 'package:tawsela_app/view/widgets/place_item_builder.dart';

class MicrobusGuideStationPage extends StatelessWidget {
   MicrobusGuideStationPage({required this.color, required this.line, super.key});
  static String id='MicrobusGuideStationPage';
   Color color;
   String line;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: color,
        title: Padding(
          padding: EdgeInsets.only(left: isArabic() ? 10 : 0, right: isArabic() ? 0 : 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).MicrobusGuideStationAppBarTitle,
                style: const TextStyle(
                    fontFamily: font, fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 8),
              CustomCircleContainer(
                line: line,
                color: color,
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.only(
            top: 24,
            bottom: 24,
              right: isArabic() ? 20 : 0, left: isArabic() ? 0 : 28),
          child: Container(
            width: 4,
            height: double.infinity,
            color: color,
            transform: Matrix4.rotationY(3.14159), // Rotate 180 degrees
          ),
        ),
        ListView(children: [
          for (int i = 0; i < 20; i++)
            PlacesItemBuilder(
              color: color,
              place: S.of(context).hawatam
            ),
        ]),
      ]),
    );
  }
}