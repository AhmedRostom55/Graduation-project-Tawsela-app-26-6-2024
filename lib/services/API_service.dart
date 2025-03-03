import 'package:http/http.dart';
import 'dart:convert';

import 'package:tawsela_app/utilities.dart';

import '../app_logger.dart';

enum APIRequestType {
  signUp,
  logIn,
}

class ApiService {
  static Future<Map<String, dynamic>> getUserInfo({
    required String phoneNumber,
  }) async {
    final url = Uri.parse('$server_url/api/users/$phoneNumber');
    final response = await get(url, headers: {'Content-Type': 'application/json'});

    final error = handleError(response);
    if (error != null) {
      throw error;
    } else {
     
      isLoggedIn=true;
      return json.decode(response.body) as Map<String, dynamic>;
    }
  }

  static Future<bool> checkAccountExists({
    required String phoneNumber,
  }) async {
    final url = Uri.parse('$server_url/api/users/$phoneNumber');
    final response = await get(url, headers: {'Content-Type': 'application/json'});

    final error = handleError(response);
    if (error != null) {
      throw error;
    } else {
      return true;
    }
  }

static Future<void> signUp({
  required String phoneNumber,
  required String fname,
  required String lname,
  required String typeUser,
  // String? profileImageURL,
  String? overallRating
}) async {
  final url = Uri.parse('$server_url/api/users');
  final response = await post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'Phone_Num': phoneNumber,
      'F_Name': fname,
      'L_Name': lname,
      'Type_User': typeUser,
    }),
  );
  final error = handleError(response);
  if (error != null) {
    throw error;
  } else {
    await updateDataToSharedPrefs();
  }
}

  static Future<void> logIn({
    required String phoneNumber,
  }) async {
    final url = Uri.parse('$server_url/api/auth/login');
    final response = await post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'Phone_Num': phoneNumber,
      }),
    );
    AppLogger.log(response.body);
    final error = handleError(response);
    if (error != null) {
      throw error;
    } else {
      // Set the user as logged in
      isLoggedIn = true;
    }
  }

  static Future<void> deleteAccount({
    required String phoneNumber,
  }) async {
    final url = Uri.parse('$server_url/api/users/$phoneNumber');
    final response = await delete(url);

    final error = handleError(response);
    if (error != null) {
      throw error;
    } else {
      AppLogger.log("Account deleted successfully");
    }
  }

  static String? handleError(Response response) {
    String? error;
    switch (response.statusCode) {
      case 200: // Success
        error = null;
        break;
      case 201: // Created or updated
        error = null;
        break;
      case 404: // Not found
        error = 'Not found';
        break;
      case 409: // Already exists error (conflict)
        error = 'هذا الحساب موجود بالفعل';
        break;
      case 500: // Internal server error (no internet connection, server down, etc.)
        AppLogger.log(response.body);
        error = 'تأكد من اتصالك بالانترنت';
        break;
      default:
        error = response.body;
        break;
    }
    return error;
  }
}