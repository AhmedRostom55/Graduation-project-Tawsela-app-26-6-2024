import 'package:flutter/material.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/view/widgets/fav_places_item_builder.dart';

import '../../../app_logger.dart';

class DriverPickupLocationPage extends StatelessWidget {
  const DriverPickupLocationPage({super.key});
  static String id = 'DriverPickupLocationPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SearchBar(
            onSubmitted: (value) {
              AppLogger.log(value);
            },
            constraints: const BoxConstraints(maxWidth: 400),
            leading: const Icon(Icons.search),
            hintText: S.of(context).specifyASpecificLocationToPickUpPassengers,
            textStyle: WidgetStateProperty.all(const TextStyle(
                fontFamily: font, fontSize: 16, fontWeight: FontWeight.w400)),
            hintStyle: WidgetStateProperty.all(const TextStyle(
                fontFamily: font, fontSize: 16, fontWeight: FontWeight.w400)),
            padding: WidgetStateProperty.resolveWith((states) =>
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0)),
            backgroundColor: WidgetStateProperty.all(Colors.white),
          ),
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(Icons.map_outlined),
              const SizedBox(
                width: 16,
              ),
              Text(
                S.of(context).chooseOnMap,
                style: const TextStyle(
                    fontFamily: font,
                    fontSize: 11,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Text(
            S.of(context).favourite,
            style: const TextStyle(
                fontFamily: font,
                fontSize: 10,
                color: Color(0xff6B6B6B),
                fontWeight: FontWeight.w400),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              for (int i = 0; i < 5; i++)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FavPlacesItemBuilder(
                      title: S.of(context).home,
                      subTitle: S.of(context).clickSelectThisLocation,
                      icon: Icons.home,
                    ),
                    const Divider(
                      thickness: 1,
                    )
                  ],
                )
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Text(
            S.of(context).recentlyVisited,
            style: const TextStyle(
                fontFamily: font,
                fontSize: 10,
                color: Color(0xff6B6B6B),
                fontWeight: FontWeight.w400),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              for (int i = 0; i < 5; i++)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FavPlacesItemBuilder(
                      title: S.of(context).home,
                      subTitle: S.of(context).clickSelectThisLocation,
                      icon: Icons.location_on_outlined,
                    ),
                    const Divider(
                      thickness: 1,
                    )
                  ],
                )
            ],
          ),
        ),
      ]),
    );
  }
}