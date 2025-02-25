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
  final String subLocName;
  final String? trfNo;

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
    required this.subLocName,
    this.trfNo,
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
      totalSamples: json['TOTAL_SAMPLES'], // Can be null
      subLocName: json['SUB_LOC_NAME'] ?? '',
      trfNo: json['TRF_NO'], // Can be null
    );
  }
}
