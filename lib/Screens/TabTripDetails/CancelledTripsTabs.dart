import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../Controllers/CollectedSubmittedCancelledTabTripsControllers.dart';
import '../../Models/CollectedSubmittedCancelledTabTripsModels.dart';
import '../../Widgets/NoDataFoundWidget.dart';
import '../../Widgets/SnackBarMSG.dart';
import '../../Widgets/TripContainerWidget.dart';

class CancelledTripsTabs extends StatefulWidget {
  String startDate;
  String endDATE;

  CancelledTripsTabs({Key? key, required this.startDate, required this.endDATE})
      : super(key: key);
  @override
  State<CancelledTripsTabs> createState() => _CancelledTripsTabsState();
}

class _CancelledTripsTabsState extends State<CancelledTripsTabs> {
  List<CollectedSubmittedCancelledTabTripModels> cancelledTabTrips = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeCancelledTripData(); // Call the API when the page is first loaded
  }

  @override
  void didUpdateWidget(covariant CancelledTripsTabs oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Trigger API call again if the startDate or endDate has changed
    if (widget.startDate != oldWidget.startDate ||
        widget.endDATE != oldWidget.endDATE) {
      _initializeCancelledTripData();
    }
  }

  Future<void> _initializeCancelledTripData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<CollectedSubmittedCancelledTabTripModels> cancelledTrips =
          await CollectedSubmittedCancelledTabTripAPIController
              .fetchCollectedSubmittedCancelledTabTripAPIs(
                  widget.startDate, widget.endDATE, "RJ", context);

      setState(() {
        cancelledTabTrips = cancelledTrips;
      });
    } catch (error) {
      showSnackBarMessage(context, "Failed to fetch cancelled data: $error",
          const Color(0xFFEB3F3F));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : cancelledTabTrips.isEmpty
              ? const NoDataFoundWidget(tabName: "No Cancelled Data")
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: cancelledTabTrips.length,
                  itemBuilder: (context, index) {
                    final trip = cancelledTabTrips[index];

                    // Handling dynamic data with null checks
                    return TripDetailsWidget(
                      startTime: "${trip.shiftFromDt + "  "+trip.shiftFrom}" ??
                          "N/A", // Default value if null
                      estimatedTime:
                          calculateDuration(trip.shiftFrom, trip.shiftTo),
                      timeTakenDuration: '',
                      locations: trip.areaNames?.split(',') ??
                          ["No locations available"],
                      submissionLocationID: "${trip.locationId}",
                      submissionCenter: trip.submittedCenter ?? "N/A",
                      showButtons:
                          false, // Assuming no buttons for cancelled trips
                      assetsImage: "assets/icons/CancelledTruck.png",
                      TabFlag: 'R', routeMapID: trip.routeMapId,
                      tripShiftID: trip.tripShiftId,
                      totalSamples: '',
                      containers: '',
                      TRFS: '',
                      base64Images: '',
                      remarks: '',
                      receiverID: '',
                    );
                  },
                ),
    );
  }

  /// Helper function to calculate trip duration
  String calculateDuration(String? shiftFrom, String? shiftTo) {
    if (shiftFrom == null || shiftTo == null) return "N/A";

    try {
      final fromTime = _parseTime(shiftFrom);
      final toTime = _parseTime(shiftTo);

      final duration = toTime.difference(fromTime);
      final hours = duration.inHours;
      final minutes = duration.inMinutes % 60;

      return "${hours}h ${minutes}m";
    } catch (e) {
      return "N/A";
    }
  }

  /// Parse time string into DateTime
  DateTime _parseTime(String time) {
    final format =
        time.contains("AM") || time.contains("PM") ? "h:mma" : "HH:mm";
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(time.split(":")[0]) + (time.contains("PM") ? 12 : 0),
      int.parse(time.split(":")[1].replaceAll(RegExp(r'\D'), '')),
    );
  }
}
// final List<Map<String, dynamic>> trips = [
// {
// "startTime": "10:00 AM",
// "estimatedTime": "2h 30m",
// "locations": [
// "Simhapuri Colony",
// "Pragathi Nagar",
// "Western Hills",
// "Sangeeth Nagar Colony",
// "Khirtabad",
// ],
// "submissionCenter": "L.B Nagar Test Facility",
// "showButtons": false,
// },
// {
// "startTime": "10:00 AM",
// "estimatedTime": "2h 30m",
// "locations": [
// "Simhapuri Colony",
// "Pragathi Nagar",
// "Western Hills",
// "Sangeeth Nagar Colony",
// "Khirtabad",
// ],
// "submissionCenter": "L.B Nagar Test Facility",
// "showButtons": false,
// },
// ];

// ListView.builder(
//   padding: EdgeInsets.zero,
//   itemCount: trips.length,
//   itemBuilder: (context, index) {
//     final trip = trips[index];
//     return TripDetailsWidget(
//       startTime: trip["startTime"],
//       estimatedTime: trip["estimatedTime"],
//       locations: List<String>.from(trip["locations"]),
//       submissionCenter: trip["submissionCenter"],
//       showButtons: trip["showButtons"],
//       assetsImage: "assets/icons/CancelledTruck.png",
//       TabFlag: 'C',
//     );
//   },
// ),
