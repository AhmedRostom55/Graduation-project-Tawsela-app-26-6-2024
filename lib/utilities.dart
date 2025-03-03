import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/loading_status_handler.dart';
import 'package:tawsela_app/services/API_service.dart';
import 'package:tawsela_app/view/widgets/custom_buttom_sheet_img_pick.dart';
import 'package:appwrite/appwrite.dart';

import 'app_logger.dart';

bool isArabic() => Intl.getCurrentLocale() == 'ar';

String displayLines(int i) {
  List<String> lines = [
    "١",
    "٢",
    "٣",
    "٤",
    "٥",
    "٦",
    "٧",
    "٨",
    "٩",
    "١١",
    "١٣",
    "١٥",
    "١٧"
  ];

  if (isArabic()) return lines[i].toString();
  return (i + 1).toString();
}

final picker = ImagePicker();

showImagePicker(BuildContext context, Function(Image) setImage) async {
  if (Platform.isIOS) {
    const platform = MethodChannel('imagePickerOptionsChannel');
    try {
      final result = await platform.invokeMethod<int>('showImagePickerOptions');
      switch (result) {
        case 1:
          imagePick(ImageSource.camera, setImage);
          break;
        case 2:
          imagePick(ImageSource.gallery, setImage);
          break;
      }
    } on PlatformException catch (error) {
      AppLogger.log(error.message);
    }
  } else {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return CustomButtomSheet_imgPick(setImage: setImage);
      },
    );
  }
}

imagePick(ImageSource source, Function(Image) setImage) async {
  await picker.pickImage(source: source, imageQuality: 100).then((value) {
    if (value != null) {
      _cropImage(File(value.path), setImage);
    } else {
      AppLogger.log("You didn't pick any image");
    }
  });
}

_cropImage(File imgFile, Function(Image) setImage) async {
  final croppedFile = await ImageCropper().cropImage(
      sourcePath: imgFile.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: "Edit Photo",
            toolbarColor: kGreenBigButtons,
            toolbarWidgetColor: kWhite,
            statusBarColor: kGreenBigButtons,
            activeControlsWidgetColor: kGreenBigButtons,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: "Edit Photo",
        )
      ]);

  if (croppedFile != null) {
    imageCache.clear();
    await uploadImage(croppedFile);
    setImage(Image.file(File(croppedFile.path)));
  }
}

// You should add this property to all buttons to remove splash effect when pressed on iOS
// Determine first if the platform is web, if so, set the splash effect to the default
// Else check again if it's iOS, set it to remove splash
var splashEffect = kIsWeb
    ? InkSplash.splashFactory
    : (Platform.isIOS ? NoSplash.splashFactory : InkSplash.splashFactory);

// Appwrite
Account? account;
Storage? storage;
Databases? databases;

String userId = '';
String bucketId = '667d6b95000327ce05c8';

initializeAppwrite() {
  Client client = Client();
  client
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject('667d6094000ed16eed70');

  account = Account(client);
  storage = Storage(client);
  databases = Databases(client);
}

uploadImage(CroppedFile croppedFile) async {
  final fileId = ID.unique();
  LoadingStatusHandler.startLoadingWithText("جاري رفع الصورة");
  try {
    await storage!.createFile(
      bucketId: bucketId,
      fileId: fileId,
      file: InputFile.fromPath(
          path: croppedFile.path, filename: 'profile_image_$userId.jpg'),
    );
    AppLogger.log("SUCCESSFULLY UPLOADED IMAGE");

    await storage!
        .getFileDownload(bucketId: bucketId, fileId: fileId)
        .then((bytes) async {
      AppLogger.log("SUCCESSFULLY GOT IMAGE");
      final tempPath = (await getTemporaryDirectory()).path;
      final tempFile = File('$tempPath/profileImage.jpg');
      await tempFile.writeAsBytes(bytes);
      AppLogger.log("SUCCESSFULLY WROTE IMAGE");

      base64Image = base64Encode(bytes);
      AppLogger.log("SUCCESSFULLY ENCODED IMAGE");
      AppLogger.log("base64 length: ${base64Image.length}");

      // create memoryimage from bytes
      profileImage = MemoryImage(bytes);
    });

    LoadingStatusHandler.completeLoadingWithText("تم رفع الصورة بنجاح");
  } on AppwriteException catch (e) {
    LoadingStatusHandler.errorLoading("$e");
    AppLogger.log("ERROR UPLOADING IMAGE: $e");
  }
}

// Google Maps API
String mapApiKey = '';

// Our API
String server_url = '';

initializeServerAPI() async {
  // loading server url
  final json = await rootBundle.loadString('assets/JSON/keys/server_url.json');
  // decoding json string
  Map mapObject = jsonDecode(json) as Map;
  // fetching server url  value
  server_url = mapObject['server_url'];
}

// Shared preferences
SharedPreferences? sharedPreferences;

// User data
String firstName = '';
String lastName = '';
String phoneNumber = ''; // Without '+20'

MemoryImage profileImage = MemoryImage(Uint8List(0));
String base64Image = '';
bool isLoggedIn = false; // Should get from shared preferences
bool isDriver = false; // to check if the user is a driver or passenger

updateDataToSharedPrefs() async {
  //that will update the shared preferences values
  await sharedPreferences!.setString('firstName', firstName);
  await sharedPreferences!.setString('lastName', lastName);
  await sharedPreferences!.setString('phoneNumber', phoneNumber);
  await sharedPreferences!.setString('base64Image', base64Image);
  await sharedPreferences!.setBool('isLoggedIn', isLoggedIn);
  await sharedPreferences!.setBool('isDriver', isDriver);
  AppLogger.log('LOCAL VARIABLES:');
  AppLogger.log('First Name: $firstName');
  AppLogger.log('Last Name: $lastName');
  AppLogger.log('Phone Number: $phoneNumber');
  AppLogger.log('Base64 Image: $base64Image');
  AppLogger.log('Is Logged In: $isLoggedIn');
  AppLogger.log('Is Driver: $isDriver');
  AppLogger.log('-------------------');
  AppLogger.log("SHAREDPREF:");
  AppLogger.log('First Name: ${sharedPreferences!.getString('firstName')}');
  AppLogger.log('Last Name: ${sharedPreferences!.getString('lastName')}');
  AppLogger.log('Phone Number: ${sharedPreferences!.getString('phoneNumber')}');
  AppLogger.log('Base64 Image: ${sharedPreferences!.getString('base64Image')}');
  AppLogger.log('Is Logged In: ${sharedPreferences!.getBool('isLoggedIn')}');
  AppLogger.log('Is Driver: ${sharedPreferences!.getBool('isDriver')}');
}

initValues() async {
  firstName = sharedPreferences!.getString('firstName') ?? '';
  lastName = sharedPreferences!.getString('lastName') ?? '';
  phoneNumber = sharedPreferences!.getString('phoneNumber') ?? '';
  base64Image = sharedPreferences!.getString('base64Image') ?? '';
  AppLogger.log('First name: $firstName');
  AppLogger.log('Last name: $lastName');
  AppLogger.log('Phone number: $phoneNumber');
  AppLogger.log('Base64 image: $base64Image');
}

setProfileImage() {
  if (base64Image != '') {
    profileImage = MemoryImage(base64Decode(base64Image));
  }
}

resetData() async {
  // use when user logs out
  await sharedPreferences!.clear();
}

getAllUserInfoAndAssignToVariables({required String phoneNumber}) async {
  try {
    final userInfo = await ApiService.getUserInfo(phoneNumber: phoneNumber);
    userInfo.forEach((key, value) {
      if (key == 'f_name') {
        firstName = value;
      } else if (key == 'l_name') {
        lastName = value;
      } else if (key == 'phone_num') {
        phoneNumber = value;
      }
    });

    AppLogger.log('DATA FROM SERVER:');
    AppLogger.log(userInfo);
  } catch (error) {
    AppLogger.log('Error fetching user info: $error');
  }
}
