import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/models/bloc_models/imageCubit/image_cubit.dart';

import 'package:tawsela_app/utilities.dart';
import 'package:tawsela_app/view/screens/Passenger/microbus_guide_station.dart';
import 'package:tawsela_app/view/screens/Passenger/passenger_profile.dart';
import 'package:tawsela_app/view/screens/passenger_map_page/passenger_page.dart';

import 'package:tawsela_app/view/widgets/custom_circle_container.dart';
import 'package:tawsela_app/view/widgets/custom_text_button.dart';

import 'package:tawsela_app/view/widgets/fav_places_item_builder.dart';

Color randomColor = Colors.black;

class PassengerMainScreen extends StatelessWidget {
  const PassengerMainScreen({super.key});

  static String id = 'passengerMainScreen';

  @override
  Widget build(BuildContext context) {

    final imageState = context.watch<ImageCubit>().state;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                SizedBox(
                  child: Image.asset(
                    'assets/images/header.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 205,
                  ),
                ),

                Padding(padding:
                const EdgeInsets.all(16),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, PassengerProfile.id),
                    child: CircleAvatar(
                      backgroundImage: isLoggedIn ? profileImage : imageState.avatarImg.image,
                      radius: 25,
                      backgroundColor: kGreenSmallButtonBorder,
                    ),
                ),),

                Padding(
                  padding: const EdgeInsets.only(top: 120.0),
                  child: Center(
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      readOnly: true, // prevent user from entering input as tapping will go to another screen anyways
                      onTap: () {
                        Navigator.pushNamed(
                            context, PassengerPage.id);
                      },
                      decoration: InputDecoration(
                        constraints: const BoxConstraints(maxWidth: 300),
                        hintText: S.of(context).whereUwantoGo,
                        hintStyle: const TextStyle(
                            fontFamily: font,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        prefixIcon: const Icon(Icons.search),
                        contentPadding: const EdgeInsets.symmetric(vertical: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).favPlaces,
                    style: const TextStyle(
                        color: kGreyFont,
                        fontFamily: font,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  CustomTextButton(
                    onTap: () {
                      // TODO: implement add new fav place
                    },
                    icon: Icons.add,
                    text: S.of(context).add,
                    fontSize: 12,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 270,
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
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).microbusesLinesGuide,
                    style: const TextStyle(
                        color: kGreyFont,
                        fontFamily: font,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 90,
              child: ListView.separated(
                padding: const EdgeInsets.only(left: 16, right: 16),
                scrollDirection: Axis.horizontal,
                itemCount: 13,
                itemBuilder: (BuildContext context, int index) {
                  return CustomCircleContainer(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MicrobusGuideStationPage(
                            line: displayLines(index),
                            color: linesColors[index],
                          ),
                        ),
                      );
                    },
                    line: displayLines(index),
                    color: linesColors[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 15);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}