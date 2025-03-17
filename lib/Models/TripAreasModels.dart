class TripAreasModels {
  final int count;
  final int areaId;
  final String areaName;
  final int duration;
  final int sequence;
  final double longitude;
  final double latitude;
  final String routeMapAreaName;
  final int? totalSamples;
  final int? containers;
  final String subLocName;
  final int? trfNo;
  final String? startDt;
  final String? completedDt;
  final String? reachedDt;

  TripAreasModels({
    required this.count,
    required this.areaId,
    required this.areaName,
    required this.duration,
    required this.sequence,
    required this.longitude,
    required this.latitude,
    required this.routeMapAreaName,
    this.totalSamples,
    this.containers, // Added missing field
    required this.subLocName,
    this.trfNo,
    this.startDt,
    this.completedDt,
    this.reachedDt,
  });

  factory TripAreasModels.fromJson(Map<String, dynamic> json) {
    return TripAreasModels(
      count: json['cnt'] ?? 0,
      areaId: json['AREA_ID'] ?? 0,
      areaName: json['AREA_NAME'] ?? '',
      duration: json['DURATION'] ?? 0,
      sequence: json['SEQUENCE'] ?? 0,
      longitude: (json['LONGITUDE'] ?? 0).toDouble(),
      latitude: (json['LATITUDE'] ?? 0).toDouble(),
      routeMapAreaName: json['ROUTE_MAP_AREA_NAME'] ?? '',
      totalSamples: json['TOTAL_SAMPLES'], // Nullable int
      containers: json['CONTAINERS'], // Added missing field
      subLocName: json['SUB_LOC_NAME'] ?? '',
      trfNo: json['TRF_NO'], // Nullable int
      startDt: json['START_DT'], // Nullable string
      completedDt: json['COMPLETED_DT'], // Nullable string
      reachedDt: json['REACHED_DT'], // Nullable string
    );
  }
}
