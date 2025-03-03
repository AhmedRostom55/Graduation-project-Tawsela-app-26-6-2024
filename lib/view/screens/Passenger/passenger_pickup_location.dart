import 'package:flutter/material.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';

import 'package:tawsela_app/view/screens/passenger_map_page/passenger_page.dart';
import 'package:tawsela_app/view/screens/passenger_map_page/passenger_search_bar.dart';
import 'package:tawsela_app/view/widgets/fav_places_item_builder.dart';

class PassengerPickupLocationPage extends StatelessWidget {
  const PassengerPickupLocationPage({super.key});
  static String id = 'PassengerPickupLocationPage';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          // To dismiss keyboard when tapping anywhere outside search bar
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: kGreenBigButtons),
            surfaceTintColor: noColor,
            centerTitle: true,
            title: PassengerSearchBar(),
          ),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, PassengerPage.id),
                      child: const Icon(Icons.map_outlined)),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
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
              child: ListView.separated(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FavPlacesItemBuilder(
                        title: S.of(context).home,
                        subTitle: S.of(context).clickSelectThisLocation,
                        icon: Icons.home,
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    thickness: 1,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
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
              child: ListView.separated(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FavPlacesItemBuilder(
                        title: S.of(context).home,
                        subTitle: S.of(context).clickSelectThisLocation,
                        icon: Icons.location_on_outlined,
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    thickness: 1,
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}