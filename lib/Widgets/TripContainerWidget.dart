import 'package:flutter/material.dart';
import 'package:logisticslims/Screens/TabTripDetails/AssignedCollectedSubmittedCancelledTripRouteDetails/CollectedRouteDetails.dart';

import '../Screens/TabTripDetails/AssignedCollectedSubmittedCancelledTripRouteDetails/AssignedTripRouteCollection/ContinueAssignTripProcess.dart';
import '../Screens/TabTripDetails/AssignedCollectedSubmittedCancelledTripRouteDetails/CancelledRouteDetails.dart';
import '../Screens/TabTripDetails/AssignedCollectedSubmittedCancelledTripRouteDetails/SubmittedRouteDetails.dart';
import 'ResponsiveBodyFontWidget.dart';

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
  bool isAccepted = false;
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: InkWell(
        onTap: () {
          widget.TabFlag == "R"
              ? Navigator.push(
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
                          )))
              : widget.TabFlag == "S"
                  ? Navigator.push(
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
                              )))
                  : null;
        },
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding:const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
                  // margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(side: const BorderSide(width: 1, color: Color(0xFFE6E9EF)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x05192F54),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0x05192F54),
                        blurRadius: 15,
                        offset: Offset(0, 15),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0x02192F54),
                        blurRadius: 20,
                        offset: Offset(0, 33),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0x00192F54),
                        blurRadius: 24,
                        offset: Offset(0, 59),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0x00192F54),
                        blurRadius: 26,
                        offset: Offset(0, 92),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                widget.assetsImage,
                                width: 30,
                                height: 30,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("START",
                                    style: TextStyle(
                                        fontSize: responsive.getBodyFontSize(),
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 157, 155, 157)),
                                  ),
                                  Text(
                                    "${widget.startTime}",
                                    style: TextStyle(
                                      fontSize: responsive.getTitleFontSize(),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
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
                                          color: widget.TabFlag == "A"
                                              ? Colors.blue[100]
                                              : widget.TabFlag == "C"
                                                  ? Color.fromARGB(255, 0, 104, 198)
                                                  : widget.TabFlag == "S"
                                                      ? Color.fromARGB(255, 59, 186, 137)
                                                      : Colors.blue[100],
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      // Vertical line
                                      if (location != widget.locations.last)
                                        Container(
                                            width: 1,
                                            height: 24,
                                            color: widget.TabFlag == "A"
                                                ? Colors.blue[100]
                                                : widget.TabFlag == "C"
                                                    ? Color.fromARGB(255, 0, 104, 198)
                                                    : widget.TabFlag == "S"
                                                        ? Color.fromARGB(255, 59, 186, 137)
                                                        : Colors.blue[100]),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    location,
                                    style: TextStyle(
                                        fontSize: responsive.getBodyFontSize(),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      // Submission center
                      Container(
                        width: responsive.screenWidth * 0.9,
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(width: 1, color: Color(0xFFE6E9EF)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x05192F54),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            (widget.TabFlag == "A" || widget.TabFlag == "C" || widget.TabFlag == "R")
                                ? Image.asset("assets/icons/GreyTruck.png",
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.contain,
                                  )
                                : Image.asset(widget.assetsImage,
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.contain,
                                  ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("SUBMISSION",
                                  style: TextStyle(
                                      fontSize: responsive.getBodyFontSize(),
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 157, 155, 157)),
                                ),
                                Text("${widget.submissionCenter}",
                                  style: TextStyle(
                                    fontSize: responsive.getTitleFontSize(),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (widget.showButtons) ...[
                        const SizedBox(height: 16),
                        widget.TabFlag == 'C'
                            ? Center(
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                          CollectedRouteTripDetails(
                                            routeId:"${widget.routeMapID}",
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
                                            submissionLocationID: "${widget.submissionLocationID}",
                                            submissionCenter: "${widget.submissionCenter}",
                                          )));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF0B66C3),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset("assets/icons/doublecheckwhite.png",
                                          width: 15,
                                          height: 15,
                                          fit: BoxFit.contain,
                                        ),
                                        const SizedBox(width: 2),
                                        Text("Submit",
                                          style: TextStyle(
                                            fontSize: responsive.getTitleFontSize(),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : int.parse("${widget.routeStepCount}") > 0 && widget.TabFlag == 'A'
                                ? Center(
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 40,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(context,MaterialPageRoute(
                                                  builder: (context) => ContinueAssignedTripProcess()));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF0B66C3),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text('Continue',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : widget.isActiveRoute == "Y"
                                    ? Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Decline Button
                                          SizedBox(
                                            width: responsive.screenWidth * 0.3,
                                            height: 40,
                                            child: OutlinedButton(
                                              onPressed: () {
                                                // Handle Decline button click
                                              },
                                              style: OutlinedButton.styleFrom(
                                                side: const BorderSide(
                                                  color: Color(0xFFB0B0B0),
                                                  width: 1,
                                                ),
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),
                                              child: const Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.close_rounded, size: 16),
                                                  SizedBox(width: 2),
                                                  Text('Decline',
                                                    style: TextStyle(
                                                      color: Color(0xFF0B66C3), // Text color (blue)
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: responsive.screenWidth * 0.48,
                                            height: 41,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  isAccepted = true;
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(0xFF0B66C3),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),
                                              child: const Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.check_sharp, size: 16),
                                                  SizedBox(width: 2),
                                                  Text('Accept',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox(
                          width: responsive.screenWidth,
                          height: 40,
                          child: OutlinedButton(
                            onPressed: () {
                              // Handle Decline button click
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color(0xFFB0B0B0),
                                width: 1,
                              ),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.close_rounded, size: 16),
                                SizedBox(width: 2),
                                Text('Expired',
                                  style: TextStyle(
                                    color: Color(0xFF0B66C3), // Text color (blue)
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]
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
}
