import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../AuthProvider.dart';
import 'package:http/http.dart' as http;
import '../Models/FinishRouteAreaWiseModels.dart';

class FinishRouteAreaWiseController {
  static Future<List<FinishRouteAreaWiseModels>> fetchFinishRouteAreaWiseAPIs({
    required String ipTripShiftId,
    required BuildContext context,
  }) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.loadResponses();

    final authResponse = authProvider.authResponse;
    final logINResponse = authProvider.loginResponse;

    if (authResponse == null) {
      throw Exception("Authentication data is not available.");
    }

    final Uri apiUrl =
        Uri.parse('${authResponse.apiUrl}/Logistics/FinishedTrip');

    final Map<String, String> data = {
      "IP_REMARKS": "",
      "IP_USER_ID": "${logINResponse?.userId}", //"2386",,
      "IP_TRIP_ID": ipTripShiftId, //"2629",
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

        if (responseData['Data'] == null ||
            (responseData['Data'] as List).isEmpty) {
          return [];
        }

        return (responseData['Data'] as List)
            .map((item) => FinishRouteAreaWiseModels.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load FinishTripAreaWise Data');
      }
    } catch (e) {
      throw Exception('Failed to load FinishTripAreaWise Data: $e');
    }
  }
}
