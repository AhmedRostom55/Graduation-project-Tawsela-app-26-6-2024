import 'package:flutter/material.dart';
import 'package:tawsela_app/constants.dart';


class CustomCircleContainer extends StatelessWidget {
  CustomCircleContainer(
      {super.key, this.line = '', this.color =const Color(0xFFEE9563),this.onTap});

  String line;
  Color color;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
          width: 4,
        ),
        shape: BoxShape.circle,
      ),
      child: InkWell(
        focusColor: noColor,
        splashColor: noColor,
        hoverColor: noColor,
        highlightColor: noColor,
       
        onTap: onTap,
        child: Center(
          child: Text(
            line,
            style: const TextStyle(
              fontFamily: font,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xff484848),
            ),
          ),
        ),
      ),
    );
  }
}