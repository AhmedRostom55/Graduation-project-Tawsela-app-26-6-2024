import 'package:flutter/material.dart';
import 'package:tawsela_app/constants.dart';

class CustomPopupMenuButton extends StatelessWidget {
  CustomPopupMenuButton(
      {super.key,
      required this.icon,
      required this.popUpAnimationStyle,
      this.buttonColor = kGreyButton,
      this.iconColor = kGreyIconColor,
      this.borderColor = kGreyBorderLight,
      required this.radius,
      required this.iconSize,
      required this.itemBuilder,
      this.onSelected});

  IconData icon;
  Color buttonColor, iconColor, borderColor;
  double iconSize, radius;
  AnimationStyle popUpAnimationStyle;

  List<PopupMenuEntry<dynamic>> Function(BuildContext) itemBuilder;
  void Function(dynamic)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width and height hard-coded to match log out button
      width: 38,
      height: 34,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1),
        color: buttonColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: PopupMenuButton(
        padding: EdgeInsets.zero, // to fix issue of icon shifting down
        // shape of pop up menu
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: borderColor, width: 0.5),
        ),
        color: Colors.white,
        itemBuilder: itemBuilder,
        onSelected: onSelected,
        icon: Icon(icon),
        iconColor: iconColor,
        iconSize: iconSize,
        popUpAnimationStyle: popUpAnimationStyle,
      ),
    );
  }
}