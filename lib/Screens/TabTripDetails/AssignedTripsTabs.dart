import 'package:flutter/material.dart';
import '../../Controllers/AssignedTabTripController.dart';
import '../../Models/AssignedTabTripsModels.dart';
import '../../Widgets/NoDataFoundWidget.dart';
import '../../Widgets/SnackBarMSG.dart';
import '../../Widgets/TripContainerWidget.dart';

class AssignedTripsTabs extends StatefulWidget {
  String startDate;
  String endDATE;
  // final List<AssignedTabTripModels> assignedTabTrips;

  AssignedTripsTabs({Key? key, required this.startDate, required this.endDATE})
      : super(key: key);

  @override
  State<AssignedTripsTabs> createState() => _AssignedTripsTabsState();
}

class _AssignedTripsTabsState extends State<AssignedTripsTabs> {
  List<AssignedTabTripModels> assignedTabTrips = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeAssignedTripData(); // Call the API when the page is first loaded
  }

  @override
  void didUpdateWidget(covariant AssignedTripsTabs oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Trigger API call again if the startDate or endDate has changed
    if (widget.startDate != oldWidget.startDate ||
        widget.endDATE != oldWidget.endDATE) {
      _initializeAssignedTripData();
    }
  }

  Future<void> _initializeAssignedTripData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<AssignedTabTripModels> assignedTrips =
          await AssignedTabTripAPIController.fetchAssignedTabTripAPIs(
              widget.startDate, widget.endDATE, context);

      setState(() {
        assignedTabTrips = assignedTrips;
      });
    } catch (error) {
      showSnackBarMessage(context, "Failed to fetch assigned data: $error",
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
          : assignedTabTrips.isEmpty
              ? const NoDataFoundWidget(tabName: "No Assigned Data")
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: assignedTabTrips.length,
                  itemBuilder: (context, index) {
                    final trip = assignedTabTrips[index];
                    return TripDetailsWidget(
                      startTime:
                          "${trip.shiftFromDate + " | " + trip.shiftFrom}" ??
                              "N/A",
                      estimatedTime:
                          calculateDuration(trip.shiftFrom, trip.shiftTo),
                      timeTakenDuration: '',
                      locations: trip.areaNames?.split(',') ??
                          ["No locations available"],
                      submissionLocationID: '',
                      submissionCenter: trip.routeName ?? "N/A",
                      showButtons: true,
                      assetsImage: "assets/icons/AssignedTruck.png",
                      TabFlag: 'A',
                      routeMapID: trip.routeMapId,
                      tripShiftID: trip.tripShiftId,
                      totalSamples: '',
                      containers: '',
                      TRFS: '',
                      base64Images: '',
                      remarks: '',
                      receiverID: '',
                      isActiveRoute: trip.isActive,
                      routeStepCount: "${trip.stepCount}",
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

// Example data
//         final List<Map<String, dynamic>> trips = [
//         {
//         "startTime": "10:00 AM",
//         "estimatedTime": "2h 30m",
//         "locations": [
//         "Simhapuri Colony",
//         "Pragathi Nagar",
//         "Western Hills",
//         "Sangeeth Nagar Colony",
//         "Khirtabad",
//         ],
//         "submissionCenter": "L.B Nagar Test Facility",
//         "showButtons": true,
//         },
//         {
//         "startTime": "10:00 AM",
//         "estimatedTime": "2h 30m",
//         "locations": [
//         "Simhapuri Colony",
//         "Pragathi Nagar",
//         "Western Hills",
//         "Sangeeth Nagar Colony",
//         "Khirtabad",
//         ],
//         "submissionCenter": "L.B Nagar Test Facility",
//         "showButtons": true,
//         },
//         ];

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
//       assetsImage: "assets/icons/AssignedTruck.png",
//       TabFlag: 'A',
//     );
//   },
// ),
