import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../Controllers/CollectedSubmittedCancelledTabTripsControllers.dart';
import '../../Models/CollectedSubmittedCancelledTabTripsModels.dart';
import '../../Widgets/NoDataFoundWidget.dart';
import '../../Widgets/SnackBarMSG.dart';
import '../../Widgets/TripContainerWidget.dart';

class CollectedTripsTabs extends StatefulWidget {
  String startDate;
  String endDATE;

  CollectedTripsTabs({Key? key, required this.startDate, required this.endDATE})
      : super(key: key);

  @override
  State<CollectedTripsTabs> createState() => _CollectedTripsTabsState();
}

class _CollectedTripsTabsState extends State<CollectedTripsTabs> {
  List<CollectedSubmittedCancelledTabTripModels> collectedTabTrips = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeCollectedTripData(); // Call the API when the page is first loaded
  }

  @override
  void didUpdateWidget(covariant CollectedTripsTabs oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Trigger API call again if the startDate or endDate has changed
    if (widget.startDate != oldWidget.startDate ||
        widget.endDATE != oldWidget.endDATE) {
      _initializeCollectedTripData();
    }
  }

  Future<void> _initializeCollectedTripData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<CollectedSubmittedCancelledTabTripModels> collectedTrips =
          await CollectedSubmittedCancelledTabTripAPIController
              .fetchCollectedSubmittedCancelledTabTripAPIs(
                  widget.startDate, widget.endDATE, "C", context);

      setState(() {
        collectedTabTrips = collectedTrips;
      });
    } catch (error) {
      showSnackBarMessage(context, "Failed to fetch collected data: $error",
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
          : collectedTabTrips.isEmpty
              ? const NoDataFoundWidget(tabName: "No Collected Data")
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: collectedTabTrips.length,
                  itemBuilder: (context, index) {
                    final trip = collectedTabTrips[index];
                    return TripDetailsWidget(
                      startTime:
                          "${trip.shiftFromDt + " | " + trip.shiftFrom}" ??
                              "N/A", // Use default if null
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
                          true, // Assuming no buttons for submitted trips
                      assetsImage: "assets/icons/collectedTruck.png",
                      TabFlag: 'C', routeMapID: trip.routeMapId,
                      tripShiftID: trip.tripShiftId,
                      totalSamples: "${trip.total ?? 0}",
                      containers: "${trip.containers ?? 0}",
                      TRFS: "${trip.trfNo ?? 0}",
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
