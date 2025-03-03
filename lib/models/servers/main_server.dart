import 'dart:convert';
import 'dart:core';

import 'package:tawsela_app/app_logger.dart';
import 'package:tawsela_app/models/data_models/accepted_request_model.dart/accepted_request.dart';
import 'package:tawsela_app/models/data_models/user_request_model/request_model.dart';
import 'package:tawsela_app/models/data_models/trip_model/trip.dart';
import 'package:http/http.dart' as http;
import 'package:tawsela_app/models/get_it.dart/key_chain.dart';

class MainServer {
  static final serverUrl = KeyChain.main_server_url;

  /* CREATE TRIP */

  static Future<void> createTrip({required Trip trip}) async {
    AppLogger.log("TRIP: ${trip.toJson()}");
    // forming url
    final String endPoint = '${MainServer.serverUrl!}/api/trips';
    // posting request data
    var response = await http.post(Uri.parse(endPoint),
        headers: <String, String>{
          'Authorization':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MTkyNzc2MjIsImV4cCI6MTcxOTI3NzkyMn0.yAIQj_ANHbErwvQQe-SHWJnYoz-87UD3YbYjhdaloxo',
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8'
        },
        body: jsonEncode(trip.toJson()));
    AppLogger.log(response.body);
    AppLogger.log('Trip created');
  }

  /* GET_TRIP_BY_ID */
  static Future<Trip> getTripById({required String trip_id}) async {
    // forming url
    final String endPoint = '${MainServer.serverUrl!}/api/trips/$trip_id';
    //fetching data from server
    http.Response response = await http.get(Uri.parse(endPoint));
    // decoding json string
    Map<String, dynamic> json =
        jsonDecode(response.body) as Map<String, dynamic>;
    // deserialize json object to Trip class
    AppLogger.log('get trip by id');
    return Trip.fromJson(json);
  }

  /* CREATE A USER REQUEST */
  static Future<void> createRequest({required UserRequest request}) async {
    // forming url
    final String endPoint = '${MainServer.serverUrl!}/api/requests';
    AppLogger.log(endPoint);
    // posting trip data\
    AppLogger.log('creating request');
    http.Response? response;

    response = await http.post(Uri.parse(endPoint),
        headers: <String, String>{
          'Authorization':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MTkyNzc2MjIsImV4cCI6MTcxOTI3NzkyMn0.yAIQj_ANHbErwvQQe-SHWJnYoz-87UD3YbYjhdaloxo',
          'Content-Type': 'application/json;charset=UTF-8',
        },
        body: jsonEncode(request.toJson()));
    AppLogger.log('${response.statusCode}');
    AppLogger.log(response.body);
    AppLogger.log('Request has been made');
  }

  /* ACCEPT REQUEST */
  static Future<void> acceptRequest(
      {required String request_id, required String Phone_Num}) async {
    final String endPoint = '${MainServer.serverUrl!}/api/accept-req';
    http.Response? response;
    try {
      response = await http.post(Uri.parse(endPoint),
          headers: <String, String>{
            'Authorization':
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MTg5MjQ1OTAsImV4cCI6MTcxODkyNDg5MH0.D_aHDiEX32MCXef9wbu13ZFxeCKTXvcJaDJsnOxaRj8',
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8'
          },
          body: jsonEncode({
            "Accept_Req_ID": DateTime.now().toString(),
            "Req_ID": request_id,
            "Phone_Num": Phone_Num,
          }));
    } catch (error) {
      AppLogger.log('${error}acceptRequest function');
      AppLogger.log(response?.body);
    }
    AppLogger.log('request is accepted');
  }

  static Future<AcceptedRequest> isAcceptedRequest(
      {required String request_id}) async {
    final String endPoint =
        '${MainServer.serverUrl!}/api/accept-req/$request_id';
    final http.Response response = await http.get(Uri.parse(endPoint));
    Map<String, dynamic> json = jsonDecode(response.body);
    AppLogger.log(json);
    return AcceptedRequest.fromJson(json);
  }

  static Future<List<UserRequest>> getAllRequests() async {
    // forming url
    final String endPoint = '${MainServer.serverUrl!}/api/requests';
    //fetching data from server
    http.Response response = await http.get(Uri.parse(endPoint));
    // decoding json string
    List json = jsonDecode(response.body) as List;
    // deserialize json object to Trip class
    List<UserRequest> requests =
        json.map((e) => UserRequest.fromJson(e)).toList();
    AppLogger.log(requests);
    return requests;
  }

  static Future<UserRequest> getRequestById(
      {required String userRequestId}) async {
    // forming url
    final String endPoint =
        '${MainServer.serverUrl!}/api/requests/$userRequestId';
    //fetching data from server
    http.Response response = await http.get(Uri.parse(endPoint));
    // decoding json string
    Map<String, dynamic> json =
        jsonDecode(response.body) as Map<String, dynamic>;
    // deserialize json object to Trip class
    UserRequest userRequest = UserRequest.fromJson(json);
    return userRequest;
  }

  static Future<void> deleteRequestById({required String userRequestId}) async {
    // forming url
    //fetching data from server
  }

  static Future<bool> isRequestCancelled(String request_id) async {
    final String endPoint =
        '${MainServer.serverUrl!}/api/cancel-req/$request_id';
    try {
      http.Response? response = await http.get(Uri.parse(endPoint));
      List json = jsonDecode(response.body);
      if (json.isEmpty) {
        return false;
      } else {
        return true;
      }
    } catch (error) {
      return false;
    }
  }

  static Future<bool> isTripStarted(String requestId) async {
    final String endPoint = '${MainServer.serverUrl!}api/trips$requestId';
    try {
      http.Response? response = await http.get(Uri.parse(endPoint));
      jsonDecode(response.body);

      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> isTripEnded(String requestId) async {
    final String endPoint = '${MainServer.serverUrl!}api/trips$requestId';
    try {
      http.Response? response = await http.get(Uri.parse(endPoint));
      Map<String, dynamic> json = jsonDecode(response.body);
      Trip trip = Trip.fromJson(json);
      if (trip.End_Time == '' || trip.End_Time == null) {
        return false;
      } else {
        return true;
      }
    } catch (error) {
      return false;
    }
  }

  static Future<void> endTrip(String tripId) async {

  }

  static Future<void> cancelRequest(
      {required String phone_num,
      required String request_id,
      required String canceller}) async {

  }
}