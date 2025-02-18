import 'package:flutter/material.dart';

import '../../../Controllers/RouteDetailsCollectedSubmittedCancelledControllers.dart';
import '../../../Models/RouteDetailsSubmittedCancelledModels.dart';
import '../../../Widgets/ResponsiveBodyFontWidget.dart';
import '../../../Widgets/RouteDetailsWidgetContainer/TripRouteDetailsAssignedSubmittedCancelledContainer.dart';
import '../../../Widgets/RouteDetailsWidgetContainer/TripRouteDetailsHeadingContainer.dart';

class SubmittedRouteTripDetails extends StatefulWidget {
  final String routeId;
  final String flag;
  final String routeShiftId;
  final String startTime;
  final String estimateTime;
  final String timeTaken;
  final String samples;
  final String containers;
  final String TRFS;
  final String UploadedImageBase64;
  final String receiverID;
  final String remarks;
  final String submissionCenter;

  const SubmittedRouteTripDetails({
    super.key,
    required this.routeId,
    required this.flag,
    required this.routeShiftId,
    required this.startTime,
    required this.estimateTime,
    required this.timeTaken,
    required this.samples,
    required this.containers,
    required this.TRFS,
    required this.UploadedImageBase64,
    required this.receiverID,
    required this.remarks,
    required this.submissionCenter,
  });

  @override
  State<SubmittedRouteTripDetails> createState() =>
      _SubmittedRouteTripDetailsState();
}

class _SubmittedRouteTripDetailsState extends State<SubmittedRouteTripDetails> {
  late Future<List<RouteDetailsCollectedSubmittedCancelledModels>>
      _futureSubmittedTripDetails;

  @override
  void initState() {
    super.initState();
    _futureSubmittedTripDetails = _fetchSubmittedRouteDetails();
  }

  Future<List<RouteDetailsCollectedSubmittedCancelledModels>>
      _fetchSubmittedRouteDetails() async {
    return await RouteDetailsCollectedSubmittedCancelledAPIController
        .fetchRouteDetailsSubmittedCancelledAPIs(
      widget.routeId,
      widget.flag,
      widget.routeShiftId,
      context,
    );
  }

  // final List<Map<String, dynamic>> TripDetailsSubmitted = [
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
  //     "isCompleted": true,
  //     "isStarting": false,
  //     "submissionCenter": "L.B Nagar Test Facility",
  //   },
  //   {
  //     "branchName": 'Western Hills',
  //     "time": '3:15 pm',
  //     "address": '348/6, SHOP 4 & 5, 1ST PHASE, 8TH BMAI...',
  //     "isCompleted": true,
  //     "isStarting": false,
  //     "submissionCenter": "L.B Nagar Test Facility",
  //   },
  //   {
  //     "branchName": 'Sangeeth Nagar Colony',
  //     "time": '3:15 pm',
  //     "address": 'near, Site no 91, 3rd Block, 3rd Main,...',
  //     "isCompleted": true,
  //     "isStarting": false,
  //     "submissionCenter": "L.B Nagar Test Facility",
  //   },
  //   {
  //     "branchName": 'Khiratabad',
  //     "time": '3:15 pm',
  //     "address": 'D:No 25 & 16, Mahadev, Klavo clinics &...',
  //     "isCompleted": true,
  //     "isStarting": false,
  //     "submissionCenter": "L.B Nagar Test Facility",
  //   },
  // ];
  //
  // final Map<String, dynamic> headerDetails = {
  //   "startTime": "10:00 am",
  //   "estimatedTime": "2h 48m",
  //   "timeTaken": "--",
  //   "samples": "5",
  //   "containers": "3",
  //   "trf": "250",
  //   "receiverId": "",
  //   "remarks": "All samples collected successfully.",
  //   "submittedImage": "assets/icons/sample_photo.png",
  // };

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return Scaffold(
      body: FutureBuilder<List<RouteDetailsCollectedSubmittedCancelledModels>>(
        future: _futureSubmittedTripDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('No submitted trip details found.'));
          }

          final submittedTripDetails = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: responsive.screenHeight, // Take full screen height
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        right: 0,
                        child: Container(
                          height: responsive.screenHeight *
                              0.26, // 42% of screen height
                          decoration: const BoxDecoration(
                            color: Color(0xFF0B66C3),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                16, responsive.screenHeight * 0.07, 16, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    width: responsive.screenWidth * 0.08,
                                    height: responsive.screenHeight * 0.05,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      color: Colors.white,
                                      size: 22.0,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(18, 10, 0, 0),
                                  child: Text("Submitted Trip Details",
                                      style: TextStyle(
                                          fontSize:
                                              responsive.getAppBarFontSize(),
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: responsive.screenHeight *
                            0.12, // 33% of screen height
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.14), // Shadow color
                                  spreadRadius: 5, // Spread radius
                                  blurRadius: 7, // Blur radius
                                  offset: const Offset(
                                      0, 3), // Changes position of shadow
                                ),
                              ],
                            ),
                            child: HeadingDetailsContainer(
                              headerFlag: "SH",
                              startTime: widget.startTime.split(" ")[1],
                              estimatedTime: widget.estimateTime,
                              timeTaken: widget.timeTaken,
                              samples: widget.samples,
                              containers: widget.containers,
                              trf: widget.TRFS,
                              receiverId: widget.receiverID,
                              remarks: widget.remarks,
                              submittedImage: widget.UploadedImageBase64,
                              submissionCenter: widget.submissionCenter,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: responsive.screenHeight *
                            0.48, // 33% of screen height
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          child: SizedBox(
                            height: responsive.screenHeight * 0.50,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: submittedTripDetails.length,
                              itemBuilder: (context, index) {
                                final trip = submittedTripDetails[index];

                                // Condition for setting the image
                                String truckImage = index == 0
                                    ? "assets/icons/LightBlueTruck.png" // First item
                                    : "assets/icons/SubmittedTruck.png"; // Other items

                                // Condition for setting the time
                                String timeText = index == 0
                                    ? (trip.startDt?.split(" ")[1] ??
                                        "N/A") // First item shows start time
                                    : (trip.completedDt?.split(" ")[1] ??
                                        "N/A"); // Others show completed time

                                return TripRouteDetailsAssignedSubmittedCancelledContainer(
                                  branchName: trip.areaName,
                                  time: timeText,
                                  address: "",
                                  isCompleted: true,
                                  isStartingPoint: index ==
                                      0, // First item is the starting point
                                  submissionCenter:
                                      index == submittedTripDetails.length - 1
                                          ? widget.submissionCenter
                                          : "",
                                  showSubmissionCenter:
                                      false, // Use actual data
                                  context: context,
                                  truckImage: truckImage,
                                  isLastItem: index ==
                                      submittedTripDetails.length -
                                          1, // Pass the selected image dynamically
                                );
                              },
                              // child: ListView.builder(
                              //   shrinkWrap: true,
                              //   padding: EdgeInsets.zero,
                              //   itemCount: submittedTripDetails.length,
                              //   itemBuilder: (context, index) {
                              //     final trip = submittedTripDetails[index];
                              //     return TripRouteDetailsAssignedSubmittedCancelledContainer(
                              //       branchName: trip.areaName ?? "Unknown Area",
                              //       time: trip.startDate ?? "N/A",
                              //       address: trip.routeMapAreaName ?? "No address",
                              //       isCompleted: trip.completedDate != null,
                              //       isStartingPoint: index == 0,
                              //       submissionCenter: trip.areaName ?? "Submission Center",
                              //       showSubmissionCenter: index == submittedTripDetails.length - 1,
                              //       context: context,
                              //     );
                              //   },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
