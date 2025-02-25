import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../AuthProvider.dart';
import '../Models/TripTrackingModels.dart';

class TripTrackingAPIController {
  static Future<List<TripTrackingModels>> fetchTripTrackingData({
    required String ipTripShiftId,
    required String ipRouteMapId,
    required String areaId,
    required String flag,
    required String totalSamples,
    required String totalContainers,
    required String trfNo,
    required String remarks,
    required String latitude,
    required String longitude,
    required BuildContext context,
  }) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.loadResponses();

    final authResponse = authProvider.authResponse;
    final logINResponse = authProvider.loginResponse;

    if (authResponse == null) {
      throw Exception("Authentication data is not available.");
    }

    final Uri apiUrl = Uri.parse('${authResponse.apiUrl}/Logistics/TripTracking');

    final Map<String, String> data = {
      "IP_TRIP_SHIFT_ID": ipTripShiftId,
      "IP_ROUTE_MAP_ID": ipRouteMapId,
      "IP_USER_ID": "${logINResponse?.userId}",
      "IP_AREA_ID": areaId,
      "IP_SESSION_ID": "3",
      "IP_FLAG": flag,
      "IP_TOTAL_SAMPLES": totalSamples,
      "IP_TOTAL_CONTAINERS": totalContainers,
      "IP_TRF_NO": trfNo,
      "IP_REMARKS": remarks,
      "IMG_PATH": "",
      "IP_LATTITUDE": latitude,
      "IP_LONGITUDE": longitude,
      "IP-ADDRESS": "",
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

        if (responseData['status'] != "201") {
          throw Exception("API responded with status: ${responseData['status']}");
        }

        if (responseData['Data'] == null || !(responseData['Data'] is List)) {
          return [];
        }

        return (responseData['Data'] as List)
            .map((item) => TripTrackingModels.fromJson(item))
            .toList();
      } else {
        throw Exception(
            'Failed to fetch Trip Tracking Data: HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('API Request Failed: $e');
    }
  }
}
