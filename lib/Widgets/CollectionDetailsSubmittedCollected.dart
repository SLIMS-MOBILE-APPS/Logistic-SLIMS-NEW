import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:logisticslims/Screens/TabTripDetails/AssignedCollectedSubmittedCancelledTripRouteDetails/AssignedTripRouteCollection/UploadTRF.dart';
import 'package:logisticslims/Widgets/SnackBarMSG.dart';
import '../Controllers/ImageSubmitByRecieverController.dart';
import '../Controllers/SubmitCollectedDataControllers.dart';
import 'ResponsiveBodyFontWidget.dart';
import '../Screens/TabTripDetails/AssignedCollectedSubmittedCancelledTripRouteDetails/AssignedTripRouteCollection/TripSucress.dart';
import 'YesNoPopUPWidget.dart';

class SampleCollectionScreen extends StatefulWidget {
  final bool isSubmittedPage; // True if coming from Submitted Page
  final List<String>? capturedImages;
  final String samples;
  final String containers;
  final String trf;
  final String? receiverID;
  final String remarks;
  final String submittedImage;
  final String routeSHIFTID;
  final String submissionCenterLocationID;
  final String SubmissionCenter;

  const SampleCollectionScreen({
    Key? key,
    required this.isSubmittedPage,
    this.capturedImages,
    required this.samples,
    required this.containers,
    required this.trf,
    this.receiverID,
    required this.remarks,
    required this.submittedImage,
    required this.routeSHIFTID,
    required this.submissionCenterLocationID,
    required this.SubmissionCenter,
  }) : super(key: key);

  @override
  State<SampleCollectionScreen> createState() => _SampleCollectionScreenState();
}

class _SampleCollectionScreenState extends State<SampleCollectionScreen> {
  late List<String> capturedImages;
  late TextEditingController samplesController;
  late TextEditingController containersController;
  late TextEditingController trfController;
  late TextEditingController receiverController;
  late TextEditingController remarksController;
  bool isImageCaptured = false;

  // @override
  // void initState() {
  //   super.initState();
  //   capturedImages = widget.capturedImages ?? [];
  //
  //   // Initialize controllers for Collected Page (Editable), else show static data
  //   samplesController = TextEditingController(
  //       text: widget.isSubmittedPage ? widget.samples : '');
  //   containersController = TextEditingController(
  //       text: widget.isSubmittedPage ? widget.containers : '');
  //   trfController =
  //       TextEditingController(text: widget.isSubmittedPage ? widget.trf : '');
  //   remarksController = TextEditingController(
  //       text: widget.isSubmittedPage ? widget.remarks : '');
  //
  //   if (widget.submittedImage.isNotEmpty && widget.isSubmittedPage) {
  //     capturedImages.insert(0, widget.submittedImage);
  //   }
  // }
  @override
  void initState() {
    super.initState();

    capturedImages =
        widget.capturedImages ?? []; // Keep previously captured images

    // Keep existing values when coming back
    samplesController = TextEditingController(text: widget.samples);
    containersController = TextEditingController(text: widget.containers);
    trfController = TextEditingController(text: widget.trf);
    receiverController = TextEditingController(text: widget.receiverID);
    remarksController = TextEditingController(text: widget.remarks);
  }

  Future<void> submitCollectedData(BuildContext context) async {
    try {
      final response =
          await SubmitCollectedDataAPIController.fetchSubmitCollectedDataAPIs(
        ipSamples: widget.samples,
        ipLocationId: widget.submissionCenterLocationID,
        ipRemarks: remarksController.text,
        ipTripShiftId: widget.routeSHIFTID,
        ipReceivedSamples: samplesController.text,
        ipReceiverName: receiverController.text,
        ipShiftFrom: "",
        ipShiftTo: "",
        context: context,
      );

      if (response.isNotEmpty) {
        // Process image
        String base64Image = "";
        if (capturedImages.isNotEmpty) {
          String firstImagePath = capturedImages.first;
          File firstImageFile = File(firstImagePath);
          Uint8List imageBytes = await firstImageFile.readAsBytes();
          base64Image = base64Encode(imageBytes);
        }

        // Call the image API asynchronously without waiting
        UpdateImageAPIController.updateSubmitImageBytes(
          tripShiftID: widget.routeSHIFTID,
          base64Image: base64Image,
          context: context,
        ).then((response) {
          print("Image API called successfully");
        }).catchError((error) {
          print("Image API error: $error");
        });

        // Close bottom sheet before navigating
        Navigator.pop(context);

        // Navigate to SuccessUploadTRF screen
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(builder: (context) => SuccessUploadTRF()),
        );

        // Show success message
        showSnackBarMessage(
          context,
          "Submission & Image Upload Successful!",
          const Color.fromARGB(255, 0, 167, 133),
        );
      }
      else {
        showSnackBarMessage(
            context, "No Data Found in Response!", Color(0xFFEB3F3F));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(responsive),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                      title: 'Tubes',
                      controller: samplesController,
                      isEditable: !widget.isSubmittedPage),
                  widget.isSubmittedPage
                      ? _buildSection(
                          title: 'Containers',
                          controller: containersController,
                          isEditable: !widget.isSubmittedPage)
                      : Container(),
                  widget.isSubmittedPage
                      ? _buildSection(
                          title: 'TRF',
                          controller: trfController,
                          isEditable: !widget.isSubmittedPage)
                      : Container(),
                  widget.isSubmittedPage
                      ? Container()
                      : _buildSection(
                          title: 'Receiver',
                          controller: receiverController,
                          isEditable: !widget.isSubmittedPage),
                  _buildSection(
                      title: 'Remarks',
                      controller: remarksController,
                      isMultiLine: true,
                      isEditable: !widget.isSubmittedPage),

                  // Show image only in the Submitted Page
                  //if (widget.isSubmittedPage && capturedImages.isNotEmpty)
                  _buildImageSection(responsive),

                  // Capture Image button for Collected Page only
                  if (!widget.isSubmittedPage)
                    _buildCaptureImageButton(responsive),
                ],
              ),
            ),
          ],
        ),
      ),

      // No bottom button for Submitted Page
      bottomNavigationBar:
          widget.isSubmittedPage ? null : _buildBottomButton(responsive),
    );
  }

  Widget _buildHeader(ResponsiveUtils responsive) {
    return Container(
      height: responsive.screenHeight * 0.14,
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
              onTap: () => Navigator.pop(context),
              child: Container(
                width: responsive.screenWidth * 0.08,
                height: responsive.screenWidth * 0.08,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.white, size: 22.0),
              ),
            ),
            SizedBox(width: responsive.screenWidth * 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.isSubmittedPage
                      ? "Submitted Details"
                      : "Submission Form",
                  //: "Collection Details",
                  style: TextStyle(
                      fontSize: responsive.getAppBarFontSize(),
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  widget.SubmissionCenter,
                  style: TextStyle(
                      fontSize: responsive.getTitleFontSize(),
                      color: Colors.white,
                      letterSpacing: 1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required TextEditingController controller,
    bool isMultiLine = false,
    bool isEditable = false,
  }) {
    final responsive = ResponsiveUtils(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: responsive.getTitleFontSize(),
                  fontWeight: FontWeight.w500)),
          SizedBox(height: responsive.screenHeight * 0.01),
          isEditable
              ? TextField(
                  controller: controller,
                  maxLines: isMultiLine ? null : 1,
                  minLines: isMultiLine ? 4 : 1,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey)),
                  ),
                )
              : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(controller.text),
                ),
        ],
      ),
    );
  }

  Widget _buildImageSection(ResponsiveUtils responsive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Photo',
          style: TextStyle(
            fontSize: responsive.getTitleFontSize(),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: responsive.screenHeight * 0.01),

        // Check if there are captured images
        if (capturedImages.isNotEmpty && widget.submittedImage.isEmpty)
          // Wrap for better layout of multiple images
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              // Display Captured Images (File Paths)
              ...capturedImages.map((imagePath) {
                return Container(
                  width: responsive.screenWidth * 0.3,
                  height: responsive.screenWidth * 0.3,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ],
          )
        // Display Submitted Image (Base64) only if there are no captured images
        else if (widget.isSubmittedPage && widget.submittedImage.isNotEmpty)
          Container(
            width: responsive.screenWidth * 0.3,
            height: responsive.screenWidth * 0.3,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                base64Decode(
                    widget.submittedImage), // Decode the single Base64 image
                fit: BoxFit.fill,
              ),
            ),
          )
        // Placeholder when no image is available
        else
          Container(
            width: responsive.screenWidth * 0.3,
            height: responsive.screenWidth * 0.3,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            child: Center(
              child: Icon(Icons.image, color: Colors.grey),
            ),
          ),
      ],
    );
  }

  Widget _buildCaptureImageButton(ResponsiveUtils responsive) {
    return ElevatedButton(
      onPressed: () async {
        final capturedImagePath = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UploadTRFPage(
                  isSubmittedPage: widget.isSubmittedPage,
                  samples: samplesController.text,
                  containers: containersController.text,
                  trf: trfController.text,
                  receiverID: receiverController.text,
                  remarks: remarksController.text,
                  submittedImage: widget.submittedImage,
                  routeShiftId: widget.routeSHIFTID,
                  submissionCenterLocationID: widget.submissionCenterLocationID,
                  submissionCenter: widget.SubmissionCenter)),
        );

        if (capturedImagePath != null) {
          setState(() {
            capturedImages.add(capturedImagePath); // Add image path to the list
            isImageCaptured = true; // Enable the submit button
          });
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0B66C3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        "Capture Image",
        style: TextStyle(
          fontSize: responsive.getTitleFontSize(),
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildBottomButton(ResponsiveUtils responsive) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
      child: SizedBox(
        width: responsive.screenWidth,
        height: 50,
        child: ElevatedButton(
          onPressed: capturedImages.isNotEmpty
              ? () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (context) {
                      return CollectedRouteSubmitBottomSheet(
                        heading: 'Submit Collected Route Data',
                        onYesPressed: () {
                          submitCollectedData(context);
                        },
                        onNoPressed: () {
                          print("No button pressed");
                        },
                      );
                    },
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: capturedImages.isNotEmpty
                ? const Color(0xFF0B66C3)
                : Colors.grey, // Change color based on state
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
    );
  }
}
