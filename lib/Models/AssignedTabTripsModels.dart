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

  // Factory constructor to handle both response formats
  factory AssignedTabTripModels.fromJson(Map<String, dynamic> json) {
    return AssignedTabTripModels(
      tripShiftId: json.containsKey('TRIP_SHIFT_ID') ? json['TRIP_SHIFT_ID'] as int : 0,
      userId: json.containsKey('user_id') ? json['user_id'] as int : 0,
      shiftFrom: json.containsKey('SHIFT_FROM') ? json['SHIFT_FROM'] as String : "",
      shiftFromDate: json.containsKey('SHIFT_FROM_DT') ? json['SHIFT_FROM_DT'] as String : "",
      shiftToDate: json.containsKey('SHIFT_TO_DT') ? json['SHIFT_TO_DT'] as String : "",
      shiftTo: json.containsKey('SHIFT_TO') ? json['SHIFT_TO'] as String : "",
      tripScheduleDate: json.containsKey('trip_sch_date') ? json['trip_sch_date'] as String : "",
      routeMapId: json.containsKey('ROUTE_MAP_ID') ? json['ROUTE_MAP_ID'] as int : 0,
      routeName: json.containsKey('ROUTE_NAME') ? json['ROUTE_NAME'] as String : "",
      tripRejectDate: json.containsKey('TRIP_REJECT_DT') ? json['TRIP_REJECT_DT'] as String? : null,
      stepCount: json.containsKey('STEP_CNT') ? json['STEP_CNT'] as int : 0,
      isActive: json.containsKey('IS_ACTIVE') ? json['IS_ACTIVE'] as String : "",
      areaNames: json.containsKey('AREANAMES') ? json['AREANAMES'] as String : "",
    );
  }

  // Convert an instance to a JSON object
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
