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
