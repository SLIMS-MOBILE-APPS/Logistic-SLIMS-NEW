import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logisticslims/Screens/TabTripDetails/AssignedCollectedSubmittedCancelledTripRouteDetails/AssignedTripRouteCollection/ContinueAssignTripProcess.dart';
import 'package:logisticslims/Screens/TabTripDetails/AssignedCollectedSubmittedCancelledTripRouteDetails/AssignedTripRouteCollection/RechedLocationTrip.dart';

import '../../../../Controllers/TripTrackingControllers.dart';
import '../../../../Models/TripTrackingModels.dart';
import '../../../../Widgets/ResponsiveBodyFontWidget.dart';
import '../../../../Widgets/SnackBarMSG.dart';
import '../../../../Widgets/YesNoPopUPWidget.dart';

class SampleCollectionAreaWiseSubmitScreen extends StatefulWidget {
  final String routeSHIFTID;
  final String submissionCenter;
  final String areaId;
  final String routeMapId;
  final String duration;

  const SampleCollectionAreaWiseSubmitScreen({
    super.key,
    required this.routeSHIFTID,
    required this.submissionCenter,
    required this.areaId,
    required this.routeMapId,
    required this.duration,
  });

  @override
  State<SampleCollectionAreaWiseSubmitScreen> createState() =>
      _SampleCollectionAreaWiseSubmitScreenState();
}

class _SampleCollectionAreaWiseSubmitScreenState
    extends State<SampleCollectionAreaWiseSubmitScreen> {
  late TextEditingController samplesController;
  late TextEditingController containersController;
  late TextEditingController trfController;
  late TextEditingController remarksController;
  bool _isButtonEnabled = false; // Track button state
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    samplesController = TextEditingController();
    containersController = TextEditingController();
    trfController = TextEditingController();
    remarksController = TextEditingController();

    // Add listeners to controllers
    samplesController.addListener(_validateFields);
    containersController.addListener(_validateFields);
    trfController.addListener(_validateFields);
    remarksController.addListener(_validateFields);
  }

  @override
  void dispose() {
    // Dispose controllers
    samplesController.dispose();
    containersController.dispose();
    trfController.dispose();
    remarksController.dispose();
    super.dispose();
  }

  // Validate if all fields are filled
  void _validateFields() {
    setState(() {
      _isButtonEnabled = samplesController.text.isNotEmpty &&
          containersController.text.isNotEmpty &&
          trfController.text.isNotEmpty &&
          remarksController.text.isNotEmpty;
    });
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      // Handle case where user permanently denied permission
      return;
    }
  }

  void _submitAreaWiseCollectedData() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _checkLocationPermission();

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      String latitude = position.latitude.toString();
      String longitude = position.longitude.toString();

      final response = await TripTrackingAPIController.fetchTripTrackingData(
        ipTripShiftId: widget.routeSHIFTID,
        ipRouteMapId: widget.routeMapId,
        areaId: widget.areaId,
        flag: 'C',
        totalSamples: samplesController.text,
        totalContainers: containersController.text,
        trfNo: trfController.text,
        remarks: remarksController.text,
        latitude: latitude,
        longitude: longitude,
        context: context,
      );

      if (response.isNotEmpty) {
        showSnackBarMessage(
            context, "Collection data submitted!", const Color(0xFF027450));

        TripTrackingAPIController.fetchTripTrackingData(
          ipTripShiftId: widget.routeSHIFTID,
          ipRouteMapId: widget.routeMapId,
          areaId: widget.areaId,
          flag: 'S',
          totalSamples: '',
          totalContainers: '',
          trfNo: '',
          remarks: '',
          latitude: '',
          longitude: '',
          context: context,
        );

        // Navigate immediately after success
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ContinueAssignedTripProcess(
              routeMapID: widget.routeMapId,
              tripShiftID: widget.routeSHIFTID,
            ),
          ),
        );
      } else {
        showSnackBarMessage(
            context, "Collection submission failed!", const Color(0xFFEB3F3F));
      }
    } catch (e) {
      showSnackBarMessage(
          context, "Error: ${e.toString()}", const Color(0xFFEB3F3F));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss keyboard on outside tap
      },
      child: Stack(children: [
        Scaffold(
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
                          isEditable: true),
                      _buildSection(
                          title: 'Containers',
                          controller: containersController,
                          isEditable: true),
                      _buildSection(
                          title: 'TRF',
                          controller: trfController,
                          isEditable: true),
                      _buildSection(
                          title: 'Remarks',
                          controller: remarksController,
                          isMultiLine: true,
                          isEditable: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomButton(responsive),
        ),
        if (_isLoading)
          const Positioned.fill(
            child: Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 11, 102, 195),
              ),
            ),
          ),
      ]),
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
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReachedLocationTripDetails(
                            tripShiftId: widget.routeSHIFTID,
                            routeMapId: widget.routeMapId,
                            areaId: widget.areaId,
                            areaName: widget.submissionCenter,
                            duration: widget.duration)));
              },
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
                  "Submission Form",
                  style: TextStyle(
                      fontSize: responsive.getAppBarFontSize(),
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  widget.submissionCenter,
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

    // Determine if this field should be numeric-only
    bool isNumericField = title != 'Remarks';

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
                  keyboardType: isNumericField
                      ? TextInputType.number
                      : TextInputType.text,
                  inputFormatters: isNumericField
                      ? [FilteringTextInputFormatter.digitsOnly]
                      : null,
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

  Widget _buildBottomButton(ResponsiveUtils responsive) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
      child: SizedBox(
        width: responsive.screenWidth,
        height: 50,
        child: ElevatedButton(
          onPressed: _isButtonEnabled && !_isLoading
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
                        heading: 'Submit Collected Area Wise Data',
                        onYesPressed: () {
                          _submitAreaWiseCollectedData();
                        },
                        onNoPressed: () {
                          print("No button pressed");
                        },
                      );
                    },
                  );
                }
              : null, // Button disabled when fields are empty
          style: ElevatedButton.styleFrom(
            backgroundColor: (_isButtonEnabled && !_isLoading)
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
