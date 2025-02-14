import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../AuthProvider.dart';
import '../Models/LogisticLoginModels.dart';

class LogisticLoginController {
  static Future<LogisticLoginModels> fetchLogisticLogin(
      String userName, String paSSWORD, BuildContext context) async {
    // Get the AuthProvider
    final authResponse =
        Provider.of<AuthProvider>(context, listen: false).authResponse;

    if (authResponse == null) {
      throw Exception("Authentication data is not available.");
    }

    final jobsListAPIUrl = Uri.parse('${authResponse.apiUrl}/Logistics/Login');

    final Map<String, String> data = {
      "User_name": userName.split(':')[1],
      "password": paSSWORD,
      "connection": authResponse.connectionString,
    };

    try {
      final response = await http.post(
        jobsListAPIUrl,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: data,
        encoding: Encoding.getByName("utf-8"),
      );

      if (response.statusCode == 200) {
        // Decode the response
        Map<String, dynamic> responseData = jsonDecode(response.body);

        // Parse the Data field
        if (responseData.containsKey('Data') && responseData['Data'] is List) {
          return LogisticLoginModels.fromJson(responseData['Data'][0]);
        } else {
          throw Exception(
              "Invalid response format: Missing or incorrect 'Data' field");
        }
      } else {
        throw Exception(
            "Failed to log in: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }
}
