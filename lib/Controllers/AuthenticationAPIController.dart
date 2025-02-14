import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../AuthProvider.dart';
import '../Models/AuthenticationModels.dart';

class AuthenticationAPIController {
  static Future<AuthenticationAPIModels?> fetchAuthenticationAPIs(
      String userName, BuildContext context) async {
    final apiUrl = Uri.parse(
        'https://mobileappjw.softmed.in/Logistics/APP_VALIDATION_MOBILE');

    final Map<String, String> requestData = {
      "IP_USER_NAME": userName,
      "IP_PASSWORD": "",
      "connection": "7",
    };

    try {
      final response = await http.post(
        apiUrl,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: requestData,
        encoding: Encoding.getByName("utf-8"),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        print("API Response: ${response.body}");

        if (responseData.containsKey("Data") && responseData["Data"] is List) {
          final List<dynamic> data = responseData["Data"];

          if (data.isNotEmpty) {
            final Map<String, dynamic> authData = data[0];
            final authModel = AuthenticationAPIModels.fromJson(authData);

            // Save the model to AuthProvider
            await Provider.of<AuthProvider>(context, listen: false)
                .saveAuthResponse(authModel);

            return authModel;
          } else {
            throw Exception("API returned empty data.");
          }
        } else {
          throw Exception("Invalid data format in API response.");
        }
      } else {
        throw Exception(
            "Failed API call with status code ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Error fetching login response: $error");
    }
  }


}
