import 'package:flutter/material.dart';

import '../../../../Controllers/TripAreasControllers.dart';
import '../../../../Models/TripAreasModels.dart';
import '../../../../Widgets/AppBarWidget.dart';
import '../../../../Widgets/ResponsiveBodyFontWidget.dart';
import '../../../../Widgets/RouteDetailsWidgetContainer/TripRouteDetailsAssignedSubmittedCancelledContainer.dart';
import '../../../../Widgets/RouteDetailsWidgetContainer/TripRouteDetailsHeadingContainer.dart';
import '../../../../Widgets/SnackBarMSG.dart';
import 'RechedLocationTrip.dart';

class ContinueAssignedTripProcess extends StatefulWidget {
  final String routeMapID;
  final String tripShiftID;
  const ContinueAssignedTripProcess(
      {super.key, required this.routeMapID, required this.tripShiftID});

  @override
  State<ContinueAssignedTripProcess> createState() =>
      _ContinueAssignedTripProcessState();
}

class _ContinueAssignedTripProcessState
    extends State<ContinueAssignedTripProcess> {
  List<TripAreasModels> tripRouteAreas = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeRoteAreasData(); // Call the API when the page is first loaded
  }

  // @override
  // void didUpdateWidget(covariant CancelledTripsTabs oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //
  //   // Trigger API call again if the startDate or endDate has changed
  //   if (widget.startDate != oldWidget.startDate ||
  //       widget.endDATE != oldWidget.endDATE) {
  //     _initializeCancelledTripData();
  //   }
  // }

  Future<void> _initializeRoteAreasData() async {
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
                        onTap: () => Navigator.pop(context),
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
                  child: HeadingDetailsContainer(
                    headerFlag: "AH",
                    startTime: headerDetails["startTime"],
                    estimatedTime: headerDetails["estimatedTime"],
                    timeTaken: headerDetails["timeTaken"],
                    samples: headerDetails["samples"],
                    containers: headerDetails["containers"],
                    trf: headerDetails["trf"],
                    receiverId: "",
                    remarks: "",
                    submittedImage: "",
                    submissionCenter: '',
                  ),
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

                    String truckImage =
                        (tripRouteAreas.isNotEmpty && index == 0)
                            ? "assets/icons/LightBlueTruck.png"
                            : "assets/icons/GreyTruck.png";
                    bool isLastItem = (tripRouteAreas.isNotEmpty &&
                        index == tripRouteAreas.length - 1);

                    return TripRouteDetailsAssignedSubmittedCancelledContainer(
                      branchName: trip.areaName,
                      time: "NA",
                      address: "",
                      isCompleted: true,
                      isStartingPoint: index == 0,
                      submissionCenter: isLastItem ? trip.routeMapAreaName : "",
                      context: context,
                      truckImage: truckImage,
                      isLastItem: isLastItem,
                    );
                  },
                ),
              ),
            ),

            // Sticky Button
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ReachedLocationTripDetails(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0B66C3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Start",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )),
          ]))
    ]));
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
