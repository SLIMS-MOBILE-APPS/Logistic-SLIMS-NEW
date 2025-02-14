import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../../Widgets/AppBarWidget.dart';
import '../../../../Widgets/ResponsiveBodyFontWidget.dart';
import '../../../../Widgets/CollectionDetailsSubmittedCollected.dart';

class UploadTRFPage extends StatefulWidget {
  final bool isSubmittedPage;
  final List<String>? capturedImages;
  final String samples;
  final String containers;
  final String trf;
  final String receiverID;
  final String remarks;
  final String submittedImage;
  final String routeShiftId;
  final String submissionCenterLocationID;
  final String submissionCenter;

  const UploadTRFPage({
    Key? key,
    required this.isSubmittedPage,
    this.capturedImages,
    required this.samples,
    required this.containers,
    required this.trf,
    required this.receiverID,
    required this.remarks,
    required this.submittedImage,
    required this.routeShiftId,
    required this.submissionCenterLocationID,
    required this.submissionCenter,
  }) : super(key: key);

  @override
  State<UploadTRFPage> createState() => _UploadTRFPageState();
}

class _UploadTRFPageState extends State<UploadTRFPage> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  XFile? _imageFile;
  final List<XFile> _capturedImages = [];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(
      cameras.first,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _cameraController.initialize();
    setState(() {}); // Refresh UI when initialization is complete
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Simulating responsive object for dynamic sizing
    final responsive = ResponsiveUtils(context);

    return Scaffold(
      body: Column(
        children: [
          // Custom Header
          HeaderBar(
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
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    "Upload TRF",
                    style: TextStyle(
                      fontSize: responsive.getAppBarFontSize(),
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Rest of the Page
          Expanded(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: [
                      // Camera Preview Section
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CameraPreview(_cameraController),
                        ),
                      ),
                      // Bottom Container Section
                      _buildBottomContainer(),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            spreadRadius: 2, // How much the shadow spreads
            blurRadius: 6, // The softness of the shadow
            offset: const Offset(0, -2), // Shadow position (negative y for top)
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Show Capture Button if no image is captured
          if (_imageFile == null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.camera_alt, size: 40),
                  color: Colors.black,
                  onPressed: () async {
                    try {
                      final image = await _cameraController.takePicture();
                      setState(() {
                        _imageFile = image;
                        _capturedImages.add(image);
                      });
                    } catch (e) {
                      print('Error capturing image: $e');
                    }
                  },
                ),
              ],
            ),
          ] else ...[
            // Upload and Retake buttons
            // Divider at the top of the container
            Container(
              width: 50,
              height: 4.98,
              decoration: ShapeDecoration(
                color: const Color(0xFFCCCCCC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.88),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Upload Button
            _buildUploadButton(),
            const SizedBox(height: 8),
            // Retake Button
            _buildRetakeButton(),
          ],
        ],
      ),
    );
  }

  Widget _buildUploadButton() {
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 14),
      decoration: ShapeDecoration(
        color: const Color(0xFF0B66C3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: InkWell(
        onTap: () {
          // Upload logic
          if (_capturedImages.isNotEmpty) {
            // Convert List<XFile> to List<String> (paths)
            List<String> imagePaths =
                _capturedImages.map((file) => file.path).toList();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SampleCollectionScreen(
                  //isLastRoute: false,
                  isSubmittedPage: widget.isSubmittedPage,
                  capturedImages: imagePaths,
                  submittedImage: '',
                  //isSubmitted: false,
                  samples: widget.samples,
                  containers: widget.containers,
                  trf: widget.trf,
                  receiverID:widget.receiverID,
                  remarks: widget.remarks,
                  routeSHIFTID: widget.routeShiftId,
                  submissionCenterLocationID: widget.submissionCenterLocationID,
                  SubmissionCenter: widget.submissionCenter,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No images to upload')),
            );
          }
        },
        child: const Center(
          child: Text(
            'Upload',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRetakeButton() {
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 14),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFF9A9A9A)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _imageFile = null;
          });
        },
        child: const Center(
          child: Text(
            'Retake',
            style: TextStyle(
              color: Color(0xFF0B66C3),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
