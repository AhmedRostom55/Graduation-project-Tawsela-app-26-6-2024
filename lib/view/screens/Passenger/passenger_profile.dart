import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/models/bloc_models/imageCubit/image_cubit.dart';
import 'package:tawsela_app/view/screens/Passenger/welcome_page.dart';
import 'package:tawsela_app/view/screens/Passenger/passenger_edit_profile.dart';
import 'package:tawsela_app/view/screens/driver_map_page/driver_page.dart';
import 'package:tawsela_app/view/widgets/custom_popup_menu_button.dart';
import 'package:tawsela_app/utilities.dart';

import 'package:tawsela_app/view/widgets/custom_switch_icon.dart';
import 'package:tawsela_app/view/widgets/custom_text_button.dart';

import '../../../app_logger.dart';
import '../../../models/bloc_models/lang/app_language_bloc.dart';

class PassengerProfile extends StatelessWidget {
  const PassengerProfile({super.key});
  static String id = 'PassengerProfilePage';

  @override
  Widget build(BuildContext context) {
    final imageState = context.watch<ImageCubit>().state;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.green),
        backgroundColor: const Color(0xffF8F8F8),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                CustomTextButton(
                  text: S.of(context).switchDriverMode,
                  radius: 10,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  paddingVerti: 6,
                  icon: CustomSwitchIcon.icon,
                  iconSize: 20,
                  onTap: () async {
                    isDriver = true;
                    await updateDataToSharedPrefs();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const DriverPage()),
                        (Route<dynamic> route) => false);
                  },
                ),
                const SizedBox(width: 8),
                CustomPopupMenuButton(
                    icon: Icons.language,
                    popUpAnimationStyle: AnimationStyle(curve: Curves.easeIn),
                    buttonColor: const Color(0xffE0E0E0),
                    iconColor: const Color(0xff3E3E3E),
                    borderColor: const Color(0xffB4B4B4),
                    itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 1,
                            child: Center(
                                child: Text("English",
                                    style: TextStyle(
                                        fontFamily: font,
                                        color: kGreenBigButtons))),
                          ),
                          const PopupMenuItem(
                            value: 2,
                            child: Center(
                                child: Text(
                              "العربية",
                              style: TextStyle(
                                  fontFamily: font, color: kGreenBigButtons),
                            )),
                          ),
                        ],
                    onSelected: (value) {
                      if (value == 1) {
                        BlocProvider.of<AppLanguageBloc>(context)
                            .add(EnglishLanguageEvent());
                      } else if (value == 2) {
                        BlocProvider.of<AppLanguageBloc>(context)
                            .add(ArabicLanguageEvent());
                      }
                    },
                    radius: 10,
                    iconSize: 20),
                const SizedBox(width: 8),
                CustomTextButton(
                  radius: 10,
                  borderColor: kLogOutButtonBorder,
                  textColor: kLogOutButtonContent,
                  iconColor: kLogOutButtonContent,
                  buttonColor: kLogOutButtonBackground,
                  paddingVerti: 6,
                  icon: Icons.logout,
                  paddingHorzin: 2,
                  iconSize: 20,
                  containsIconOnly: true,
                  onTap: () async {
                    if (Platform.isIOS) {
                      const platform = MethodChannel('logOutDialogChannel');
                      try {
                        final result = await platform.invokeMethod<int>('showLogOutDialog');
                        switch (result) {
                          case 1:
                            isLoggedIn = false;
                            await resetData();
                            try {
                              await account!.deleteSession(
                                  sessionId: 'current');
                              AppLogger.log("DELETED");
                            } on AppwriteException catch (e) {
                              AppLogger.log(e.message);
                            }
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WelcomePage()),
                                    (Route<dynamic> route) => false);
                            break;
                        }
                      } on PlatformException catch (error) {
                        AppLogger.log(error.message);
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("هل انت متأكد من تسجيل الخروج؟"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("الغاء")
                              ),
                              TextButton(
                                onPressed: () async {
                                  isLoggedIn = false;
                                  await resetData();
                                  try {
                                    await account!.deleteSession(
                                        sessionId: 'current');
                                    AppLogger.log("DELETED");
                                  } on AppwriteException catch (e) {
                                    AppLogger.log(e.message);
                                  }
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WelcomePage()),
                                      (Route<dynamic> route) => false);
                                },
                                child: const Text(
                                  "تسجيل الخروج",
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xffF8F8F8),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
              child: Column(
                children: [
                  Row(children: [
                    CircleAvatar(
                      backgroundImage: isLoggedIn ? profileImage : imageState.avatarImg.image,
                      radius: 50,
                      backgroundColor: kGreenSmallButtonBorder,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 130,
                              //height: 12,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxHeight: 35,
                                ),
                                child: FittedBox(
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    "$firstName $lastName",
                                    style: const TextStyle(
                                        fontFamily: font,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
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
                              child: InkWell(
                                focusColor: noColor,
                                splashColor: noColor,
                                hoverColor: noColor,
                                highlightColor: noColor,
                                child: const Icon(Icons.edit_outlined),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, PassengerEditProfile.id);
                                },
                              ),
                            ),
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
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    S.of(context).numberoftrips,
                    style: const TextStyle(
                        color: Color(0xff525252),
                        fontFamily: font,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "12  ${S.of(context).trip}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: font,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    if (index == 0)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).tripLog,
                              style: const TextStyle(
                                  color: Color(0xff303030),
                                  fontFamily: font,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            CustomTextButton(
                              onTap: () {
                                // TODO: implement show all trips
                              },
                              icon: Icons.arrow_forward_ios,
                              text: S.of(context).showAll,
                              fontSize: 12,
                            )
                          ],
                        ),
                      ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: isLoggedIn ? profileImage : imageState.avatarImg.image,
                        radius: 25,
                        backgroundColor: kGreenSmallButtonBorder,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  "$firstName $lastName",
                                  style: const TextStyle(
                                      fontFamily: font,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                          const Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 15,
                                color: Colors.amber,
                              ),
                              Text(
                                '5.0',
                                style: TextStyle(
                                    fontFamily: font,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      ),
                      trailing: const Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 120,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    //you should get this from the API
                                    'المسلة',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: font,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      size: 15,
                                    ),
                                  ),
                                  Text(
                                    //you should get this from the API
                                    'جامعة الفيوم',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: font,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 4.0),
                              child: Text(
                                //you should get this from the API
                                '٤:٥٠ مساءً - ٥:١٠ مساءً',
                                style: TextStyle(
                                    color: Color(
                                      0xff858585,
                                    ),
                                    fontFamily: font,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
