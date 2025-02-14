import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../AuthProvider.dart';
import 'package:http/http.dart' as http;

import '../Models/AssignedTabTripsModels.dart';

class AssignedTabTripAPIController {
  static Future<List<AssignedTabTripModels>>
  fetchAssignedTabTripAPIs(String selectedFromDate,
      String selectedToDate, BuildContext context) async {
// Wait for loading auth response before proceeding
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Ensure loadResponses() is called and awaited
    await authProvider.loadResponses();

    final authResponse = authProvider.authResponse;
    final logINResponse = authProvider.loginResponse;

    if (authResponse == null) {
      throw Exception("Authentication data is not available.");
    }
    final jobsListAPIUrl = Uri.parse(
        '${authResponse.apiUrl}/Logistics/Routes');

    final Map<String, String> data = {
      "user_id": "${logINResponse?.userId}",//"2386",
      "session_id": "0",
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
        List<AssignedTabTripModels> assignedTabTrip =
        (responseData['Data'] as List)
            .map((item) => AssignedTabTripModels.fromJson(item))
            .toList();
        return assignedTabTrip;
      } else {
        throw Exception('Failed to load Assigned Data');
      }
    } catch (e) {
      throw Exception('Failed to load Assigned Data: $e');
    }
  }
}
