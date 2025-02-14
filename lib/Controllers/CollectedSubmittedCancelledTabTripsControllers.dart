import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../AuthProvider.dart';
import 'package:http/http.dart' as http;

import '../Models/CollectedSubmittedCancelledTabTripsModels.dart';

class CollectedSubmittedCancelledTabTripAPIController {
  static Future<List<CollectedSubmittedCancelledTabTripModels>>
      fetchCollectedSubmittedCancelledTabTripAPIs(String selectedFromDate,
          String selectedToDate, String FLAG, BuildContext context) async {
// Wait for loading auth response before proceeding
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Ensure loadResponses() is called and awaited
    await authProvider.loadResponses();

    final authResponse = authProvider.authResponse;
    final logINResponse = authProvider.loginResponse;

    if (authResponse == null) {
      throw Exception("Authentication data is not available.");
    }
    final jobsListAPIUrl =
        Uri.parse('${authResponse.apiUrl}/Logistics/StatusWiseTrips');

    final Map<String, String> data = {
      "IP_USER_ID": "${logINResponse?.userId}", //"2386",
      "IP_FROM_DT": selectedFromDate.split(' ')[0], //"2025-01-01",
      "IP_TO_DT": selectedToDate.split(' ')[0], //"2025-01-03",
      "IP_FLAG": FLAG, //"SU",
      "connection": authResponse.connectionString
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
        final responseData = jsonDecode(response.body);
        print('Response Body: ${response.body}');
        List<CollectedSubmittedCancelledTabTripModels>
            collectedSubmittedCancelledTabTrip = (responseData['Data'] as List)
                .map((item) =>
                    CollectedSubmittedCancelledTabTripModels.fromJson(item))
                .toList();
        return collectedSubmittedCancelledTabTrip;
      } else {
        throw Exception('Failed to load DashBoard Data');
      }
    } catch (e) {
      throw Exception('Failed to load DashBoard Data: $e');
    }
  }
}
