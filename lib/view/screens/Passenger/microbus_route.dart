import 'package:flutter/material.dart';
import 'package:tawsela_app/app_logger.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/utilities.dart';
import 'package:tawsela_app/view/widgets/place_item_builder.dart';

class MicrobusRoutePage extends StatelessWidget {
  MicrobusRoutePage({super.key});
  static String id = 'MicrobusRoutePage';
  List<String> ma7tat = [
    'المسلة',
    'المنشية',
    'المرور',
    'التدريب',
    'المسلة',
    'المنشية',
    'المرور',
    'التدريب',
    'المسلة',
    'المنشية',
    'المرور',
    'التدريب',
  ];
  final color = Colors.amber; // TODO: fix this to show line's color
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        //map
        children: [
          Image.asset(
            'assets/images/map.png',
            fit: BoxFit.cover,
          ),
          DraggableScrollableSheet(
              initialChildSize: 0.2,
              minChildSize: 0.2,
              maxChildSize: 0.6,
              builder: (context, controller) => ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Container(
                                  color: const Color(0xffABABAB),
                                  height: 5,
                                  width: 50,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: InkWell(
                                    onTap: () {
                                      AppLogger.log('object');
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kGreenSmallButton,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Icon(
                                          Icons.close,
                                          fill: 1,
                                          size: 22,
                                          color: kGreenSmallButtonContent,
                                        ),
                                      ),
                                    ),
                                  )),
                              Text(
                                S.of(context).stations,
                                style: const TextStyle(
                                    fontFamily: font,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Color(0xff525252)),
                              )
                            ],
                          ),
                          Expanded(
                            child: Stack(children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 18,
                                    bottom: 18,
                                    right: isArabic() ? 20 : 0,
                                    left: isArabic() ? 0 : 28),
                                child: Container(
                                  width: 4,
                                  height: double.infinity,
                                  color: color,
                                  transform: Matrix4.rotationY(
                                      3.14159), // Rotate 180 degrees
                                ),
                              ),
                              ListView.builder(
                                  controller: controller,
                                  itemCount: ma7tat.length,
                                  itemBuilder: (context, index) {
                                    return PlacesItemBuilder(
                                        color: color, place: ma7tat[index]);
                                  }),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ))
        ],
      ),
    );
  }
}