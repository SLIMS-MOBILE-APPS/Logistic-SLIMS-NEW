class SubmitCollectedDataModels {
  final int count;

  SubmitCollectedDataModels({required this.count});

  factory SubmitCollectedDataModels.fromJson(Map<String, dynamic> json) {
    return SubmitCollectedDataModels(
      count: json['CNT'] ?? 0, // Default to 0 if null
    );
  }
}
