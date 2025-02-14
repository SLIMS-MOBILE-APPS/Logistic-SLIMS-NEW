class RouteDetailsCollectedSubmittedCancelledModels {
  final int areaId;
  final String areaName;
  final int? cnt;
  final int? areaWiseSamples;
  final String? startDt;
  final String? acceptDt;
  final String? reachedDt;
  final String? rejectDt;
  final String? completedDt;
  final double? longitude;
  final double? latitude;
  final int? tripShiftId;
  final String? remarks;
  final String? trfNo;
  final int? totalSamples;
  final int? areaWiseSamples1;
  final int? containers;
  final int? duration;
  final int? sequence;
  final String? routeMapAreaName;

  RouteDetailsCollectedSubmittedCancelledModels({
    required this.areaId,
    required this.areaName,
    this.cnt,
    this.areaWiseSamples,
    this.startDt,
    this.acceptDt,
    this.reachedDt,
    this.rejectDt,
    this.completedDt,
    this.longitude,
    this.latitude,
    this.tripShiftId,
    this.remarks,
    this.trfNo,
    this.totalSamples,
    this.areaWiseSamples1,
    this.containers,
    this.duration,
    this.sequence,
    this.routeMapAreaName,
  });

  factory RouteDetailsCollectedSubmittedCancelledModels.fromJson(Map<String, dynamic> json) {
    return RouteDetailsCollectedSubmittedCancelledModels(
      areaId: json['AREA_ID'] as int? ?? 0,
      areaName: json['AREA_NAME'] as String? ?? '',
      cnt: json['cnt'] as int?,
      areaWiseSamples: json['AREA_WISE_SAMPLES'] as int?,
      startDt: json['START_DT'] as String?,
      acceptDt: json['ACCEPT_DT'] as String?,
      reachedDt: json['REACHED_DT'] as String?,
      rejectDt: json['REJECT_DT'] as String?,
      completedDt: json['COMPLETED_DT'] as String?,
      longitude: json['LONGITUDE'] != null ? json['LONGITUDE'].toDouble() : null,
      latitude: json['LATITUDE'] != null
          ? json['LATITUDE'].toDouble()
          : json['LATTITUDE'] != null
          ? json['LATTITUDE'].toDouble()
          : null, // Handle both keys
      tripShiftId: json['TRIP_SHIFT_ID'] as int?,
      remarks: json['REMARKS'] as String?,
      trfNo: json['TRF_NO'] as String?,
      totalSamples: json['TOTAL_SAMPLES'] as int?,
      areaWiseSamples1: json['AREA_WISE_SAMPLES1'] as int?,
      containers: json['CONTAINERS'] as int?,
      duration: json['DURATION'] as int?,
      sequence: json['SEQUENCE'] as int?,
      routeMapAreaName: json['ROUTE_MAP_AREA_NAME'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AREA_ID': areaId,
      'AREA_NAME': areaName,
      'cnt': cnt,
      'AREA_WISE_SAMPLES': areaWiseSamples,
      'START_DT': startDt,
      'ACCEPT_DT': acceptDt,
      'REACHED_DT': reachedDt,
      'REJECT_DT': rejectDt,
      'COMPLETED_DT': completedDt,
      'LONGITUDE': longitude,
      'LATITUDE': latitude,
      'TRIP_SHIFT_ID': tripShiftId,
      'REMARKS': remarks,
      'TRF_NO': trfNo,
      'TOTAL_SAMPLES': totalSamples,
      'AREA_WISE_SAMPLES1': areaWiseSamples1,
      'CONTAINERS': containers,
      'DURATION': duration,
      'SEQUENCE': sequence,
      'ROUTE_MAP_AREA_NAME': routeMapAreaName,
    };
  }
}
