import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/app_logger.dart';

import '../../utilities.dart';

class KeyChain {
  static String? main_server_url;
  static String? google_server_key;
  static BitmapDescriptor? driver_image;
  static BitmapDescriptor? passenger_image;

  static Future<void> Key_Chain_Initialize() async {
    // loading images
    try {
      driver_image = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(5, 5)), 'assets/driver.png');
      passenger_image = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(5, 5)), 'assets/user.png');

      /** Google server part */
      var json =
          await rootBundle.loadString('assets/JSON/keys/google_map_key.json');
      // decoding json string
      Map mapObject = jsonDecode(json) as Map;
      // fetching google map api key value
      mapApiKey = mapObject['Google_Map_Api'];
      // initializing google server api key
      KeyChain.google_server_key = mapApiKey;

      /**Main Server part */
      json = await rootBundle.loadString('assets/JSON/keys/server_url.json');
      // decoding json string
      mapObject = jsonDecode(json) as Map;
      // fetching server url  value
      String server_url = mapObject['server_url'];
      // initializing main server url
      KeyChain.main_server_url = server_url;
    } catch (error) {
      AppLogger.log(error);
    }
  }
}