import 'package:flutter/material.dart';
import 'package:logisticslims/Screens/TabTripDetails/AssignedCollectedSubmittedCancelledTripRouteDetails/CollectedRouteDetails.dart';

import '../Controllers/AcceptRejectTripController.dart';
import '../Models/AcceptRejectTripModels.dart';
import '../Screens/TabTripDetails/AssignedCollectedSubmittedCancelledTripRouteDetails/AssignedTripRouteCollection/ContinueAssignTripProcess.dart';
import '../Screens/TabTripDetails/AssignedCollectedSubmittedCancelledTripRouteDetails/CancelledRouteDetails.dart';
import '../Screens/TabTripDetails/AssignedCollectedSubmittedCancelledTripRouteDetails/SubmittedRouteDetails.dart';
import 'LogisticsBottomNavigation.dart';
import 'ResponsiveBodyFontWidget.dart';
import 'YesNoPopUPWidget.dart';

class TripDetailsWidget extends StatefulWidget {
  final String startTime;
  final String estimatedTime;
  final String timeTakenDuration;
  final List<String> locations;
  final String submissionLocationID;
  final String submissionCenter;
  final bool showButtons;
  final String assetsImage;
  final String TabFlag;
  final int routeMapID;
  final int tripShiftID;
  final String totalSamples;
  final String containers;
  final String TRFS;
  final String base64Images;
  final String remarks;
  final String receiverID;
  final String? isActiveRoute;
  final String? routeStepCount;

  const TripDetailsWidget({
    Key? key,
    required this.startTime,
    required this.estimatedTime,
    required this.timeTakenDuration,
    required this.locations,
    required this.submissionLocationID,
    required this.submissionCenter,
    this.showButtons = false,
    required this.assetsImage,
    required this.TabFlag,
    required this.routeMapID,
    required this.tripShiftID,
    required this.totalSamples,
    required this.containers,
    required this.TRFS,
    required this.base64Images,
    required this.remarks,
    required this.receiverID,
    this.isActiveRoute,
    this.routeStepCount,
  }) : super(key: key);

  @override
  State<TripDetailsWidget> createState() => _TripDetailsWidgetState();
}

class _TripDetailsWidgetState extends State<TripDetailsWidget> {
  bool isLoading = false;

  Future<void> handleAcceptReject(String flag) async {
    setState(() => isLoading = true);

    try {
      // Fetch the data from the API
      List<AcceptRejectTripModels> response =
          await AcceptRejectTripAPIController.fetchAcceptRejectTripDataAPIs(
        ipTripShiftId: widget.tripShiftID.toString(),
        ipFlag: flag, // Pass "AC" for Accept, "RE" for Reject
        context: context,
      );

      setState(() => isLoading = false);

      // Check if the response is not empty or contains the expected data
      if (response.isNotEmpty) {
        if (flag == "AC") {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ContinueAssignedTripProcess()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NavigationScreen()),
          );
        }
      } else {
        // Handle the case where the response is empty or not as expected
        print('No data in response');
        // Optionally, show an error message or Snackbar
      }
    } catch (e) {
      setState(() => isLoading = false);
      print("Error: $e");
      // Optionally, show an error message or Snackbar here as well
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: InkWell(
        onTap: navigateToDetails,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFFE6E9EF)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    shadows: const [
                      BoxShadow(
                          color: Color(0x05192F54),
                          blurRadius: 8,
                          offset: Offset(0, 4)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInfoRow(
                          widget.TabFlag == "C" ? "STARTED" : "START",
                          "${widget.startTime}",
                          widget.assetsImage,
                          responsive),
                      const SizedBox(height: 16),
                      buildLocationList(responsive),
                      const SizedBox(height: 16),
                      buildInfoRow(
                          "SUBMISSION",
                          "${widget.submissionCenter}",
                          (widget.TabFlag == "A" ||
                                  widget.TabFlag == "C" ||
                                  widget.TabFlag == "R")
                              ? "assets/icons/GreyTruck.png"
                              : widget.assetsImage,
                          responsive),
                      if (widget.showButtons) ...[
                        const SizedBox(height: 16),
                        widget.TabFlag == 'C'
                            ? _buildSubmitButton(context, responsive)
                            : int.parse("${widget.routeStepCount}") > 0
                                ? _buildContinueButton(context)
                                : widget.isActiveRoute == "Y"
                                    ? _buildDeclineAcceptRow(
                                        context, responsive)
                                    : widget.isActiveRoute == "N"
                                        ? _buildExpiredButton(responsive)
                                        : Container(),
                      ],
                    ],
                  ),
                ),
                Positioned(
                  top: 2,
                  right: 15,
                  child: Container(
                    width: responsive.screenWidth * 0.3,
                    height: responsive.screenHeight * 0.024,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: ShapeDecoration(
                      color: widget.TabFlag == "A"
                          ? Color.fromARGB(255, 227, 241, 253)
                          : widget.TabFlag == "S" || widget.TabFlag == "C"
                              ? Color.fromARGB(255, 228, 242, 237)
                              : Color.fromARGB(255, 255, 229, 228),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                    ),
                    child: Text(
                      widget.TabFlag == "A"
                          ? "Est: ${widget.estimatedTime}"
                          : widget.TabFlag == "S" || widget.TabFlag == "C"
                              ? "Time taken: ${widget.timeTakenDuration}"
                              : "Cancelled",
                      style: TextStyle(
                        color: widget.TabFlag == "A"
                            ? Color(0xFF073D75)
                            : widget.TabFlag == "S" || widget.TabFlag == "C"
                                ? Color.fromARGB(255, 3, 117, 81)
                                : Color.fromARGB(255, 218, 71, 72),
                        fontSize: responsive.getNormalRangeFontSize(),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void navigateToDetails() {
    if (widget.TabFlag == "R") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CancelledRouteTripDetails(
            routeId: "${widget.routeMapID}",
            flag: 'RJ',
            routeShiftId: "${widget.tripShiftID}",
            startTime: "${widget.startTime}",
            estimateTime: "${widget.estimatedTime}",
            timeTaken: "${widget.timeTakenDuration}",
            submissionCenter: "${widget.submissionCenter}",
          ),
        ),
      );
    } else if (widget.TabFlag == "S") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SubmittedRouteTripDetails(
            routeId: "${widget.routeMapID}",
            flag: 'SU',
            routeShiftId: "${widget.tripShiftID}",
            startTime: "${widget.startTime}",
            estimateTime: "${widget.estimatedTime}",
            timeTaken: "${widget.timeTakenDuration}",
            samples: "${widget.totalSamples}",
            containers: "${widget.containers}",
            TRFS: "${widget.TRFS}",
            UploadedImageBase64: "${widget.base64Images}",
            receiverID: "${widget.receiverID}",
            remarks: "${widget.remarks}",
            submissionCenter: "${widget.submissionCenter}",
          ),
        ),
      );
    }
  }

  Color getTabColor() {
    switch (widget.TabFlag) {
      case "C":
        return Color.fromARGB(255, 0, 104, 198);
      case "S":
        return Color.fromARGB(255, 59, 186, 137);
      default:
        return Colors.blue[100]!;
    }
  }

  Widget buildLocationList(ResponsiveUtils responsive) {
    return Column(
      children: widget.locations.map((location) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Column(
                  children: [
                    Container(
                      width: 6,
                      height: 8,
                      decoration: BoxDecoration(
                        color: getTabColor(),
                        shape: BoxShape.circle,
                      ),
                    ),
                    if (location != widget.locations.last)
                      Container(width: 1, height: 24, color: getTabColor()),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  location,
                  style: TextStyle(
                    fontSize: responsive.getBodyFontSize(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget buildInfoRow(String label, String value, String assetImage,
      ResponsiveUtils responsive) {
    bool isSubmission = label == "SUBMISSION"; // Check if it's submission
    return Container(
      width: responsive.screenWidth * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      clipBehavior: Clip.antiAlias,
      decoration: isSubmission
          ? ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFFE6E9EF)),
                borderRadius:
                    BorderRadius.circular(8), // Rounded only for submission
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x05192F54),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            )
          : const BoxDecoration(),
      child: Row(
        children: [
          Image.asset(assetImage, width: 30, height: 30, fit: BoxFit.contain),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                    fontSize: responsive.getBodyFontSize(),
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 157, 155, 157),
                  )),
              Text(value,
                  style: TextStyle(
                    fontSize: responsive.getTitleFontSize(),
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context, ResponsiveUtils responsive) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CollectedRouteTripDetails(
                          routeId: "${widget.routeMapID}",
                          flag: 'C',
                          routeShiftId: "${widget.tripShiftID}",
                          startTime: "${widget.startTime}",
                          estimateTime: "${widget.estimatedTime}",
                          timeTaken: "${widget.timeTakenDuration}",
                          samples: "${widget.totalSamples}",
                          containers: "${widget.containers}",
                          TRFS: "${widget.TRFS}",
                          UploadedImageBase64: "",
                          receiverID: "",
                          remarks: "",
                          submissionLocationID:
                              "${widget.submissionLocationID}",
                          submissionCenter: "${widget.submissionCenter}",
                        )));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0B66C3),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/icons/doublecheckwhite.png",
                  width: 15, height: 15),
              const SizedBox(width: 2),
              Text("Submit",
                  style: TextStyle(
                      fontSize: responsive.getTitleFontSize(),
                      color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ContinueAssignedTripProcess()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0B66C3),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Continue',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  Widget _buildDeclineAcceptRow(
      BuildContext context, ResponsiveUtils responsive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDeclineButton(context, responsive),
        _buildAcceptButton(context, responsive),
      ],
    );
  }

  Widget _buildDeclineButton(BuildContext context, ResponsiveUtils responsive) {
    return SizedBox(
      width: responsive.screenWidth * 0.3,
      height: 40,
      child: OutlinedButton(
        onPressed: () => _showBottomSheet(context, "RE"),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFB0B0B0), width: 1),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.close_rounded, size: 16),
            SizedBox(width: 2),
            Text('Decline',
                style: TextStyle(
                    color: Color(0xFF0B66C3), fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildAcceptButton(BuildContext context, ResponsiveUtils responsive) {
    return SizedBox(
      width: responsive.screenWidth * 0.48,
      height: 41,
      child: ElevatedButton(
        onPressed: () => _showBottomSheet(context, "AC"),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0B66C3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_sharp, size: 16),
            SizedBox(width: 2),
            Text('Accept',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildExpiredButton(ResponsiveUtils responsive) {
    return SizedBox(
      width: responsive.screenWidth,
      height: 40,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFB0B0B0), width: 1),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.close_rounded, size: 16),
            SizedBox(width: 2),
            Text('Expired',
                style: TextStyle(
                    color: Color(0xFF0B66C3), fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, String action) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return CollectedRouteSubmitBottomSheet(
          heading: 'Submit Collected Route Data',
          onYesPressed: () async {
            if (isLoading) return;
            setState(() => isLoading = true);
            await handleAcceptReject(action);
            setState(() => isLoading = false);
          },
          onNoPressed: () => print("No button pressed"),
        );
      },
    );
  }
}
