import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../app_logger.dart';

enum SORT_SEARCH_OPTION { LATITUDE, LONGITUDE }

const double latitudeThreshold = 0.00005;
const double longitudeThreshold = 0.00005;

class ServicePoints {
  static List<List<LatLng>> serviceLatPoints = [];
  static List<List<LatLng>> serviceLngPoints = [];
  static const List<String> lines = [
    'assets/JSON/paths/1f.json',
    'assets/JSON/paths/2f.json',
    'assets/JSON/paths/3f.json',
    'assets/JSON/paths/4f.json',
    'assets/JSON/paths/5f.json',
    'assets/JSON/paths/6f.json',
    'assets/JSON/paths/7f.json',
    'assets/JSON/paths/8f.json',
    'assets/JSON/paths/9f.json',
    'assets/JSON/paths/1b.json',
    'assets/JSON/paths/2b.json',
    'assets/JSON/paths/3b.json',
    'assets/JSON/paths/4b.json',
    'assets/JSON/paths/5b.json',
    'assets/JSON/paths/6b.json',
    'assets/JSON/paths/7b.json',
    'assets/JSON/paths/8b.json',
    'assets/JSON/paths/9b.json',
    'assets/JSON/paths/13f.json',
    'assets/JSON/paths/17f.json',
    'assets/JSON/paths/13b.json',
    'assets/JSON/paths/17b.json',
  ];

  // getters

  // load service lines from json files
  static Future<void> loadLines({bool sorted = false}) async {
    serviceLatPoints = List.empty(growable: true);
    serviceLngPoints = List.empty(growable: true);
    // for each path of a file load file
    for (int i = 0; i < lines.length; i++) {
      // load file data from path
      String points = await rootBundle.loadString(lines[i]);
      // convert json string into json object
      var json = jsonDecode(points) as Map;
      // extract points form json object
      List snappedPoints = json["snappedPoints"];
      // getting longitude and latitude of each point in snapped point
      List<LatLng> line = snappedPoints.map((e) {
        return LatLng(e["location"]["latitude"], e["location"]["longitude"]);
      }).toList();
      // sort points by latitude and adding it to serviceLatPoints
      if (sorted) _sort(points: line, option: SORT_SEARCH_OPTION.LATITUDE);
      serviceLatPoints.add(line);

      // sort points by longitude and adding it to serviceLngPoints
      if (sorted) _sort(points: line, option: SORT_SEARCH_OPTION.LONGITUDE);
      serviceLngPoints.add(line);
    }
  }

  static LatLng getNearesPoint(
      {required LatLng point,
      required List<LatLng> line,
      SORT_SEARCH_OPTION option = SORT_SEARCH_OPTION.LATITUDE}) {
    if (option == SORT_SEARCH_OPTION.LATITUDE) {
      double latitudeDistance = 1;
      int latitudeSteps = 0;
      LatLng bestLatitude = line[0];
      while (latitudeDistance > latitudeThreshold) {
        latitudeDistance = point.latitude - bestLatitude.latitude;
        AppLogger.log('Latitude distance = $latitudeDistance');
        if (latitudeDistance <= latitudeThreshold) {
          break;
        }
        latitudeSteps += (latitudeDistance ~/ latitudeThreshold).abs();
        if (latitudeSteps < line.length) {
          bestLatitude = line[latitudeSteps];
        } else {
          bestLatitude = line[line.length - 1];
          break;
        }
      }
      return bestLatitude;
    } else {
      LatLng bestLongitude = line[0];
      double longitudeDistance = 1;

      int longitudeSteps = 0;
      while (longitudeDistance > longitudeThreshold) {
        longitudeDistance = point.longitude - bestLongitude.longitude;
        AppLogger.log('Longitude distance = $longitudeDistance');

        if (longitudeDistance <= longitudeThreshold) {
          break;
        }
        longitudeSteps += (longitudeDistance ~/ longitudeThreshold).abs();

        if (longitudeSteps < line.length) {
          bestLongitude = line[longitudeSteps];
        } else {
          bestLongitude = line[line.length - 1];
          break;
        }
      }
      return bestLongitude;
    }
  }

  static void _sort(
      {SORT_SEARCH_OPTION option = SORT_SEARCH_OPTION.LATITUDE,
      required List<LatLng> points}) {
    // performing sorting on points by latitude
    for (int i = 1; i <= points.length; i++) {
      for (int j = 0; j < points.length - 1; j++) {
        if (option == SORT_SEARCH_OPTION.LATITUDE) {
          if (points[j].latitude > points[j + 1].latitude) {
            LatLng temp = points[j + 1];
            points[j + 1] = points[j];
            points[j] = temp;
          }
        } else {
          if (points[j].longitude > points[j + 1].longitude) {
            LatLng temp = points[j + 1];
            points[j + 1] = points[j];
            points[j] = temp;
          }
        }
      }
    }
  }

  static LatLng LatLngBinarySearch(
      {SORT_SEARCH_OPTION option = SORT_SEARCH_OPTION.LATITUDE,
      required LatLng point,
      required List<LatLng> points}) {
    int start = 0;
    int end = points.length - 1;
    double error = double.maxFinite;
    LatLng mostApproximateValue = const LatLng(-1, -1);
    while (start <= end) {
      int middle = (start + end) ~/ 2;
      final current_error = (point.latitude - points[middle].latitude).abs();
      if (current_error < error) {
        mostApproximateValue = points[middle];
        // if error reaches the threshold
        if (current_error <= latitudeThreshold) {
          break;
        }
        // update error
        error = current_error;

        // get error from left point in the line
        final leftPoint = points[middle - 1];
        final leftError = (leftPoint.latitude - point.latitude).abs();
        // get error from right point in the line
        final rightPoint = points[middle + 1];
        final rightError = (rightPoint.latitude - point.latitude).abs();

        if (rightError < error) {
          start = middle + 1;
        } else if (leftError < error) {
          end = middle - 1;
        } else {
          break;
        }
      } else if (current_error > error) {}
      if (option == SORT_SEARCH_OPTION.LATITUDE) {
        // check error of the point to get better estimation
        if (error == double.maxFinite && // check if it is initial state
            mostApproximateValue.latitude == -1 &&
            mostApproximateValue.longitude == -1) {
          mostApproximateValue = points[middle];
          error =
              (points[middle].latitude - mostApproximateValue.latitude).abs();
        }
        // if new error is smaller than the old error
        else if ((points[middle].latitude - point.latitude).abs() < error) {
          mostApproximateValue = points[middle];
          error =
              (points[middle].latitude - mostApproximateValue.latitude).abs();
        }

        // ordinary binary search steps
        if (points[middle].latitude < point.latitude) {
          start = middle + 1;
        } else if (points[middle].latitude > point.latitude) {
          end = middle - 1;
        } else {
          mostApproximateValue = points[middle];
          break;
        }
      } else {
        // same sequence but for option longitude
        if (error == double.maxFinite &&
            mostApproximateValue.latitude == -1 &&
            mostApproximateValue.longitude == -1) {
          mostApproximateValue = points[middle];
          error =
              (points[middle].longitude - mostApproximateValue.longitude).abs();
        } else if ((points[middle].longitude - point.longitude).abs() < error) {
          mostApproximateValue = points[middle];
          error =
              (points[middle].longitude - mostApproximateValue.longitude).abs();
        }

        // binary search steps
        if (points[middle].longitude < point.longitude) {
          start = middle + 1;
        } else if (points[middle].longitude > point.longitude) {
          end = middle - 1;
        } else {
          mostApproximateValue = points[middle];
          break;
        }
      }
    }
    return mostApproximateValue;
  }
}