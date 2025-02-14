import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../AuthProvider.dart';
import 'package:http/http.dart' as http;

import '../Models/RouteDetailsSubmittedCancelledModels.dart';

class RouteDetailsCollectedSubmittedCancelledAPIController {
  static Future<List<RouteDetailsCollectedSubmittedCancelledModels>>
      fetchRouteDetailsSubmittedCancelledAPIs(String routeID, String FLAG,
          String tripShiftID, BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.loadResponses();

    final authResponse = authProvider.authResponse;
    final logINResponse = authProvider.loginResponse;

    if (authResponse == null) {
      throw Exception("Authentication data is not available.");
    }

    final jobsListAPIUrl =
        Uri.parse('${authResponse.apiUrl}/Logistics/Routeareas');

    final Map<String, String> data = {
      "IP_ROUTE_ID": routeID,
      "IP_USER_ID": "${logINResponse?.userId}",
      "IP_SESSION_ID": "1",
      "IP_FLAG": FLAG,
      "IP_TRIP_SHIFT_ID": tripShiftID,
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

      print('Raw Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        if (responseData['Data'] == null ||
            (responseData['Data'] as List).isEmpty) {
          return [];
        }

        return (responseData['Data'] as List)
            .map((item) => RouteDetailsCollectedSubmittedCancelledModels.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load SubmittedCancelledRouteDetails Data');
      }
    } catch (e) {
      throw Exception('Failed to load SubmittedCancelledRouteDetails Data: $e');
    }
  }
}
