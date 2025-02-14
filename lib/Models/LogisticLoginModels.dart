class LogisticLoginModels {
  final int userId;
  final String userName;
  final int referenceId;
  final String empName;

  LogisticLoginModels({
    required this.userId,
    required this.userName,
    required this.referenceId,
    required this.empName,
  });

  // Factory method to create an instance from JSON
  factory LogisticLoginModels.fromJson(Map<String, dynamic> json) {
    return LogisticLoginModels(
      userId: json['USER_ID'] ?? 0,
      userName: json['USER_NAME'] ?? "",
      referenceId: json['REFERENCE_ID'] ?? 0,
      empName: json['EMP_NAME'] ?? "",
    );
  }

  // Convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'USER_ID': userId,
      'USER_NAME': userName,
      'REFERENCE_ID': referenceId,
      'EMP_NAME': empName,
    };
  }
}
