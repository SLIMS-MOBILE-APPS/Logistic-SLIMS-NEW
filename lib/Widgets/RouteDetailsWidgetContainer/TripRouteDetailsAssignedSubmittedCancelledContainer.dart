import 'package:flutter/material.dart';
import 'package:logisticslims/Widgets/ResponsiveBodyFontWidget.dart';

Widget TripRouteDetailsAssignedSubmittedCancelledContainer({
  required String branchName,
  required String time,
  required String address,
  required bool isCompleted,
  required bool isStartingPoint,
  required String submissionCenter,
  required BuildContext context,
  required String truckImage, // New parameter
  required bool isLastItem,
}) {
  final responsive = ResponsiveUtils(context);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Image.asset(truckImage),
                if (!isLastItem) // Remove vertical bar for last item
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 0),
                    child: Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Branch',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Row(
                      children: [
                        Text(
                          branchName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        Text(
                          time,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      address,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (submissionCenter.isNotEmpty && isLastItem)
          Container(
            width: responsive.screenWidth * 0.9,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
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
                Image.asset(
                  "assets/icons/GreyTruck.png", // Path to your asset image
                  width: 30, // Set the desired width
                  height: 30, // Set the desired height
                  fit: BoxFit.contain, // Adjust as per your requirement
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SUBMISSION',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      submissionCenter,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    ),
  );
}
