import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tawsela_app/loading_status_handler.dart';
import 'package:tawsela_app/models/bloc_models/DriverStateTextBloc/driver_state_text_bloc.dart';
import 'package:tawsela_app/models/bloc_models/driver_map_bloc/driver_map_bloc.dart';
import 'package:tawsela_app/models/bloc_models/user_preferences/user_preference_bloc.dart';

import 'package:tawsela_app/models/bloc_models/passenger_bloc/passenger_bloc.dart';
import 'package:tawsela_app/models/bloc_models/uber_driver_bloc/uber_driver_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/models/bloc_models/lang/app_language_bloc.dart';
import 'package:tawsela_app/models/bloc_models/imageCubit/image_cubit.dart';
import 'package:tawsela_app/utilities.dart';

import 'app_logger.dart';

import 'package:tawsela_app/models/get_it.dart/key_chain.dart';

// Import screens
import 'package:tawsela_app/view/screens/Driver/driver_main_screen.dart';
import 'package:tawsela_app/view/screens/Driver/driver_signup.dart';
import 'package:tawsela_app/view/screens/Driver/driver_profile.dart';
import 'package:tawsela_app/view/screens/Driver/driver_pickup_location.dart';
import 'package:tawsela_app/view/screens/Driver/driver_edit_profile.dart';
import 'package:tawsela_app/view/screens/Driver/testPics.dart';
import 'package:tawsela_app/view/screens/Passenger/sms_verfication.dart';
import 'package:tawsela_app/view/screens/Passenger/passenger_signup.dart';
import 'package:tawsela_app/view/screens/Passenger/passenger_profile.dart';
import 'package:tawsela_app/view/screens/Passenger/passenger_edit_profile.dart';
import 'package:tawsela_app/view/screens/Passenger/passenger_main_screen.dart';
import 'package:tawsela_app/view/screens/Passenger/microbus_guide_station.dart';
import 'package:tawsela_app/view/screens/Passenger/microbus_suggested_lines.dart';
import 'package:tawsela_app/view/screens/Passenger/passenger_pickup_location.dart';
import 'package:tawsela_app/view/screens/Passenger/microbus_route.dart';
import 'package:tawsela_app/view/screens/Passenger/welcome_page.dart';
import 'package:tawsela_app/view/screens/driver_map_page/driver_page.dart';
import 'package:tawsela_app/view/screens/home_page/home_page.dart';
import 'package:tawsela_app/view/screens/passenger_map_page/passenger_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await KeyChain.Key_Chain_Initialize();

  // Initialize SVProgressHUD
  LoadingStatusHandler.initialize();

  await initializeServerAPI();
  initializeAppwrite();

  sharedPreferences = await SharedPreferences.getInstance();
  isLoggedIn = sharedPreferences!.getBool('isLoggedIn') ?? false;
  isDriver = sharedPreferences!.getBool('isDriver') ?? false;

  if (isLoggedIn) {
    await initValues();
    setProfileImage();
  }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const TawselaApp());
}

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    // TODO: implement onChange
    super.onChange(bloc, change);
    AppLogger.log(change.currentState.toString());
    AppLogger.log(change.nextState.toString());
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    // TODO: implement onEvent
    super.onEvent(bloc, event);
    AppLogger.log('Event ${event.toString()} has happened');
  }
}

class TawselaApp extends StatelessWidget {
  const TawselaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PassengerBloc>(create: (context) => PassengerBloc()),
        BlocProvider<DriverMapBloc>(create: (context) => DriverMapBloc()),
        BlocProvider<UberDriverBloc>(create: (context) => UberDriverBloc()),
        BlocProvider<UserPreferenceBloc>(
            create: (context) => UserPreferenceBloc()),
        BlocProvider(
          create: (context) => AppLanguageBloc()..add(InitialLanguage()),
        ),
        BlocProvider(
          create: (context) => ImageCubit(), // provide the ImageCubit
        ),
        BlocProvider(
          create: (context) =>
              DriverStateTextBloc(), //change from you don't recieve requests to 'you recieve requests'
        ),
      ],
      child: Builder(
        builder: (context) {
          final langState =
              context.select((AppLanguageBloc bloc) => bloc.state);

          return MaterialApp(
              theme: ThemeData(
                appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(color: kGreenBigButtons),
                  elevation: 0,
                  surfaceTintColor: noColor,
                  shadowColor: Colors.black,
                ),
                textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: kGreenBigButtons,
                  selectionColor: kGreenSmallButton, // Text selection color
                  selectionHandleColor: kGreenBigButtons,
                ),
              ),
              locale: _getLocale(langState),
              debugShowCheckedModeBanner: false,
              supportedLocales: const [Locale('ar'), Locale('en')],
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: _localeResolutionCallback,
              routes: _buildRoutes(),
              // initialRoute: WelcomePage.id);
              initialRoute: sharedPreferences!.getBool('isLoggedIn') == null
                  ? WelcomePage.id
                  : sharedPreferences!.getBool("isLoggedIn")!
                      ? sharedPreferences!.getBool("isDriver") == null
                          ? WelcomePage.id
                          : sharedPreferences!.getBool("isDriver")!
                              ? DriverPage.id
                              : PassengerMainScreen.id
                      : WelcomePage.id);
        },
      ),
    );
  }

  Locale _getLocale(AppLanguageState langState) {
    if (langState is AppChangeLanguage) {
      return langState.languageCode == 'en'
          ? const Locale('en')
          : const Locale('ar');
    }
    return const Locale('ar');
  }

  Locale? _localeResolutionCallback(
      Locale? deviceLocale, Iterable<Locale> supportedLocales) {
    if (deviceLocale != null) {
      for (var locale in supportedLocales) {
        if (deviceLocale.languageCode == locale.languageCode) {
          return deviceLocale;
        }
      }
    }
    return supportedLocales.first;
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      WelcomePage.id: (context) => WelcomePage(),
      SmsVerficationPage.id: (context) => SmsVerficationPage(),
      PassengerSignUpPage.id: (context) => const PassengerSignUpPage(),
      PassengerProfile.id: (context) => const PassengerProfile(),
      PassengerEditProfile.id: (context) => const PassengerEditProfile(),
      PassengerMainScreen.id: (context) => const PassengerMainScreen(),
      MicrobusGuideStationPage.id: (context) =>
          MicrobusGuideStationPage(color: Colors.black, line: 'line'),
      MicrobusSuggestedLinesPage.id: (context) =>
          const MicrobusSuggestedLinesPage(),
      PassengerPickupLocationPage.id: (context) =>
          const PassengerPickupLocationPage(),
      MicrobusRoutePage.id: (context) => MicrobusRoutePage(),
      DriverMainScreen.id: (context) => const DriverMainScreen(),
      DriverSignUpPage.id: (context) => DriverSignUpPage(),
      DriverProfilePage.id: (context) => const DriverProfilePage(),
      DriverPickupLocationPage.id: (context) =>
          const DriverPickupLocationPage(),
      DriverEditProfilePage.id: (context) => DriverEditProfilePage(),
      TestpicsPage.id: (context) => const TestpicsPage(),
      HomePage.id: (context) => const HomePage(),
      PassengerPage.id: (context) => const PassengerPage(),
      DriverPage.id: (context) => const DriverPage(),
    };
  }
}