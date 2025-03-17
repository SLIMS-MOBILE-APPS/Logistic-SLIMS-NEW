class TripTrackingModels {
  final int totalSamples;
  final String? completedDt;
  final String? completedBy;
  final String? reachedDt;
  final String? reachedBy;
  final int startBy;
  final String startDt;
  final int totalSamples1;
  final int areaId;

  TripTrackingModels({
    required this.totalSamples,
    required this.completedDt,
    required this.completedBy,
    required this.reachedDt,
    required this.reachedBy,
    required this.startBy,
    required this.startDt,
    required this.totalSamples1,
    required this.areaId,
  });

  factory TripTrackingModels.fromJson(Map<String, dynamic> json) {
    return TripTrackingModels(
      totalSamples: json["TOTAL_SAMPLES"] ?? 0,
      completedDt: json["COMPLETED_DT"],
      completedBy: json["COMPLETED_BY"]?.toString(), // Convert to String
      reachedDt: json["REACHED_DT"],
      reachedBy: json["REACHED_BY"]?.toString(), // Convert to String
      startBy: json["START_BY"] ?? 0,
      startDt: json["START_DT"] ?? "",
      totalSamples1: json["TOTAL_SAMPLES1"] ?? 0,
      areaId: json["AREA_ID"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "TOTAL_SAMPLES": totalSamples,
      "COMPLETED_DT": completedDt,
      "COMPLETED_BY": completedBy,
      "REACHED_DT": reachedDt,
      "REACHED_BY": reachedBy,
      "START_BY": startBy,
      "START_DT": startDt,
      "TOTAL_SAMPLES1": totalSamples1,
      "AREA_ID": areaId,
    };
  }
}
