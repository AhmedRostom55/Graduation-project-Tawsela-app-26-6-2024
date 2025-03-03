// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome to the app`
  String get title {
    return Intl.message(
      'Welcome to the app',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Tawsela`
  String get appName {
    return Intl.message(
      'Tawsela',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Tawseela will help you go anywhere in`
  String get descriptions {
    return Intl.message(
      'Tawseela will help you go anywhere in',
      name: 'descriptions',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Verification Code`
  String get verifyCode {
    return Intl.message(
      'Verification Code',
      name: 'verifyCode',
      desc: '',
      args: [],
    );
  }

  /// `E-mail (optional)`
  String get email {
    return Intl.message(
      'E-mail (optional)',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number`
  String get phoneNum {
    return Intl.message(
      'Mobile Number',
      name: 'phoneNum',
      desc: '',
      args: [],
    );
  }

  /// `Fill in the following information to create your account`
  String get passengerSignUpTitle {
    return Intl.message(
      'Fill in the following information to create your account',
      name: 'passengerSignUpTitle',
      desc: '',
      args: [],
    );
  }

  /// `Microbus Guide Line`
  String get MicrobusGuideStationAppBarTitle {
    return Intl.message(
      'Microbus Guide Line',
      name: 'MicrobusGuideStationAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `You will receive a message containing the verification code. Please write it here.`
  String get smsVerificationScreenTitle {
    return Intl.message(
      'You will receive a message containing the verification code. Please write it here.',
      name: 'smsVerificationScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continuee {
    return Intl.message(
      'Continue',
      name: 'continuee',
      desc: '',
      args: [],
    );
  }

  /// `Verify Code`
  String get verifycode {
    return Intl.message(
      'Verify Code',
      name: 'verifycode',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Facebook`
  String get singInFaceBook {
    return Intl.message(
      'Sign in with Facebook',
      name: 'singInFaceBook',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get singInGoogle {
    return Intl.message(
      'Sign in with Google',
      name: 'singInGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Apple`
  String get singInApple {
    return Intl.message(
      'Sign in with Apple',
      name: 'singInApple',
      desc: '',
      args: [],
    );
  }

  /// `OR`
  String get or {
    return Intl.message(
      'OR',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Tawsela will help you go anywhere in Faiyum with ease. Choose the place you want to go and the application will select the most suitable transportation for you.`
  String get welcomeMsg {
    return Intl.message(
      'Tawsela will help you go anywhere in Faiyum with ease. Choose the place you want to go and the application will select the most suitable transportation for you.',
      name: 'welcomeMsg',
      desc: '',
      args: [],
    );
  }

  /// `Send code again`
  String get sendCodeAgain {
    return Intl.message(
      'Send code again',
      name: 'sendCodeAgain',
      desc: '',
      args: [],
    );
  }

  /// `Upload Image`
  String get uploadImg {
    return Intl.message(
      'Upload Image',
      name: 'uploadImg',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get signUp {
    return Intl.message(
      'Register',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Personal Image`
  String get personalImage {
    return Intl.message(
      'Personal Image',
      name: 'personalImage',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Show All`
  String get showAll {
    return Intl.message(
      'Show All',
      name: 'showAll',
      desc: '',
      args: [],
    );
  }

  /// `Favorite Places`
  String get favPlaces {
    return Intl.message(
      'Favorite Places',
      name: 'favPlaces',
      desc: '',
      args: [],
    );
  }

  /// `Microbuses Lines Guide`
  String get microbusesLinesGuide {
    return Intl.message(
      'Microbuses Lines Guide',
      name: 'microbusesLinesGuide',
      desc: '',
      args: [],
    );
  }

  /// `Click to select this location`
  String get clickSelectThisLocation {
    return Intl.message(
      'Click to select this location',
      name: 'clickSelectThisLocation',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Where do you want to go?`
  String get whereUwantoGo {
    return Intl.message(
      'Where do you want to go?',
      name: 'whereUwantoGo',
      desc: '',
      args: [],
    );
  }

  /// `Hawatem`
  String get hawatam {
    return Intl.message(
      'Hawatem',
      name: 'hawatam',
      desc: '',
      args: [],
    );
  }

  /// `Open a driver account by submitting some additional information`
  String get signUpDriverMsg {
    return Intl.message(
      'Open a driver account by submitting some additional information',
      name: 'signUpDriverMsg',
      desc: '',
      args: [],
    );
  }

  /// `License Image`
  String get licenseImg {
    return Intl.message(
      'License Image',
      name: 'licenseImg',
      desc: '',
      args: [],
    );
  }

  /// `ID Card`
  String get idCardImg {
    return Intl.message(
      'ID Card',
      name: 'idCardImg',
      desc: '',
      args: [],
    );
  }

  /// `Choose On Map`
  String get chooseOnMap {
    return Intl.message(
      'Choose On Map',
      name: 'chooseOnMap',
      desc: '',
      args: [],
    );
  }

  /// `Recently Visited`
  String get recentlyVisited {
    return Intl.message(
      'Recently Visited',
      name: 'recentlyVisited',
      desc: '',
      args: [],
    );
  }

  /// `Favourite`
  String get favourite {
    return Intl.message(
      'Favourite',
      name: 'favourite',
      desc: '',
      args: [],
    );
  }

  /// `Specify a location to pick up passengers`
  String get specifyASpecificLocationToPickUpPassengers {
    return Intl.message(
      'Specify a location to pick up passengers',
      name: 'specifyASpecificLocationToPickUpPassengers',
      desc: '',
      args: [],
    );
  }

  /// `To edit the name and profile picture, contact technical support`
  String get ToEditTheNameAndProfilePictureContactTechnicalSupport {
    return Intl.message(
      'To edit the name and profile picture, contact technical support',
      name: 'ToEditTheNameAndProfilePictureContactTechnicalSupport',
      desc: '',
      args: [],
    );
  }

  /// `Switch to driver mode`
  String get switchDriverMode {
    return Intl.message(
      'Switch to driver mode',
      name: 'switchDriverMode',
      desc: '',
      args: [],
    );
  }

  /// `Switch to passenger mode`
  String get switchPassengermode {
    return Intl.message(
      'Switch to passenger mode',
      name: 'switchPassengermode',
      desc: '',
      args: [],
    );
  }

  /// `Trips`
  String get numberoftrips {
    return Intl.message(
      'Trips',
      name: 'numberoftrips',
      desc: '',
      args: [],
    );
  }

  /// `Trip`
  String get trip {
    return Intl.message(
      'Trip',
      name: 'trip',
      desc: '',
      args: [],
    );
  }

  /// `Trip Log`
  String get tripLog {
    return Intl.message(
      'Trip Log',
      name: 'tripLog',
      desc: '',
      args: [],
    );
  }

  /// `Stations`
  String get stations {
    return Intl.message(
      'Stations',
      name: 'stations',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Walk`
  String get Walk {
    return Intl.message(
      'Walk',
      name: 'Walk',
      desc: '',
      args: [],
    );
  }

  /// `Uber`
  String get Uber {
    return Intl.message(
      'Uber',
      name: 'Uber',
      desc: '',
      args: [],
    );
  }

  /// `Microbus`
  String get Microbus {
    return Intl.message(
      'Microbus',
      name: 'Microbus',
      desc: '',
      args: [],
    );
  }

  /// `Are you available now?`
  String get AreYouAvaibleNow {
    return Intl.message(
      'Are you available now?',
      name: 'AreYouAvaibleNow',
      desc: '',
      args: [],
    );
  }

  /// `You don''t receive requests at the moment`
  String get YouDoNotReceivePassengerRequeststTheMoment {
    return Intl.message(
      'You don\'\'t receive requests at the moment',
      name: 'YouDoNotReceivePassengerRequeststTheMoment',
      desc: '',
      args: [],
    );
  }

  /// `Determine a Specific Location`
  String get DetermineSpecificLocation {
    return Intl.message(
      'Determine a Specific Location',
      name: 'DetermineSpecificLocation',
      desc: '',
      args: [],
    );
  }

  /// `There are no orders now`
  String get thereNoOrdersNow {
    return Intl.message(
      'There are no orders now',
      name: 'thereNoOrdersNow',
      desc: '',
      args: [],
    );
  }

  /// `You receive requests`
  String get YouReceivePassengerRequeststTheMoment {
    return Intl.message(
      'You receive requests',
      name: 'YouReceivePassengerRequeststTheMoment',
      desc: '',
      args: [],
    );
  }

  /// `You earned today`
  String get YouEarnedToday {
    return Intl.message(
      'You earned today',
      name: 'YouEarnedToday',
      desc: '',
      args: [],
    );
  }

  /// `Please enter`
  String get PleaseEnter {
    return Intl.message(
      'Please enter',
      name: 'PleaseEnter',
      desc: '',
      args: [],
    );
  }

  /// `Field is required`
  String get FieldIsRequired {
    return Intl.message(
      'Field is required',
      name: 'FieldIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `EGP`
  String get pounds {
    return Intl.message(
      'EGP',
      name: 'pounds',
      desc: '',
      args: [],
    );
  }

  /// `Optional`
  String get optional {
    return Intl.message(
      'Optional',
      name: 'optional',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
