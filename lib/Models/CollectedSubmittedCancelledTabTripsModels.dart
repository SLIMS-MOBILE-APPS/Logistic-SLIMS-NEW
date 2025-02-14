class CollectedSubmittedCancelledTabTripModels {
  final int tripShiftId;
  final int userId;
  final String shiftFrom;
  final String shiftFromDt;
  final String shiftTo;
  final String shiftToDt;
  final String tripSchDate;
  final int routeMapId;
  final String routeName;
  final int? locationId;
  final String? locationName;
  final String? tripRejectDt;
  final int? total;
  final String? submittedCenter;
  final int? receivedSamples;
  final String? employee;
  final int? duration;
  final String? startDt;
  final String? completedDt;
  final String? phoneNo;
  final String? areaNames;
  final int? containers; // Added field
  final int? trfNo; // Added field
  final String? receivedBy; // Added field
  final String? submittedRemarks; // Added field
  final String? uploadPrescription; // Added field

  CollectedSubmittedCancelledTabTripModels({
    required this.tripShiftId,
    required this.userId,
    required this.shiftFrom,
    required this.shiftFromDt,
    required this.shiftTo,
    required this.shiftToDt,
    required this.tripSchDate,
    required this.routeMapId,
    required this.routeName,
    this.locationId,
    this.locationName,
    this.tripRejectDt,
    this.total,
    this.submittedCenter,
    this.receivedSamples,
    this.employee,
    this.duration,
    this.startDt,
    this.completedDt,
    this.phoneNo,
    this.areaNames,
    this.containers,
    this.trfNo,
    this.receivedBy,
    this.submittedRemarks,
    this.uploadPrescription,
  });

  factory CollectedSubmittedCancelledTabTripModels.fromJson(
      Map<String, dynamic> json) {
    return CollectedSubmittedCancelledTabTripModels(
      tripShiftId: json['TRIP_SHIFT_ID'] as int,
      userId: json['user_id'] as int,
      shiftFrom: json['SHIFT_FROM'] as String,
      shiftFromDt: json['SHIFT_FROM_DT'] as String,
      shiftTo: json['SHIFT_TO'] as String,
      shiftToDt: json['SHIFT_TO_DT'] as String,
      tripSchDate: json['trip_sch_date'] as String,
      routeMapId: json['ROUTE_MAP_ID'] as int,
      routeName: json['ROUTE_NAME'] as String,
      locationId: json['LOCATION_ID'] as int?,
      locationName: json['LOCATION_NAME'] as String?,
      tripRejectDt: json['TRIP_REJECT_DT'] as String?,
      total: json['TOTAL'] as int?,
      submittedCenter: json['SUBMITTED_CENTER'] as String?,
      receivedSamples: json['RECEIVED_SAMPLES'] as int?,
      employee: json['EMPLOYEE'] as String?,
      duration: json['DURATION'] as int?,
      startDt: json['START_DT'] as String?,
      completedDt: json['COMPLETED_DT'] as String?,
      phoneNo: json['PHONE_NO'] as String?,
      areaNames: json['AREANAMES'] as String?,
      containers: json['CONTAINERS'] as int?,
      trfNo: json['TRF_NO'] as int?,
      receivedBy: json['RECEIVED_BY'] as String?,
      submittedRemarks: json['SUBMITTED_REMARKS'] as String?,
      uploadPrescription: json['UPLOAD_PRESCRIPTION'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'TRIP_SHIFT_ID': tripShiftId,
      'user_id': userId,
      'SHIFT_FROM': shiftFrom,
      'SHIFT_FROM_DT': shiftFromDt,
      'SHIFT_TO': shiftTo,
      'SHIFT_TO_DT': shiftToDt,
      'trip_sch_date': tripSchDate,
      'ROUTE_MAP_ID': routeMapId,
      'ROUTE_NAME': routeName,
      'LOCATION_ID': locationId,
      'LOCATION_NAME': locationName,
      'TRIP_REJECT_DT': tripRejectDt,
      'TOTAL': total,
      'SUBMITTED_CENTER': submittedCenter,
      'RECEIVED_SAMPLES': receivedSamples,
      'EMPLOYEE': employee,
      'DURATION': duration,
      'START_DT': startDt,
      'COMPLETED_DT': completedDt,
      'PHONE_NO': phoneNo,
      'AREANAMES': areaNames,
      'CONTAINERS': containers,
      'TRF_NO': trfNo,
      'RECEIVED_BY': receivedBy,
      'SUBMITTED_REMARKS': submittedRemarks,
      'UPLOAD_PRESCRIPTION': uploadPrescription,
    };

    // Remove null values from the map
    data.removeWhere((key, value) => value == null);

    return data;
  }
}
