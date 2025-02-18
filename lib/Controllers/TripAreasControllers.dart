import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../AuthProvider.dart';
import 'package:http/http.dart' as http;
import '../Models/TripAreasModels.dart';

class TripAreasAPIController {
  static Future<List<TripAreasModels>> fetchTripAreasDataAPIs({
    required String ipRouteMapId,
    required BuildContext context,
  }) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.loadResponses();

    final authResponse = authProvider.authResponse;
    final logINResponse = authProvider.loginResponse;

    if (authResponse == null) {
      throw Exception("Authentication data is not available.");
    }

    final Uri apiUrl = Uri.parse('${authResponse.apiUrl}/Logistics/Routeareas');

    final Map<String, String> data = {
      "IP_ROUTE_ID": ipRouteMapId, //"1",
      "IP_USER_ID": "${logINResponse?.userId}", //"2386",
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
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Validate API response status inside JSON
        if (responseData['status'] != "201") {
          throw Exception("API responded with status: ${responseData['status']}");
        }

        if (responseData['Data'] == null || !(responseData['Data'] is List)) {
          return [];
        }

        return (responseData['Data'] as List)
            .map((item) => TripAreasModels.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to fetch TripRouteDetails Data: HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('API Request Failed: $e');
    }
  }
}
