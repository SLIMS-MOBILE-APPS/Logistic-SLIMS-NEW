class AcceptRejectTripModels {
  final int count;

  AcceptRejectTripModels({required this.count});

  factory AcceptRejectTripModels.fromJson(Map<String, dynamic> json) {
    return AcceptRejectTripModels(
      count: json['CNT'] ?? 0, // Default to 0 if null
    );
  }
}
