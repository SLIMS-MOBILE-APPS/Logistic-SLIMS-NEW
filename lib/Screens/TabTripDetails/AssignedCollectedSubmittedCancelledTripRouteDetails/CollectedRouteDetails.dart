import 'package:flutter/material.dart';

import '../../../Controllers/RouteDetailsCollectedSubmittedCancelledControllers.dart';
import '../../../Models/RouteDetailsSubmittedCancelledModels.dart';
import '../../../Widgets/ResponsiveBodyFontWidget.dart';
import '../../../Widgets/RouteDetailsWidgetContainer/TripRouteDetailsAssignedSubmittedCancelledContainer.dart';
import '../../../Widgets/RouteDetailsWidgetContainer/TripRouteDetailsHeadingContainer.dart';
import '../../../Widgets/CollectionDetailsSubmittedCollected.dart';

class CollectedRouteTripDetails extends StatefulWidget {
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
  final String submissionLocationID;
  final String submissionCenter;

  const CollectedRouteTripDetails({
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
    required this.submissionLocationID,
    required this.submissionCenter,
  });

  @override
  State<CollectedRouteTripDetails> createState() =>
      _CollectedRouteTripDetailsState();
}

class _CollectedRouteTripDetailsState extends State<CollectedRouteTripDetails> {
  late Future<List<RouteDetailsCollectedSubmittedCancelledModels>>
      _futureCollectedTripDetails;

  @override
  void initState() {
    super.initState();
    _futureCollectedTripDetails = _fetchCollectedRouteDetails();
  }

  Future<List<RouteDetailsCollectedSubmittedCancelledModels>>
      _fetchCollectedRouteDetails() async {
    return await RouteDetailsCollectedSubmittedCancelledAPIController
        .fetchRouteDetailsSubmittedCancelledAPIs(
      widget.routeId,
      widget.flag,
      widget.routeShiftId,
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return Scaffold(
      body: FutureBuilder<List<RouteDetailsCollectedSubmittedCancelledModels>>(
        future: _futureCollectedTripDetails,
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
                child: Text('No collected trip details found.'));
          }

          final collectedTripDetails = snapshot.data!;

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
                                  child: Text("Collected Trip Details",
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
                            0.14, // 33% of screen height
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
                              headerFlag: "CH",
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
                            0.37, // 33% of screen height
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          child: SizedBox(
                            height: responsive.screenHeight * 0.50,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: collectedTripDetails.length,
                              itemBuilder: (context, index) {
                                final trip = collectedTripDetails[index];

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
                                      index == collectedTripDetails.length - 1
                                          ? widget.submissionCenter
                                          : "",
                                  showSubmissionCenter:
                                      false, // Use actual data
                                  context: context,
                                  truckImage: truckImage,
                                  isLastItem: index ==
                                      collectedTripDetails.length -
                                          1, // Pass the selected image dynamically
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
                            child: SizedBox(
                              width: responsive.screenWidth,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SampleCollectionScreen(
                                        // isLastRoute: false,
                                        // isSubmitted: false,
                                        isSubmittedPage: false,
                                        submittedImage: "", // Pass the submittedImage
                                        capturedImages: [], // Also pass it in the list
                                        samples: "",
                                        containers: "",
                                        trf: "",
                                        remarks: "",
                                        routeSHIFTID:widget.routeShiftId,
                                        submissionCenterLocationID: widget.submissionLocationID,
                                        SubmissionCenter: widget.submissionCenter,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0B66C3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/icons/doublecheckwhite.png",
                                      width: 15,
                                      height: 15,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      "Submit",
                                      style: TextStyle(
                                        fontSize: responsive.getTitleFontSize(),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
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
