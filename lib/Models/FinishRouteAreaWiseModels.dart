class FinishRouteAreaWiseModels {
  final int count;

  FinishRouteAreaWiseModels({required this.count});

  factory FinishRouteAreaWiseModels.fromJson(Map<String, dynamic> json) {
    return FinishRouteAreaWiseModels(
      count: json['CNT'] ?? 0, // Default to 0 if null
    );
  }
}
