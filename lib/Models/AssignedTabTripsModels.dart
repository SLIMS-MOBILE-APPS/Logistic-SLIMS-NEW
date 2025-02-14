class AssignedTabTripModels {
  final int tripShiftId;
  final int userId;
  final String shiftFrom;
  final String shiftFromDate;
  final String shiftToDate;
  final String shiftTo;
  final String tripScheduleDate;
  final int routeMapId;
  final String routeName;
  final String? tripRejectDate;
  final int stepCount;
  final String isActive;
  final String areaNames;

  AssignedTabTripModels({
    required this.tripShiftId,
    required this.userId,
    required this.shiftFrom,
    required this.shiftFromDate,
    required this.shiftToDate,
    required this.shiftTo,
    required this.tripScheduleDate,
    required this.routeMapId,
    required this.routeName,
    this.tripRejectDate,
    required this.stepCount,
    required this.isActive,
    required this.areaNames,
  });

  // Factory constructor to create an instance from a JSON object
  factory AssignedTabTripModels.fromJson(Map<String, dynamic> json) {
    return AssignedTabTripModels(
      tripShiftId: json['TRIP_SHIFT_ID'] as int,
      userId: json['user_id'] as int,
      shiftFrom: json['SHIFT_FROM'] as String,
      shiftFromDate: json['SHIFT_FROM_DT'] as String,
      shiftToDate: json['SHIFT_TO_DT'] as String,
      shiftTo: json['SHIFT_TO'] as String,
      tripScheduleDate: json['trip_sch_date'] as String,
      routeMapId: json['ROUTE_MAP_ID'] as int,
      routeName: json['ROUTE_NAME'] as String,
      tripRejectDate: json['TRIP_REJECT_DT'] as String?,
      stepCount: json['STEP_CNT'] as int,
      isActive: json['IS_ACTIVE'] as String,
      areaNames: json['AREANAMES'] as String,
    );
  }

  // Method to convert an instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'TRIP_SHIFT_ID': tripShiftId,
      'user_id': userId,
      'SHIFT_FROM': shiftFrom,
      'SHIFT_FROM_DT': shiftFromDate,
      'SHIFT_TO_DT': shiftToDate,
      'SHIFT_TO': shiftTo,
      'trip_sch_date': tripScheduleDate,
      'ROUTE_MAP_ID': routeMapId,
      'ROUTE_NAME': routeName,
      'TRIP_REJECT_DT': tripRejectDate,
      'STEP_CNT': stepCount,
      'IS_ACTIVE': isActive,
      'AREANAMES': areaNames,
    };
  }
}
