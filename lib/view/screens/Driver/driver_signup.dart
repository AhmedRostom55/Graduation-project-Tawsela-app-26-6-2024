import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/models/bloc_models/imageCubit/image_cubit.dart';

import 'package:tawsela_app/utilities.dart';
import 'package:tawsela_app/view/screens/Driver/testPics.dart';
import 'package:tawsela_app/view/widgets/custom_button.dart';

import 'package:tawsela_app/view/widgets/custom_text_button.dart';

class DriverSignUpPage extends StatelessWidget {
  static String id = 'DriverSignUpPage';

  List<String> titlesAboveUploadImgButton = [
    S().personalImage,
    S().licenseImg,
    S().idCardImg,
  ];

  DriverSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final imageCubit = context.read<ImageCubit>();

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 16),
            child: Text(
              S.of(context).signUpDriverMsg,
              style: const TextStyle(
                fontFamily: font,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          for (int i = 0; i < 3; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 8,
                        right: isArabic() ? 16 : 0,
                        left: isArabic() ? 0 : 16),
                    child: Text(
                      titlesAboveUploadImgButton[i],
                      style: const TextStyle(
                        fontFamily: font,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff444444),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: isArabic() ? 16 : 0,
                        left: isArabic() ? 0 : 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomTextButton(
                          icon: Icons.image,
                          text: S.of(context).uploadImg,
                          radius: 16,
                          fontSize: 14,
                          iconSize: 19,
                          paddingHorzin: 10,
                          paddingVerti: 10,
                          onTap: () {
                            if (i == 0) {
                              showImagePicker(context, (Image newImage) {
                                imageCubit.setAvatarImg(newImage);
                              });
                            } else if (i == 1) {
                              showImagePicker(context, (Image newImage) {
                                imageCubit.setLicenseImg(newImage);
                              });
                            } else if (i == 2) {
                              showImagePicker(context, (Image newImage) {
                                imageCubit.setIdImg(newImage);
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          const SizedBox(height: 32),
          CustomButton(
            onTap: () {
              Navigator.pushNamed(context, TestpicsPage.id);
            },
            text: S.of(context).continuee,
          ),
        ],
      ),
    );
  }
}