import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logisticslims/Widgets/ResponsiveBodyFontWidget.dart';

import '../CollectionDetailsSubmittedCollected.dart';

class HeadingDetailsContainer extends StatelessWidget {
  final String headerFlag;
  final String startTime;
  final String estimatedTime;
  final String timeTaken;
  final String samples;
  final String containers;
  final String trf;
  final String receiverId;
  final String remarks;
  final String submittedImage;
  final String submissionCenter;

  const HeadingDetailsContainer({
    Key? key,
    required this.headerFlag,
    required this.startTime,
    required this.estimatedTime,
    required this.timeTaken,
    required this.samples,
    required this.containers,
    required this.trf,
    required this.receiverId,
    required this.remarks,
    required this.submittedImage,
    required this.submissionCenter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return InkWell(
      onTap: () {
        if (headerFlag == "SH") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SampleCollectionScreen(
                // isLastRoute: false,
                // isSubmitted: true,
                isSubmittedPage: true,
                submittedImage: submittedImage, // Pass the submittedImage
                capturedImages: [submittedImage], // Also pass it in the list
                samples: samples,
                containers: containers,
                trf: trf,
                remarks: remarks,
                routeSHIFTID: '',
                submissionCenterLocationID: '',
                SubmissionCenter: submissionCenter,
              ),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _iconWithLabel(responsive, "", "Start", startTime.toString()),
                _iconWithLabel(
                    responsive, "", "Est Time", estimatedTime.toString()),
                _iconWithLabel(responsive, "", "Time Taken", timeTaken),
              ],
            ),
            headerFlag == "SH" || headerFlag == "AH" || headerFlag == "CH"
                ? Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Divider(
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        const SizedBox(height: 5),
                        // Row with icons and counts
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            _iconWithLabel(
                                responsive,
                                "assets/icons/sample.png",
                                "Samples",
                                "${samples}"),
                            _iconWithLabel(
                                responsive,
                                "assets/icons/container.png",
                                "Containers",
                                "${containers}"),
                            _iconWithLabel(responsive, "assets/icons/trf.png",
                                "TRF", "${trf}"),
                          ],
                        ),
                      ],
                    ),
                  )
                : const SizedBox(), // Empty widget when condition is false.
            headerFlag == "SH"
                ? Container(
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        Divider(
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        const SizedBox(height: 5),
                        // Additional Details
                        ListTile(
                          leading: Container(
                              width: responsive.screenWidth * 0.30,
                              height: responsive.screenHeight * 0.20,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.memory(
                                    base64Decode(
                                        submittedImage), // Decode the Base64 string
                                    // Set image width
                                    fit: BoxFit.fill, // Adjust image fit
                                  )
                                  // Image.asset(
                                  //   "$submittedImage",
                                  //   fit: BoxFit.cover,
                                  // )
                                  )),
                          title: _iconWithLabel(responsive, "", "Receiver ID: ",
                              receiverId.toString()),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: _iconWithLabel(responsive, "", "Remarks: ",
                                remarks.toString()),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _iconWithLabel(ResponsiveUtils responsive, String assetPath,
      String label, String value) {
    return Column(
      crossAxisAlignment: (label == "Receiver ID: " || label == "Remarks: ")
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: responsive.getBodyFontSize(),
            color: Color.fromARGB(255, 159, 159, 159),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (assetPath.isNotEmpty) ...[
              Image.asset(
                assetPath,
                height: responsive.screenHeight * 0.04, // Adjust size
                width: responsive.screenWidth * 0.04, // Adjust size
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 8), // Space between image and value
            ],
            Text(
              value,
              style: TextStyle(
                fontSize: (label == "Receiver ID: " || label == "Remarks: ")
                    ? responsive.getNormalRangeFontSize()
                    : responsive.getTitleFontSize(),
                fontWeight: (label == "Receiver ID: " || label == "Remarks: ")
                    ? FontWeight.w500
                    : FontWeight.w600,
              ),
              maxLines: 2, // Restrict lines for better layout
              overflow: TextOverflow.ellipsis, // Handle overflow
            ),
          ],
        ),
      ],
    );
  }
}
