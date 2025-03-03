import 'package:flutter/material.dart';

import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/utilities.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.onTap,
    this.paddingHorizontal = 85,
    this.text = '',
    this.buttonColor = kGreenBigButtons,
    this.textColor = Colors.white,
    this.width,
    this.height,
    this.radius = 10,
    this.fontSize = 22,
    this.fontWeight = FontWeight.w400,
  });

  String text;
  Function onTap;
  Color buttonColor, textColor;
  double? height, width;
  double paddingHorizontal;
  double radius, fontSize;
  FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius), color: buttonColor),
          child: OutlinedButton(
            style: ButtonStyle(
                splashFactory: splashEffect,
                side: WidgetStateProperty.all(BorderSide(color: buttonColor)),
                backgroundColor: WidgetStateProperty.all(buttonColor)),
            onPressed: () {
              onTap();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: paddingHorizontal, vertical: 12),
              child: Text(
                text,
                style: TextStyle(
                    fontFamily: font,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: textColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}