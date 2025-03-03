import 'package:flutter/material.dart';
import 'package:tawsela_app/constants.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton({
    super.key,
    this.buttonColor =  kGreenSmallButton,
    this.textColor = kGreenSmallButtonContent,
    this.iconColor = kGreenSmallButtonContent,
    this.borderColor= kGreenSmallButtonBorder,
    this.text = '',
    this.radius = 12,
    this.icon,
    this.iconSize = 15,
    this.fontSize = 10,
    this.fontWeight = FontWeight.w500,
    this.paddingHorzin=8,
    this.paddingVerti=2,
    required this.onTap,
    this.containsIconOnly = false
  });
  String text;
  Color buttonColor, textColor, iconColor,borderColor;
  double radius, iconSize, fontSize,paddingHorzin,paddingVerti;
  IconData? icon;
  FontWeight fontWeight;
  Function onTap;
  bool containsIconOnly;


  @override
  Widget build(BuildContext context) {
    return (Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1),
          color: buttonColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: InkWell(

          splashColor: textColor,
          borderRadius: BorderRadius.circular(radius),
          onTap: () {
            onTap();
          },
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: paddingHorzin, vertical: paddingVerti),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                      fontFamily: font,
                      color: textColor,
                      fontSize: fontSize,
                      fontWeight: fontWeight),
                ),
                const SizedBox(width: 6),
                Icon(
                  size: iconSize,
                  icon,
                  color: iconColor,
                ),
                // fix left padding when the button has no accompanying text
                containsIconOnly ? const SizedBox(width: 6) : const SizedBox(),
              ],
            ),
          ),
    )
        )
    );
  }
}