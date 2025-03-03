import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/loading_status_handler.dart';
import 'package:tawsela_app/models/bloc_models/lang/app_language_bloc.dart';
import 'package:tawsela_app/utilities.dart';
import 'package:tawsela_app/view/screens/Passenger/sms_verfication.dart';

import 'package:tawsela_app/view/widgets/custom_button.dart';
import 'package:tawsela_app/view/widgets/custom_text_field.dart';

import '../../../app_logger.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});
  static String id = 'WelcomePage';

  final TextEditingController phoneController = TextEditingController();
   GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PopupMenuButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Color(0xffB4B4B4), width: 0.5),
          ),
          icon: const Icon(Icons.language),
          popUpAnimationStyle: AnimationStyle(curve: Curves.easeIn),
          color: Colors.white,
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 1,
              child: Center(
                  child: Text("English",
                      style: TextStyle(
                          fontFamily: font, color: kGreenBigButtons))),
            ),
            const PopupMenuItem(
              value: 2,
              child: Center(
                  child: Text(
                "العربية",
                style: TextStyle(fontFamily: font, color: kGreenBigButtons),
              )),
            ),
          ],
          elevation: 2,
          onSelected: (value) {
            if (value == 1) {
              BlocProvider.of<AppLanguageBloc>(context)
                  .add(EnglishLanguageEvent());
            } else if (value == 2) {
              BlocProvider.of<AppLanguageBloc>(context)
                  .add(ArabicLanguageEvent());
            }
          },
        ),
        
      ),

      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    S.of(context).title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      fontFamily: font,
                    ),
                  ),
                ),
                Text(
                  S.of(context).appName,
                  style: const TextStyle(
                    color: kGreenFont,
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                    fontFamily: font,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    height: MediaQuery.of(context).size.height * .18,
                    child: Text(
                      S.of(context).welcomeMsg,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: font,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 0, left: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        textAlign: TextAlign.left,
                        textDirection: TextDirection.ltr,
                        titleAbove: S.of(context).phoneNum,
                        height: 46,
                        width: 230,
                        hintText: "1234567890",
                        initialValue: phoneNumber,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        maxLengthEnforcement: MaxLengthEnforcement.none, // TODO: change textfield border to red when user exceeds 10 digits
                        onChanged: (value) {
                          phoneNumber = value;
                        },
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
                                  fontWeight: FontWeight.w400, fontSize: 15),
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
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                width: 300,
                radius: 10,
                paddingHorizontal: 70,
                buttonColor: kGreenBigButtons,
                textColor: kWhite,
                text: S.of(context).continuee,
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    LoadingStatusHandler.startLoading();
                    try {
                      Session? session;
                      if (kDebugMode) {
                        session = await account!.createAnonymousSession();
                        AppLogger.log("CREATED ANON SESSION");
                        userId = session.userId;
                      } else {
                        final token = await account!.createPhoneToken(
                            userId: ID.unique(), phone: "+20$phoneNumber");
                        AppLogger.log("CREATED PHONE SESSION");
                        userId = token.userId;
                      }
                      AppLogger.log(userId);
                      AppLogger.log("SUCCESSFULLY SENT SMS CODE");
                      LoadingStatusHandler.completeLoading();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SmsVerficationPage(),
                        ),
                      );
                    } catch (e) {
                      AppLogger.log(e);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(
                            child: Text(
                          "${S.of(context).PleaseEnter} ${S.of(context).phoneNum}",
                          style: const TextStyle(fontFamily: font),
                        )),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}