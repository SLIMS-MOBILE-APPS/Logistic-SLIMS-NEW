// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import '../../../Widgets/ResponsiveBodyFontWidget.dart';
// import 'AssignedTripRouteCollection/ContinueAssignTripProcess.dart';
// import 'AssignedTripRouteCollection/TripSucress.dart';
//
// class SampleCollectionScreen extends StatefulWidget {
//   final bool isLastRoute;
//   final bool isSubmitted;
//   final List<String>? capturedImages;
//   final String samples;
//   final String containers;
//   final String trf;
//   final String remarks;
//   final String submittedImage;
//   final String SubmissionCenter;
//
//   const SampleCollectionScreen({
//     Key? key,
//     required this.isLastRoute,
//     required this.isSubmitted,
//     this.capturedImages,
//     required this.samples,
//     required this.containers,
//     required this.trf,
//     required this.remarks,
//     required this.submittedImage,
//     required this.SubmissionCenter,
//   }) : super(key: key);
//
//   @override
//   State<SampleCollectionScreen> createState() => _SampleCollectionScreenState();
// }
//
// class _SampleCollectionScreenState extends State<SampleCollectionScreen> {
//   late List<String> capturedImages;
//
//   @override
//   void initState() {
//     super.initState();
//     capturedImages = widget.capturedImages ?? [];
//
//     // If submittedImage is provided, add it to capturedImages
//     if (widget.submittedImage.isNotEmpty) {
//       capturedImages.insert(0, widget.submittedImage);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final responsive = ResponsiveUtils(context);
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Header Section
//             Container(
//               height: responsive.screenHeight * 0.14, // 14% of screen height
//               decoration: const BoxDecoration(
//                 color: Color(0xFF0B66C3),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(16),
//                   bottomRight: Radius.circular(16),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(16, 60, 16, 0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Back Button
//                     InkWell(
//                       onTap: () => Navigator.pop(context),
//                       child: Container(
//                         width: responsive.screenWidth * 0.08,
//                         height: responsive.screenWidth * 0.08,
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.2),
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(
//                           Icons.arrow_back_ios_new_rounded,
//                           color: Colors.white,
//                           size: 22.0,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: responsive.screenWidth * 0.04),
//                     // Title and Subtitle
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.isLastRoute && !widget.isSubmitted
//                               ? "Submission Form"
//                               : "Collection Details",
//                           style: TextStyle(
//                             fontSize: responsive.getAppBarFontSize(),
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                           ),
//                         ),
//                         Text(
//                           widget.isLastRoute && !widget.isSubmitted
//                               ? ""
//                               : widget.SubmissionCenter,
//                           style: TextStyle(
//                             fontSize: responsive.getTitleFontSize(),
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             // Content Section
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildSection(
//                       title: 'Tubes', value: widget.samples, isEditable: true),
//                   _buildSection(
//                       title: 'Containers',
//                       value: widget.containers,
//                       isEditable: true),
//                   _buildSection(
//                       title: 'TRF', value: widget.trf, isEditable: true),
//                   _buildSection(
//                     title: 'Remarks',
//                     value: widget.remarks,
//                     isMultiLine: true,
//                     height: responsive.screenHeight * 0.2,
//                     isEditable: true,
//                   ),
//                   widget.isSubmitted
//                       ? Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Photo',
//                         style: TextStyle(
//                           fontSize: responsive.getBodyFontSize(),
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(height: responsive.screenHeight * 0.01),
//                       capturedImages.isNotEmpty &&
//                           capturedImages.first.isNotEmpty
//                           ? Container(
//                         width: responsive.screenWidth * 0.3,
//                         height: responsive.screenWidth * 0.3,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Image.memory(
//                             base64Decode(capturedImages
//                                 .first), // Decode only first image
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       )
//                           : Container(
//                         width: responsive.screenWidth * 0.3,
//                         height: responsive.screenWidth * 0.3,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Image.asset(
//                             'assets/icons/sample_photo.png', // Default image
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                       : Container()
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: capturedImages.isNotEmpty &&
//           widget.submittedImage.isEmpty
//           ? InkWell(
//         onTap: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => SuccessUploadTRF()));
//         },
//         child: Container(
//           width: double.infinity,
//           height: 80,
//           padding:
//           const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Color(0x1E192F54),
//                 blurRadius: 16,
//                 offset: Offset(0, -4),
//                 spreadRadius: 0,
//               ),
//             ],
//           ),
//           child: Container(
//             height: 48,
//             padding:
//             const EdgeInsets.symmetric(horizontal: 7, vertical: 12),
//             decoration: ShapeDecoration(
//               color: const Color(0xFF0B66C3),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   "Submit",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: responsive.getTitleFontSize(),
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       )
//           : widget.isLastRoute
//           ? InkWell(
//         onTap: () async {
//           // widget.isLastRoute
//           //     ? Navigator.push(
//           //     context,
//           //     MaterialPageRoute(
//           //         builder: (context) => UploadTRFPage()))
//           //     :
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) =>
//                       ContinueAssignedTripProcess()));
//         },
//         child: Container(
//           width: double.infinity,
//           height: 80,
//           padding: const EdgeInsets.symmetric(
//               horizontal: 20, vertical: 14),
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Color(0x1E192F54),
//                 blurRadius: 16,
//                 offset: Offset(0, -4),
//                 spreadRadius: 0,
//               ),
//             ],
//           ),
//           child: Container(
//             height: 48,
//             padding: const EdgeInsets.symmetric(
//                 horizontal: 7, vertical: 12),
//             decoration: ShapeDecoration(
//               color: const Color(0xFF0B66C3),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   "Next",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: responsive.getTitleFontSize(),
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       )
//           : null,
//     );
//   }
//
//   // Reusable Section Builder
//   Widget _buildSection({
//     required String title,
//     required String value,
//     bool isMultiLine = false,
//     double? height,
//     bool isEditable = false,
//   }) {
//     final responsive = ResponsiveUtils(context);
//     final controller = TextEditingController(text: value);
//
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: responsive.getTitleFontSize(),
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: responsive.screenHeight * 0.01),
//           isEditable
//               ? TextField(
//             controller: controller,
//             maxLines:
//             isMultiLine ? null : 1, // Allow multiple lines if true
//             minLines: isMultiLine ? 5 : 1, // Minimum height for multiline
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.all(16),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: const BorderSide(color: Colors.grey),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: const BorderSide(
//                   color: Color(0xFF0B66C3),
//                   width: 1,
//                 ),
//               ),
//             ),
//             style: TextStyle(
//               fontSize: responsive.getBodyFontSize(),
//             ),
//           )
//               : Container(
//             width: double.infinity,
//             height: height,
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: isMultiLine
//                 ? Text(
//               value,
//               style: TextStyle(
//                 fontSize: responsive.getBodyFontSize(),
//               ),
//               maxLines: 5,
//               overflow: TextOverflow.ellipsis,
//             )
//                 : Text(
//               value,
//               style: TextStyle(
//                 fontSize: responsive.getBodyFontSize(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//
//
// import 'package:flutter/material.dart';
// import 'package:logisticslims/Screens/TabTripDetails/AssignedCollectedSubmittedCancelledTripRouteDetails/CollectedRouteDetails.dart';
//
// import '../Controllers/AcceptRejectTripController.dart';
// import '../Models/AcceptRejectTripModels.dart';
// import '../Screens/TabTripDetails/AssignedCollectedSubmittedCancelledTripRouteDetails/AssignedTripRouteCollection/ContinueAssignTripProcess.dart';
// import '../Screens/TabTripDetails/AssignedCollectedSubmittedCancelledTripRouteDetails/CancelledRouteDetails.dart';
// import '../Screens/TabTripDetails/AssignedCollectedSubmittedCancelledTripRouteDetails/SubmittedRouteDetails.dart';
// import 'ResponsiveBodyFontWidget.dart';
// import 'YesNoPopUPWidget.dart';
//
// class TripDetailsWidget extends StatefulWidget {
//   final String startTime;
//   final String estimatedTime;
//   final String timeTakenDuration;
//   final List<String> locations;
//   final String submissionLocationID;
//   final String submissionCenter;
//   final bool showButtons;
//   final String assetsImage;
//   final String TabFlag;
//   final int routeMapID;
//   final int tripShiftID;
//   final String totalSamples;
//   final String containers;
//   final String TRFS;
//   final String base64Images;
//   final String remarks;
//   final String receiverID;
//   final String? isActiveRoute;
//   final String? routeStepCount;
//
//   const TripDetailsWidget({
//     Key? key,
//     required this.startTime,
//     required this.estimatedTime,
//     required this.timeTakenDuration,
//     required this.locations,
//     required this.submissionLocationID,
//     required this.submissionCenter,
//     this.showButtons = false,
//     required this.assetsImage,
//     required this.TabFlag,
//     required this.routeMapID,
//     required this.tripShiftID,
//     required this.totalSamples,
//     required this.containers,
//     required this.TRFS,
//     required this.base64Images,
//     required this.remarks,
//     required this.receiverID,
//     this.isActiveRoute,
//     this.routeStepCount,
//   }) : super(key: key);
//
//   @override
//   State<TripDetailsWidget> createState() => _TripDetailsWidgetState();
// }
//
// class _TripDetailsWidgetState extends State<TripDetailsWidget> {
//   bool isLoading = false;
//
//   Future<void> handleAcceptReject(String flag) async {
//     setState(() => isLoading = true);
//
//     try {
//       List<AcceptRejectTripModels> response =
//       await AcceptRejectTripAPIController.fetchAcceptRejectTripDataAPIs(
//         ipTripShiftId: widget.tripShiftID.toString(),
//         ipFlag: flag, // Pass "AC" for Accept, "RE" for Reject
//         context: context,
//       );
//
//       setState(() => isLoading = false);
//
//       if (flag == "AC") {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => ContinueAssignedTripProcess()),
//         );
//       } else {
//         Navigator.pop(context); // Stay on the assigned page
//       }
//     } catch (e) {
//       setState(() => isLoading = false);
//       print("Error: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final responsive = ResponsiveUtils(context);
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//       child: InkWell(
//         onTap: () {
//           widget.TabFlag == "R"
//               ? Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => CancelledRouteTripDetails(
//                     routeId: "${widget.routeMapID}",
//                     flag: 'RJ',
//                     routeShiftId: "${widget.tripShiftID}",
//                     startTime: "${widget.startTime}",
//                     estimateTime: "${widget.estimatedTime}",
//                     timeTaken: "${widget.timeTakenDuration}",
//                     submissionCenter: "${widget.submissionCenter}",
//                   )))
//               : widget.TabFlag == "S"
//               ? Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => SubmittedRouteTripDetails(
//                     routeId: "${widget.routeMapID}",
//                     flag: 'SU',
//                     routeShiftId: "${widget.tripShiftID}",
//                     startTime: "${widget.startTime}",
//                     estimateTime: "${widget.estimatedTime}",
//                     timeTaken: "${widget.timeTakenDuration}",
//                     samples: "${widget.totalSamples}",
//                     containers: "${widget.containers}",
//                     TRFS: "${widget.TRFS}",
//                     UploadedImageBase64: "${widget.base64Images}",
//                     receiverID: "${widget.receiverID}",
//                     remarks: "${widget.remarks}",
//                     submissionCenter: "${widget.submissionCenter}",
//                   )))
//               : null;
//         },
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width * 0.9,
//                   padding:const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
//                   // margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                   clipBehavior: Clip.antiAlias,
//                   decoration: ShapeDecoration(
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(side: const BorderSide(width: 1, color: Color(0xFFE6E9EF)),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     shadows: const [
//                       BoxShadow(
//                         color: Color(0x05192F54),
//                         blurRadius: 8,
//                         offset: Offset(0, 4),
//                         spreadRadius: 0,
//                       ),
//                       BoxShadow(
//                         color: Color(0x05192F54),
//                         blurRadius: 15,
//                         offset: Offset(0, 15),
//                         spreadRadius: 0,
//                       ),
//                       BoxShadow(
//                         color: Color(0x02192F54),
//                         blurRadius: 20,
//                         offset: Offset(0, 33),
//                         spreadRadius: 0,
//                       ),
//                       BoxShadow(
//                         color: Color(0x00192F54),
//                         blurRadius: 24,
//                         offset: Offset(0, 59),
//                         spreadRadius: 0,
//                       ),
//                       BoxShadow(
//                         color: Color(0x00192F54),
//                         blurRadius: 26,
//                         offset: Offset(0, 92),
//                         spreadRadius: 0,
//                       )
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Image.asset(
//                                 widget.assetsImage,
//                                 width: 30,
//                                 height: 30,
//                                 fit: BoxFit.contain,
//                               ),
//                               const SizedBox(width: 8),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("START",
//                                     style: TextStyle(
//                                         fontSize: responsive.getBodyFontSize(),
//                                         fontWeight: FontWeight.w600,
//                                         color: Color.fromARGB(255, 157, 155, 157)),
//                                   ),
//                                   Text(
//                                     "${widget.startTime}",
//                                     style: TextStyle(
//                                       fontSize: responsive.getTitleFontSize(),
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                       Column(
//                         children: widget.locations.map((location) {
//                           return Padding(
//                             padding: const EdgeInsets.only(left: 8.0),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 2.0),
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                         width: 6,
//                                         height: 8,
//                                         decoration: BoxDecoration(
//                                           color: widget.TabFlag == "A"
//                                               ? Colors.blue[100]
//                                               : widget.TabFlag == "C"
//                                               ? Color.fromARGB(255, 0, 104, 198)
//                                               : widget.TabFlag == "S"
//                                               ? Color.fromARGB(255, 59, 186, 137)
//                                               : Colors.blue[100],
//                                           shape: BoxShape.circle,
//                                         ),
//                                       ),
//                                       // Vertical line
//                                       if (location != widget.locations.last)
//                                         Container(
//                                             width: 1,
//                                             height: 24,
//                                             color: widget.TabFlag == "A"
//                                                 ? Colors.blue[100]
//                                                 : widget.TabFlag == "C"
//                                                 ? Color.fromARGB(255, 0, 104, 198)
//                                                 : widget.TabFlag == "S"
//                                                 ? Color.fromARGB(255, 59, 186, 137)
//                                                 : Colors.blue[100]),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Expanded(
//                                   child: Text(
//                                     location,
//                                     style: TextStyle(
//                                         fontSize: responsive.getBodyFontSize(),
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                       const SizedBox(height: 16),
//                       // Submission center
//                       Container(
//                         width: responsive.screenWidth * 0.9,
//                         padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
//                         margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
//                         clipBehavior: Clip.antiAlias,
//                         decoration: ShapeDecoration(
//                           color: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             side: const BorderSide(width: 1, color: Color(0xFFE6E9EF)),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           shadows: const [
//                             BoxShadow(
//                               color: Color(0x05192F54),
//                               blurRadius: 8,
//                               offset: Offset(0, 4),
//                               spreadRadius: 0,
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           children: [
//                             (widget.TabFlag == "A" || widget.TabFlag == "C" || widget.TabFlag == "R")
//                                 ? Image.asset("assets/icons/GreyTruck.png",
//                               width: 30,
//                               height: 30,
//                               fit: BoxFit.contain,
//                             )
//                                 : Image.asset(widget.assetsImage,
//                               width: 30,
//                               height: 30,
//                               fit: BoxFit.contain,
//                             ),
//                             const SizedBox(width: 8),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text("SUBMISSION",
//                                   style: TextStyle(
//                                       fontSize: responsive.getBodyFontSize(),
//                                       fontWeight: FontWeight.w600,
//                                       color: Color.fromARGB(255, 157, 155, 157)),
//                                 ),
//                                 Text("${widget.submissionCenter}",
//                                   style: TextStyle(
//                                     fontSize: responsive.getTitleFontSize(),
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       if (widget.showButtons) ...[
//                         const SizedBox(height: 16),
//                         widget.TabFlag == 'C'
//                             ? Center(
//                           child: SizedBox(
//                             width: double.infinity,
//                             height: 40,
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 Navigator.push(context, MaterialPageRoute(builder: (context) =>
//                                     CollectedRouteTripDetails(
//                                       routeId:"${widget.routeMapID}",
//                                       flag: 'C',
//                                       routeShiftId: "${widget.tripShiftID}",
//                                       startTime: "${widget.startTime}",
//                                       estimateTime: "${widget.estimatedTime}",
//                                       timeTaken: "${widget.timeTakenDuration}",
//                                       samples: "${widget.totalSamples}",
//                                       containers: "${widget.containers}",
//                                       TRFS: "${widget.TRFS}",
//                                       UploadedImageBase64: "",
//                                       receiverID: "",
//                                       remarks: "",
//                                       submissionLocationID: "${widget.submissionLocationID}",
//                                       submissionCenter: "${widget.submissionCenter}",
//                                     )));
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF0B66C3),
//                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
//                                 ),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset("assets/icons/doublecheckwhite.png",
//                                     width: 15,
//                                     height: 15,
//                                     fit: BoxFit.contain,
//                                   ),
//                                   const SizedBox(width: 2),
//                                   Text("Submit",
//                                     style: TextStyle(
//                                       fontSize: responsive.getTitleFontSize(),
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )
//                             : int.parse("${widget.routeStepCount}") > 0
//                             ? Center(
//                           child: SizedBox(
//                             width: double.infinity,
//                             height: 40,
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 Navigator.push(context,MaterialPageRoute(
//                                     builder: (context) => ContinueAssignedTripProcess()));
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF0B66C3),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                               ),
//                               child: const Text('Continue',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                             : widget.isActiveRoute == "Y"
//                             ? Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             // Decline Button
//                             SizedBox(
//                               width: responsive.screenWidth * 0.3,
//                               height: 40,
//                               child: OutlinedButton(
//                                 onPressed: () {
//                                   // Handle Decline button click
//                                   showModalBottomSheet(
//                                     context: context,
//                                     isScrollControlled: true,
//                                     shape: const RoundedRectangleBorder(
//                                       borderRadius:
//                                       BorderRadius.vertical(top: Radius.circular(16)),
//                                     ),
//                                     builder: (context) {
//                                       return CollectedRouteSubmitBottomSheet(
//                                         heading: 'Submit Collected Route Data',
//                                         onYesPressed: () async {
//                                           if (isLoading) return; // Prevent multiple presses if already loading
//                                           setState(() => isLoading = true); // Start loading
//
//                                           await handleAcceptReject("RE"); // Call your async function
//
//                                           setState(() => isLoading = false); // Reset loading after function completes
//                                         },
//
//                                         onNoPressed: () {
//                                           print("No button pressed");
//                                         },
//                                       );
//                                     },
//                                   );
//                                 },
//                                 style: OutlinedButton.styleFrom(
//                                   side: const BorderSide(
//                                     color: Color(0xFFB0B0B0),
//                                     width: 1,
//                                   ),
//                                   backgroundColor: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                 ),
//                                 child: const Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(Icons.close_rounded, size: 16),
//                                     SizedBox(width: 2),
//                                     Text('Decline',
//                                       style: TextStyle(
//                                         color: Color(0xFF0B66C3), // Text color (blue)
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: responsive.screenWidth * 0.48,
//                               height: 41,
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   showModalBottomSheet(
//                                     context: context,
//                                     isScrollControlled: true,
//                                     shape: const RoundedRectangleBorder(
//                                       borderRadius:
//                                       BorderRadius.vertical(top: Radius.circular(16)),
//                                     ),
//                                     builder: (context) {
//                                       return CollectedRouteSubmitBottomSheet(
//                                         heading: 'Submit Collected Route Data',
//                                         onYesPressed: () async {
//                                           if (isLoading) return;
//                                           setState(() => isLoading = true);
//
//                                           await handleAcceptReject("AC");
//
//                                           setState(() => isLoading = false);
//                                         },
//
//                                         onNoPressed: () {
//                                           print("No button pressed");
//                                         },
//                                       );
//                                     },
//                                   );
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: const Color(0xFF0B66C3),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                 ),
//                                 child: const Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(Icons.check_sharp, size: 16),
//                                     SizedBox(width: 2),
//                                     Text('Accept',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                             : widget.isActiveRoute == "N"? SizedBox(
//                           width: responsive.screenWidth,
//                           height: 40,
//                           child: OutlinedButton(
//                             onPressed: () {
//                               // Handle Decline button click
//                             },
//                             style: OutlinedButton.styleFrom(
//                               side: const BorderSide(
//                                 color: Color(0xFFB0B0B0),
//                                 width: 1,
//                               ),
//                               backgroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             child: const Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.close_rounded, size: 16),
//                                 SizedBox(width: 2),
//                                 Text('Expired',
//                                   style: TextStyle(
//                                     color: Color(0xFF0B66C3), // Text color (blue)
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ):Container(),
//                       ]
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   top: 2,
//                   right: 15,
//                   child: Container(
//                     width: responsive.screenWidth * 0.3,
//                     height: responsive.screenHeight * 0.024,
//                     padding:
//                     const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
//                     decoration: ShapeDecoration(
//                       color: widget.TabFlag == "A"
//                           ? Color.fromARGB(255, 227, 241, 253)
//                           : widget.TabFlag == "S" || widget.TabFlag == "C"
//                           ? Color.fromARGB(255, 228, 242, 237)
//                           : Color.fromARGB(255, 255, 229, 228),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(4),
//                           bottomRight: Radius.circular(4),
//                         ),
//                       ),
//                     ),
//                     child: Text(
//                       widget.TabFlag == "A"
//                           ? "Est: ${widget.estimatedTime}"
//                           : widget.TabFlag == "S" || widget.TabFlag == "C"
//                           ? "Time taken: ${widget.timeTakenDuration}"
//                           : "Cancelled",
//                       style: TextStyle(
//                         color: widget.TabFlag == "A"
//                             ? Color(0xFF073D75)
//                             : widget.TabFlag == "S" || widget.TabFlag == "C"
//                             ? Color.fromARGB(255, 3, 117, 81)
//                             : Color.fromARGB(255, 218, 71, 72),
//                         fontSize: responsive.getNormalRangeFontSize(),
//                         fontWeight: FontWeight.w500,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
