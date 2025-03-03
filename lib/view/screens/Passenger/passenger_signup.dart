import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/loading_status_handler.dart';
import 'package:tawsela_app/models/bloc_models/imageCubit/image_cubit.dart';
import 'package:tawsela_app/services/API_service.dart';
import 'package:tawsela_app/utilities.dart';
import 'package:tawsela_app/view/screens/Passenger/passenger_main_screen.dart';

import 'package:tawsela_app/view/widgets/custom_button.dart';
import 'package:tawsela_app/view/widgets/custom_text_button.dart';

import 'package:tawsela_app/view/widgets/custom_text_field.dart';

import '../../../app_logger.dart';

class PassengerSignUpPage extends StatefulWidget {
  const PassengerSignUpPage({super.key});
  static String id = 'PassengerSignUpPage';

  @override
  
  _PassengerSignUpPageState createState() => _PassengerSignUpPageState();
}

class _PassengerSignUpPageState extends State<PassengerSignUpPage> {
  @override
  Widget build(BuildContext context) {


    GlobalKey<FormState> formKey = GlobalKey();

    final imageCubit = context.read<ImageCubit>();

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60),
              child: Text(
                S.of(context).passengerSignUpTitle,
                style: const TextStyle(
                  fontFamily: font,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    textDirection:
                        isArabic() ? TextDirection.rtl : TextDirection.ltr,
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
                    textDirection:
                        isArabic() ? TextDirection.rtl : TextDirection.ltr,
                    textAlign: isArabic() ? TextAlign.right : TextAlign.left,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8, right: 40.0,
                      ),
                      child: Text(
                        "${S.of(context).personalImage} (${S.of(context).optional})",
                        style: const TextStyle(
                            fontFamily: font,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: kGreyFont),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextButton(
                          onTap: () {
                            showImagePicker(context, (Image newImage) {
                              imageCubit.setAvatarImg(newImage);
                            });
                          },
                          icon: Icons.image,
                          text: S.of(context).uploadImg,
                          radius: 16,
                          fontSize: 14,
                          iconSize: 19,
                          paddingHorzin: 10,
                          paddingVerti: 10,
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  width: 180,
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            CustomButton(
              text: S.of(context).signUp,
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  LoadingStatusHandler.startLoading();
                  // Call the sign-up API
                  ApiService.signUp(
                      phoneNumber: phoneNumber,
                      fname: firstName,
                      lname: lastName,
                      typeUser: "Passenger",
                  )
                      .then((_) async {
                    await LoadingStatusHandler.completeLoadingWithText("تم التسجيل");
                    AppLogger.log('Signed up successfully');
                      ApiService.logIn(phoneNumber: phoneNumber)
                          .then((_) async {
                        await updateDataToSharedPrefs();

                        // Then navigate to the main screen
                        Navigator.pushNamedAndRemoveUntil(context, PassengerMainScreen.id, (route) => false);
                      }).catchError((error) {
                        // Handle error
                        LoadingStatusHandler.errorLoading(error.toString());
                        AppLogger.log('Failed to log-in: $error');
                      });
                  }).catchError((error) {
                    // Handle error
                    LoadingStatusHandler.errorLoading(error.toString());
                    AppLogger.log('Failed to sign-up: $error');
                  });
                } else {
                  String remove_en = "Fill in", remove_ar = "املأ";
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Center(
                          child: Text(
                        "${S.of(context).PleaseEnter}${(S.of(context).passengerSignUpTitle).replaceFirst(isArabic() ? remove_ar : remove_en, "")}",
                        style: const TextStyle(fontFamily: font),
                      )),
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}