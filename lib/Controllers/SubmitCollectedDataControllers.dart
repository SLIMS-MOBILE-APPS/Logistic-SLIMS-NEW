import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../AuthProvider.dart';
import 'package:http/http.dart' as http;
import '../models/SubmitCollectedDataModels.dart'; // Import your model class

class SubmitCollectedDataAPIController {
  static Future<List<SubmitCollectedDataModels>> fetchSubmitCollectedDataAPIs({
    required String ipSamples,
    required String ipLocationId,
    required String ipRemarks,
    required String ipTripShiftId,
    required String ipReceivedSamples,
    required String ipReceiverName,
    required String ipShiftFrom,
    required String ipShiftTo,
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
        Uri.parse('${authResponse.apiUrl}/Logistics/Submitsamples');

    final Map<String, String> data = {
      "IP_SAMPLES": ipSamples,
      "IP_LOCATION_ID": ipLocationId,
      "IP_REMARKS": ipRemarks,
      "IP_USER_ID": "${logINResponse?.userId}", //"2386",,
      "IP_TRIP_ID": ipTripShiftId,
      "IP_RECEIVED_SAMPLES": ipReceivedSamples,
      "IP_RECEIVER_NAME": ipReceiverName,
      "IP_SHIFT_FROM": ipShiftFrom,
      "IP_SHIFT_TO": ipShiftTo,
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
            .map((item) => SubmitCollectedDataModels.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load SubmittedCancelledRouteDetails Data');
      }
    } catch (e) {
      throw Exception('Failed to load SubmittedCancelledRouteDetails Data: $e');
    }
  }

}
