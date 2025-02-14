import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../Controllers/CollectedSubmittedCancelledTabTripsControllers.dart';
import '../../Models/CollectedSubmittedCancelledTabTripsModels.dart';
import '../../Widgets/NoDataFoundWidget.dart';
import '../../Widgets/SnackBarMSG.dart';
import '../../Widgets/TripContainerWidget.dart';

class SubmittedTripsTabs extends StatefulWidget {
  String startDate;
  String endDATE;

  SubmittedTripsTabs({Key? key, required this.startDate, required this.endDATE})
      : super(key: key);

  @override
  State<SubmittedTripsTabs> createState() => _SubmittedTripsTabsState();
}

class _SubmittedTripsTabsState extends State<SubmittedTripsTabs> {
  List<CollectedSubmittedCancelledTabTripModels> submittedTabTrips = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeSubmittedTripData(); // Call the API when the page is first loaded
  }

  @override
  void didUpdateWidget(covariant SubmittedTripsTabs oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Trigger API call again if the startDate or endDate has changed
    if (widget.startDate != oldWidget.startDate ||
        widget.endDATE != oldWidget.endDATE) {
      _initializeSubmittedTripData();
    }
  }

  Future<void> _initializeSubmittedTripData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<CollectedSubmittedCancelledTabTripModels> submittedTrips =
          await CollectedSubmittedCancelledTabTripAPIController
              .fetchCollectedSubmittedCancelledTabTripAPIs(
                  widget.startDate, widget.endDATE, "SU", context);

      setState(() {
        submittedTabTrips = submittedTrips;
      });
    } catch (error) {
      showSnackBarMessage(context, "Failed to fetch submitted data: $error",
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
          : submittedTabTrips.isEmpty
              ? const NoDataFoundWidget(tabName: "No Submitted Data")
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: submittedTabTrips.length,
                  itemBuilder: (context, index) {
                    final trip = submittedTabTrips[index];
                    return TripDetailsWidget(
                      startTime: trip.startDt ?? "N/A", // Use default if null
                      estimatedTime:
                          calculateDuration(trip.shiftFrom, trip.shiftTo),
                      timeTakenDuration: trip.duration != null
                          ? "${(trip.duration! ~/ 60)}h ${(trip.duration! % 60)}m"
                          : "N/A",
                      locations: trip.areaNames?.split(',') ??
                          ["No locations available"],
                      submissionLocationID: "${trip.locationId}",
                      submissionCenter: trip.submittedCenter ?? "N/A",
                      showButtons:
                          false, // Assuming no buttons for submitted trips
                      assetsImage: "assets/icons/SubmittedTruck.png",
                      TabFlag: 'S', routeMapID: trip.routeMapId,
                      tripShiftID: trip.tripShiftId,
                      totalSamples: "${trip.total}",
                      containers: "${trip.containers}",
                      TRFS: "${trip.trfNo}",
                      base64Images: "${trip.uploadPrescription}",
                      remarks: "${trip.submittedRemarks}",
                      receiverID: "${trip.receivedBy}",
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
//   {
//     "startTime": "10:00 AM",
//     "estimatedTime": "2h 30m",
//     "locations": [
//       "Simhapuri Colony",
//       "Pragathi Nagar",
//       "Western Hills",
//       "Sangeeth Nagar Colony",
//       "Khirtabad",
//     ],
//     "submissionCenter": "L.B Nagar Test Facility",
//     "showButtons": false,
//   },
//   {
//     "startTime": "10:00 AM",
//     "estimatedTime": "2h 30m",
//     "locations": [
//       "Simhapuri Colony",
//       "Pragathi Nagar",
//       "Western Hills",
//       "Sangeeth Nagar Colony",
//       "Khirtabad",
//     ],
//     "submissionCenter": "L.B Nagar Test Facility",
//     "showButtons": false,
//   },
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
//       assetsImage: "assets/icons/SubmittedTruck.png",
//       TabFlag: 'S',
//     );
//   },
// ),
