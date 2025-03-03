import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/models/bloc_models/imageCubit/image_cubit.dart';
import 'package:tawsela_app/utilities.dart';
import 'package:tawsela_app/view/screens/Passenger/welcome_page.dart';

import 'package:tawsela_app/view/widgets/custom_button.dart';
import 'package:tawsela_app/view/widgets/custom_text_field.dart';

import '../../../app_logger.dart';
import '../../../loading_status_handler.dart';
import '../../../services/API_service.dart';

class PassengerEditProfile extends StatelessWidget {
  const PassengerEditProfile({super.key});
  static String id = 'passengerEditProfilePage';

  @override
  Widget build(BuildContext context) {
    final imageCubit = context.read<ImageCubit>();
    final imageState = context.watch<ImageCubit>().state;

    return Scaffold(
      appBar: AppBar(
        actions: [
          ButtonBar(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.delete,
                ),
                color: Colors.red[400],
                onPressed: () async {
                  if (Platform.isIOS) {
                    const platform = MethodChannel('deleteAccountDialogChannel');
                    try {
                      final result = await platform.invokeMethod<int>('showDeleteAccountDialog');
                      switch (result) {
                        case 1:
                          LoadingStatusHandler.startLoading();
                          ApiService.deleteAccount(phoneNumber: phoneNumber).then((_) async {
                            await resetData();
                            await LoadingStatusHandler.completeLoadingWithText(
                                "تم حذف الحساب");
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WelcomePage()),
                                      (Route<dynamic> route) => false);
                          }).catchError((error) {
                            // Handle error
                            LoadingStatusHandler.errorLoading(error.toString());
                            AppLogger.log('Failed to delete account: $error');
                          });
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
                          title: const Text("هل انت متأكد انك تريد حذف الحساب؟"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("الغاء")
                            ),
                            TextButton(
                              onPressed: () {
                                LoadingStatusHandler.startLoading();
                                ApiService.deleteAccount(phoneNumber: phoneNumber).then((_) async {
                                  await resetData();
                                  await LoadingStatusHandler.completeLoadingWithText(
                                      "تم حذف الحساب");
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WelcomePage()),
                                          (Route<dynamic> route) => false);
                                }).catchError((error) {
                                  // Handle error
                                  LoadingStatusHandler.errorLoading(error.toString());
                                  AppLogger.log('Failed to delete account: $error');
                                });
                              },
                              child: const Text(
                                "حذف الحساب",
                                  style: TextStyle(
                                    color: Colors.red,
                                  )
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
          )
        ],
        centerTitle: true,
        title: Text(
          S.of(context).editProfile,
          style: const TextStyle(
              fontFamily: font, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 16,
                    right: isArabic() ? 45 : 0,
                    left: isArabic() ? 0 : 28),
                child: Text(
                  S.of(context).personalImage,
                  style: const TextStyle(
                      fontFamily: font,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Stack(children: [
                CircleAvatar(
                  backgroundImage: isLoggedIn ? profileImage : imageState.avatarImg.image,
                  radius: 50,
                  backgroundColor: kGreenSmallButtonBorder,
                ),
                Positioned(
                    top: 70,
                    left: 28,
                    child: InkWell(
                      onTap: () {
                        showImagePicker(context, (Image newImage) {
                                imageCubit.setAvatarImg(newImage);
                              });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: noColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 99, 96, 96)
                                  .withOpacity(0.7),
                              spreadRadius: 10,
                              blurRadius: 24,
                              offset: const Offset(
                                  3, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Text(
                          S.of(context).edit,
                          style: const TextStyle(
                              fontFamily: font,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Color(0xffF6F6F6)),
                        ),
                      ),
                    )),
              ]),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  hintText: firstName,
                  textDirection: isArabic() ? TextDirection.rtl : TextDirection.ltr,
                    textAlign: isArabic() ? TextAlign.right : TextAlign.left,
                
                  onChanged: (data) => firstName = data,
                  width: 136,
                  height: 46,
                  titleAbove: S.of(context).firstName,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  textDirection: isArabic() ? TextDirection.rtl : TextDirection.ltr,
                    textAlign: isArabic() ? TextAlign.right : TextAlign.left,
                  hintText: lastName,
                  onChanged: (data) => lastName = data,
                  width: 136,
                  height: 46,
                  titleAbove: S.of(context).lastName,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                    onChanged: (data) => phoneNumber = data,
                    textDirection: TextDirection.ltr,
                    textAlign:  TextAlign.left ,
                    titleAbove: S.of(context).phoneNum,
                    height: 46,
                    width: 213,
                    maxLength: 10,
                    hintText: phoneNumber,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      // prevent the first number inputted to be 0, to force the user to input the correct number format
                      FilteringTextInputFormatter.deny(RegExp(r'^0')),
                      // to only allow (english) numbers
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 24.0),
                    child: SizedBox(
                        height: 20,
                        width: 29,
                        child: Text(
                          '20+',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16),
                        )),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: SizedBox(
                        height: 23,
                        width: 23,
                        child: Image.asset('assets/images/flag.png')),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: CustomButton(
              onTap: () {
                // TODO: you should update the user profile in database ,PUT request
                Navigator.pop(context);
              },
              text: S.of(context).save,
            ),
          )
        ],
      ),
    );
  }
}