import 'package:flutter/material.dart';
import 'package:logisticslims/Screens/TabTripDetails/AssignedCollectedSubmittedCancelledTripRouteDetails/AssignedTripRouteCollection/ContinueAssignTripProcess.dart';
import '../../../../Controllers/TripTrackingControllers.dart';
import '../../../../Widgets/LogisticsBottomNavigation.dart';
import '../../../../Widgets/ResponsiveBodyFontWidget.dart';
import '../../../../Widgets/CollectedSampleSubmit.dart';
import '../../../../Widgets/SnackBarMSG.dart';
import '../../../../Widgets/YesNoPopUPWidget.dart';
import 'SampleCollectionAreaWiseSubmit.dart';

class ReachedLocationTripDetails extends StatefulWidget {
  final String tripShiftId;
  final String routeMapId;
  final String areaId;
  final String areaName;
  final String duration;

  const ReachedLocationTripDetails({
    super.key,
    required this.tripShiftId,
    required this.routeMapId,
    required this.areaId,
    required this.areaName,
    required this.duration,
  });

  @override
  State<ReachedLocationTripDetails> createState() =>
      _ReachedLocationTripDetailsState();
}

class _ReachedLocationTripDetailsState
    extends State<ReachedLocationTripDetails> {
  bool _isLoading = false;

  void _reachedTrip() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await TripTrackingAPIController.fetchTripTrackingData(
        ipTripShiftId: widget.tripShiftId,
        ipRouteMapId: widget.routeMapId,
        areaId: widget.areaId,
        flag: 'R',
        totalSamples: '',
        totalContainers: '',
        trfNo: '',
        remarks: '',
        latitude: '',
        longitude: '',
        context: context,
      );

      if (response.isNotEmpty) {
        showSnackBarMessage(
            context, "The Trip Reached", const Color(0xFF027450));

        // Navigate to the next screen immediately
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SampleCollectionAreaWiseSubmitScreen(
              routeSHIFTID: widget.tripShiftId,
              submissionCenter: widget.areaName,
              areaId: widget.areaId,
              routeMapId: widget.routeMapId,
              duration: widget.duration,
            ),
          ),
        );
      }
    } catch (e) {
      showSnackBarMessage(
          context, "Error: ${e.toString()}", const Color(0xFFEB3F3F));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Header Section
              Container(
                height: responsive.screenHeight * 0.14, // 14% of screen height
                decoration: const BoxDecoration(
                  color: Color(0xFF0B66C3),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 60, 16, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ContinueAssignedTripProcess(
                                        routeMapID: widget.routeMapId,
                                        tripShiftID: widget.tripShiftId))),
                        child: Container(
                          width: responsive.screenWidth * 0.08,
                          height: responsive.screenWidth * 0.08,
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
                      SizedBox(width: responsive.screenWidth * 0.04),
                      // Title and Subtitle
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Location Details",
                            style: TextStyle(
                              fontSize: responsive.getAppBarFontSize(),
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            widget.areaName,
                            style: TextStyle(
                              fontSize: responsive.getTitleFontSize(),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/icons/location.png",
                        height: responsive.screenHeight * 0.6,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 36),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.areaName,
                              style: TextStyle(
                                fontSize: responsive.getTitleFontSize(),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            width: responsive.screenWidth * 0.09,
                            height: responsive.screenHeight * 0.05,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 6),
                            decoration: const ShapeDecoration(
                              color: Color.fromARGB(255, 227, 241, 253),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(4),
                                  bottomRight: Radius.circular(4),
                                ),
                              ),
                            ),
                            child: Text(
                              "${widget.duration} min",
                              style: TextStyle(
                                color: Color(0xFF073D75),
                                fontSize: responsive.getBodyFontSize(),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Address Text
                      // Text(
                      //   "24, Venkatappa Rd, Tasker Town, Vasanth Nagar, Hyderabad, Telangana",
                      //   style: TextStyle(
                      //     fontSize: responsive.getBodyFontSize(),
                      //     color: Colors.black54,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      const SizedBox(height: 10),

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            width: responsive.screenWidth,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: _isLoading
                                  ? null
                                  : () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(16)),
                                        ),
                                        builder: (context) {
                                          return CollectedRouteSubmitBottomSheet(
                                            heading: 'Reached Area Wise',
                                            onYesPressed: () {
                                              _reachedTrip();
                                            },
                                            onNoPressed: () {
                                              print("No button pressed");
                                            },
                                          );
                                        },
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0B66C3),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 24,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.check_sharp, size: 16),
                                  const SizedBox(width: 2),
                                  Text(
                                    "Reached",
                                    style: TextStyle(
                                      fontSize: responsive.getTitleFontSize(),
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Positioned Branch Flag
                Positioned(
                  top: -0.8, // Adjust to position the flag
                  left: -300,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      decoration: const ShapeDecoration(
                        color: Color.fromARGB(255, 227, 241, 253),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                        ),
                      ),
                      child: Text(
                        "Branch",
                        style: TextStyle(
                          color: Color(0xFF073D75),
                          fontSize: responsive.getBodyFontSize(),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
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
        ],
      ),
    );
  }
}
