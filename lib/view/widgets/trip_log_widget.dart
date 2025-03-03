import 'package:flutter/material.dart';
import 'package:tawsela_app/constants.dart';

class TripLogWidget extends StatelessWidget {
  TripLogWidget({required this.img, this.radius = 20, super.key});

  double radius;
  String img;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: AssetImage(img),
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'أحمد علاء',
                  style: TextStyle(
                      fontFamily: font,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: const Color(0xffE7E7E7),
                      border: Border.all(
                        color: const Color(0xffCECECE),
                        width: 1,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const InkWell(
                        focusColor: noColor,
                        splashColor: noColor,
                        hoverColor: noColor,
                        highlightColor: noColor,
                        child: Icon(Icons.edit_outlined))),
              ],
            ),
            const Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                Text('5.0')
              ],
            ),
          ],
        ),
      ])
    ]);
  }
}
