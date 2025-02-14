import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../AuthProvider.dart';
import 'package:http/http.dart' as http;

class UpdateImageAPIController {
  static Future<bool> updateSubmitImageBytes({
    required String tripShiftID,
    required String base64Image,
    required BuildContext context,
  }) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.loadResponses();

    final authResponse = authProvider.authResponse;
    final logINResponse = authProvider.loginResponse;

    if (authResponse == null) {
      throw Exception("Authentication data is not available.");
    }

    final Uri apiUrl = Uri.parse(
        '${authResponse.apiUrl}/Logistics/UpdateSubmitImageBytes');

    final Map<String, String> data = {
      "Trip_id": tripShiftID, // Trip Shift ID
      "Base64String": base64Image,
      "session_id": "${logINResponse?.userId}", // here we are passing the userID
      "connection": authResponse.connectionString,
    };

    try {
      final response = await http.post(
        apiUrl,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: data,
        encoding: Encoding.getByName("utf-8"),
      );

      print('Raw Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        // ✅ Success - Return true
        return responseData["status"] == "success";
      } else {
        throw Exception('Failed to update the image.');
      }
    } catch (e) {
      throw Exception('Error updating image: $e');
    }
  }
}
