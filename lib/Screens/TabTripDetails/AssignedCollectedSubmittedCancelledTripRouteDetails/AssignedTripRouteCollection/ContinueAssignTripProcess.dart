import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logisticslims/Widgets/LogisticsBottomNavigation.dart';

import '../../../../Controllers/AssignedTabTripController.dart';
import '../../../../Controllers/FinishRouteAreaWiseController.dart';
import '../../../../Controllers/TripAreasControllers.dart';
import '../../../../Controllers/TripTrackingControllers.dart';
import '../../../../Models/AssignedTabTripsModels.dart';
import '../../../../Models/FinishRouteAreaWiseModels.dart';
import '../../../../Models/TripAreasModels.dart';
import '../../../../Widgets/AppBarWidget.dart';
import '../../../../Widgets/ResponsiveBodyFontWidget.dart';
import '../../../../Widgets/RouteDetailsWidgetContainer/TripRouteDetailsAssignedCollectedSubmittedCancelledContainer.dart';
import '../../../../Widgets/RouteDetailsWidgetContainer/TripRouteDetailsHeadingContainer.dart';
import '../../../../Widgets/SnackBarMSG.dart';
import '../../../../Widgets/YesNoPopUPWidget.dart';
import 'RechedLocationTrip.dart';

class ContinueAssignedTripProcess extends StatefulWidget {
  final String routeMapID;
  final String tripShiftID;

  const ContinueAssignedTripProcess({
    super.key,
    required this.routeMapID,
    required this.tripShiftID,
  });

  @override
  State<ContinueAssignedTripProcess> createState() =>
      _ContinueAssignedTripProcessState();
}

class _ContinueAssignedTripProcessState
    extends State<ContinueAssignedTripProcess> {
  List<TripAreasModels> tripRouteAreas = [];
  bool _isLoading = false;
  String stepCount = "0"; // Default value before API fetch

  @override
  void initState() {
    super.initState();
    _fetchStepCount(); // Fetch step count from API
    _initializeRouteAreasData(); // Fetch trip areas
  }

  /// Fetch step count from API when the page loads
  Future<void> _fetchStepCount() async {
    try {
      List<AssignedTabTripModels> assignedTrips =
          await AssignedTabTripAPIController.fetchAssignedTabTripAPIs(
              "", "", widget.tripShiftID, context);

      if (assignedTrips.isNotEmpty) {
        setState(() {
          stepCount = assignedTrips.first.stepCount?.toString() ??
              "0"; // Ensure it is not null
        });
        print("Step Count Fetched: $stepCount"); // Debugging print
      }
    } catch (error) {
      showSnackBarMessage(context, "Failed to fetch step count: $error",
          const Color(0xFFEB3F3F));
    }
  }

  Future<void> _initializeRouteAreasData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<TripAreasModels> tripAreaWise =
          await TripAreasAPIController.fetchTripAreasDataAPIs(
        ipRouteMapId: widget.routeMapID,
        ipRouteShiftId: widget.tripShiftID,
        context: context,
      );

      setState(() {
        tripRouteAreas = tripAreaWise;
      });
    } catch (error) {
      showSnackBarMessage(
          context,
          "Failed to fetch Area wise Trip data: $error",
          const Color(0xFFEB3F3F));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _startNextTrip(bool isNextClicked) async {
    setState(() {
      _isLoading = true;
    });

    try {
      int currentStep = int.tryParse(stepCount) ??
          -1; // Convert stepCount to integer, default to -1 if invalid
      int totalSteps = tripRouteAreas.length;

      print("Current Step: $currentStep");
      print("Total Steps: $totalSteps");
      print("Is Next Button Clicked: $isNextClicked"); // Debug log

      if (currentStep < -1 || currentStep >= totalSteps) {
        showSnackBarMessage(
            context, "Invalid step count!", const Color(0xFFEB3F3F));
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // ✅ Assign dataset correctly based on step count
      var currentArea = tripRouteAreas[currentStep == -1 ? 0 : currentStep];
      String areaId = currentArea.areaId.toString();
      String areaName = currentArea.areaName ?? "Unknown Area";
      String duration = currentArea.duration.toString();

      if (isNextClicked) {
        // ✅ Navigate to next area directly (NO API call for Next)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ReachedLocationTripDetails(
              tripShiftId: widget.tripShiftID,
              routeMapId: widget.routeMapID,
              areaId: areaId,
              areaName: areaName,
              duration: duration,
            ),
          ),
        );
      } else {
        // 👉 If Start is clicked, make API call
        final response = await TripTrackingAPIController.fetchTripTrackingData(
          ipTripShiftId: widget.tripShiftID,
          ipRouteMapId: widget.routeMapID,
          areaId: areaId,
          flag: 'S',
          totalSamples: '',
          totalContainers: '',
          trfNo: '',
          remarks: '',
          latitude: '',
          longitude: '',
          context: context,
        );

        if (response.isNotEmpty) {
          if (currentStep == -1) {
            showSnackBarMessage(
                context, "Trip Started Successfully!", const Color(0xFF027450));

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ContinueAssignedTripProcess(
                  routeMapID: widget.routeMapID,
                  tripShiftID: widget.tripShiftID,
                ),
              ),
            );
          } else {
            // No need to navigate in API response, it's handled in Next button logic
          }
        }
      }
    } catch (e) {
      showSnackBarMessage(
          context, "Error: ${e.toString()}", const Color(0xFFEB3F3F));
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  void _finishTrip() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      // Call API to finish trip
      List<FinishRouteAreaWiseModels> response =
          await FinishRouteAreaWiseController.fetchFinishRouteAreaWiseAPIs(
        ipTripShiftId: widget.tripShiftID,
        context: context,
      );

      if (response.isNotEmpty) {
        showSnackBarMessage(
            context, "Trip Finished Successfully!", const Color(0xFF027450));

        // ✅ Navigate back immediately
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NavigationScreen()));
      } else {
        showSnackBarMessage(
            context, "Failed to finish trip.", const Color(0xFFEB3F3F));
      }
    } catch (e) {
      showSnackBarMessage(
          context, "Error: ${e.toString()}", const Color(0xFFEB3F3F));
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  final Map<String, dynamic> headerDetails = {
    "startTime": "10:00 am",
    "estimatedTime": "2h 48m",
    "timeTaken": "--",
    "samples": "--",
    "containers": "--",
    "trf": "--",
  };
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);

    int totalEstimatedMinutes =
        tripRouteAreas.fold(0, (sum, item) => sum + (item.duration ?? 0));

// Convert minutes to hours and minutes
    String formattedEstimatedTime = totalEstimatedMinutes > 0
        ? "${totalEstimatedMinutes ~/ 60}h ${totalEstimatedMinutes % 60}m"
        : "--";

    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          height: responsive.screenHeight, // Take full screen height
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Stack(children: [
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: HeaderBar(
                height: responsive.screenHeight * 0.26, // Custom height
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    children: [
                      // Back button
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NavigationScreen()));
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 24.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Assigned Trip Details",
                        style: TextStyle(
                            fontSize: responsive.getAppBarFontSize(),
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: responsive.screenHeight * 0.14, // 33% of screen height
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.14), // Shadow color
                        spreadRadius: 5, // Spread radius
                        blurRadius: 7, // Blur radius
                        offset:
                            const Offset(0, 3), // Changes position of shadow
                      ),
                    ],
                  ),
                  child: tripRouteAreas.isNotEmpty
                      ? HeadingDetailsContainer(
                          headerFlag: "AH",
                          startTime:
                              tripRouteAreas[0].startDt?.split(" ")[1] ?? "--",
                          estimatedTime: formattedEstimatedTime,
                          timeTaken: (tripRouteAreas.isNotEmpty &&
                                  tripRouteAreas[0].startDt != null &&
                                  tripRouteAreas.last.completedDt != null &&
                                  tripRouteAreas[0].startDt!.split(" ").length >
                                      1 &&
                                  tripRouteAreas.last.completedDt!
                                          .split(" ")
                                          .length >
                                      1)
                              ? calculateTimeGap(
                                  tripRouteAreas[0].startDt!.split(" ")[1],
                                  tripRouteAreas.last.completedDt!
                                      .split(" ")[1],
                                )
                              : "--",
                          samples: "${tripRouteAreas[0].totalSamples ?? '--'}",
                          containers: "${tripRouteAreas[0].containers ?? '--'}",
                          trf: "${tripRouteAreas[0].trfNo ?? '--'}",
                          receiverId: "",
                          remarks: "",
                          submittedImage: "",
                          submissionCenter: '',
                        )
                      : Container(), // or a placeholder widget
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: responsive.screenHeight * 0.37, // 33% of screen height
              right: 0,
              child: SizedBox(
                height: responsive.screenHeight * 0.72,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: tripRouteAreas.length,
                  itemBuilder: (context, index) {
                    final trip = tripRouteAreas[index];

                    bool isLastItem = (tripRouteAreas.isNotEmpty &&
                        index == tripRouteAreas.length - 1);

                    // Determine the time and color dynamically
                    String time = trip.sequence == 1
                        ? (trip.startDt ?? "NA")
                        : (trip.completedDt ?? "NA");

                    Color timeColor = trip.sequence == 1
                        ? Colors.blue // Blue for startDt
                        : (trip.completedDt != null && trip.completedDt != "")
                            ? Colors.green // Green for completedDt
                            : Colors.grey; // Default grey

                    return TripRouteDetailsAssignedCollectedSubmittedCancelledContainer(
                      branchName: trip.areaName,
                      time: time,
                      address: "",
                      submissionCenter: isLastItem ? trip.routeMapAreaName : "",
                      context: context,
                      truckImage: trip.sequence == 1
                          ? "assets/icons/LightBlueTruck.png"
                          : (trip.completedDt != null && trip.completedDt != "")
                              ? "assets/icons/SubmittedTruck.png"
                              : "assets/icons/GreyTruck.png",
                      isLastItem: isLastItem,
                      timeColor: timeColor, // Pass the dynamically set color
                    );
                  },
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: responsive.screenWidth,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            int currentStep = int.tryParse(stepCount) ?? -1;
                            bool isNextClicked = currentStep != -1;
                            bool isLastStep =
                                currentStep == tripRouteAreas.length - 1;
                            bool isCompleted = isLastStep &&
                                tripRouteAreas[currentStep].completedDt != null;

                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16)),
                              ),
                              builder: (context) {
                                return CollectedRouteSubmitBottomSheet(
                                  heading: (currentStep == -1)
                                      ? 'Do you want to Start the Trip?'
                                      : isCompleted
                                          ? 'Do you want to Finish the Trip?'
                                          : 'Do you want to Visit Next Area?',
                                  onYesPressed: () {
                                    if (isCompleted) {
                                      _finishTrip();
                                    } else {
                                      _startNextTrip(isNextClicked);
                                    }
                                  },
                                  onNoPressed: () {
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _isLoading ? Colors.grey : const Color(0xFF0B66C3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      (int.tryParse(stepCount) ?? -1) == -1
                          ? "Start"
                          : ((int.tryParse(stepCount) ?? 0) ==
                                      tripRouteAreas.length - 1 &&
                                  tripRouteAreas[int.tryParse(stepCount) ?? 0]
                                          .completedDt !=
                                      null)
                              ? "Finish"
                              : "Next",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Show loading indicator in the center of the screen when _isLoading is true
            if (_isLoading)
              const Positioned.fill(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 11, 102, 195),
                  ),
                ),
              ),
          ]))
    ]));
  }

  /// Function to calculate the time gap between two 12-hour format times
  String calculateTimeGap(String startTime, String endTime) {
    try {
      // Parse start and end times
      List<String> startParts = startTime.split(":");
      List<String> endParts = endTime.split(":");

      int startHour = int.parse(startParts[0]);
      int startMinute = int.parse(startParts[1]);

      int endHour = int.parse(endParts[0]);
      int endMinute = int.parse(endParts[1]);

      // Handle PM cases (assuming 12-hour format without AM/PM indication)
      if (startHour < 6) {
        startHour +=
            12; // Treats early hours as PM (e.g., "02:56" means 2:56 PM)
      }
      if (endHour < 6) {
        endHour += 12;
      }

      // Create DateTime objects for the same day
      DateTime now = DateTime.now();
      DateTime start =
          DateTime(now.year, now.month, now.day, startHour, startMinute);
      DateTime end = DateTime(now.year, now.month, now.day, endHour, endMinute);

      // If end time is earlier than start time, assume it's the next day
      if (end.isBefore(start)) {
        end = end.add(Duration(days: 1));
      }

      // Calculate duration
      Duration duration = end.difference(start);
      int hours = duration.inHours;
      int minutes = duration.inMinutes % 60;

      return "${hours}h ${minutes}m";
    } catch (e) {
      return "Invalid time format";
    }
  }
}

// final List<Map<String, dynamic>> TripDetailsAssigned = [
//   {
//     "branchName": 'Sangeeth Nagar Colony',
//     "time": '3:15 pm',
//     "address": 'No.104, “Kothari’s CENTRUM”, Kondapur Village...',
//     "isCompleted": false,
//     "isStarting": true,
//     "submissionCenter": "L.B Nagar Test Facility",
//   },
//   {
//     "branchName": 'Pragathi Nagar',
//     "time": '3:15 pm',
//     "address": '24, Venkataappa Rd, Tasker Town, Vasanth...',
//     "isCompleted": false,
//     "isStarting": false,
//     "submissionCenter": "L.B Nagar Test Facility",
//   },
//   {
//     "branchName": 'Western Hills',
//     "time": '3:15 pm',
//     "address": '348/6, SHOP 4 & 5, 1ST PHASE, 8TH BMAI...',
//     "isCompleted": false,
//     "isStarting": false,
//     "submissionCenter": "L.B Nagar Test Facility",
//   },
//   {
//     "branchName": 'Sangeeth Nagar Colony',
//     "time": '3:15 pm',
//     "address": 'near, Site no 91, 3rd Block, 3rd Main,...',
//     "isCompleted": false,
//     "isStarting": false,
//     "submissionCenter": "L.B Nagar Test Facility",
//   },
//   {
//     "branchName": 'Khiratabad',
//     "time": '3:15 pm',
//     "address": 'D:No 25 & 16, Mahadev, Klavo clinics &...',
//     "isCompleted": false,
//     "isStarting": false,
//     "submissionCenter": "L.B Nagar Test Facility",
//   },
// ];
