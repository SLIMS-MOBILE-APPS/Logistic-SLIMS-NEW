import 'package:flutter/material.dart';
import '../../../../Widgets/ResponsiveBodyFontWidget.dart';
import '../../../../Widgets/CollectionDetailsSubmittedCollected.dart';

class ReachedLocationTripDetails extends StatefulWidget {
  const ReachedLocationTripDetails({super.key});

  @override
  State<ReachedLocationTripDetails> createState() =>
      _ReachedLocationTripDetailsState();
}

class _ReachedLocationTripDetailsState
    extends State<ReachedLocationTripDetails> {
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
                      // Back Button
                      InkWell(
                        onTap: () => Navigator.pop(context),
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
                            "Pragati Nagar",
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

              // Content Section
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/icons/location.png", // Update with your image path
                        height: responsive.screenHeight *
                            0.7, // 30% of screen height
                        width: double.infinity, // Full width
                        fit: BoxFit.fill, // Adjust the image scaling
                      ),
                      const SizedBox(height: 16), // Optional spacing
                      // Additional content can go here
                    ],
                  ),
                ),
              ),
            ],
          ),
// Bottom Container
          // Bottom Positioned Container with Flag
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Main Container
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
                      const SizedBox(height: 16), // Space for the flag
                      // Pragathi Nagar and Time Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Pragathi Nagar Text
                          Expanded(
                            child: Text(
                              "Pragathi Nagar",
                              style: TextStyle(
                                fontSize: responsive.getTitleFontSize(),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          // Time Container
                          Container(
                            width: responsive.screenWidth * 0.09,
                            height: responsive.screenHeight * 0.04,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
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
                              "25 min",
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
                      Text(
                        "24, Venkatappa Rd, Tasker Town, Vasanth Nagar, Hyderabad, Telangana",
                        style: TextStyle(
                          fontSize: responsive.getBodyFontSize(),
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Reached Button
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            width: responsive.screenWidth,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: () {
                                // Add action here
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         SampleCollectionScreen(
                                //       isLastRoute: true,
                                //       isSubmitted: false,
                                //           submittedImage: '',
                                //       samples: '',
                                //       containers: '',
                                //       trf: '',
                                //       remarks: '', SubmissionCenter: '',
                                //     ),
                                //   ),
                                // );
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
        ],
      ),
    );
  }
}
