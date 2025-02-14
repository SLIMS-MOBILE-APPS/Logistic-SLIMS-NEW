class AuthenticationAPIModels {
  final int userId;
  final String connectionString;
  final String appCode;
  final int appId;
  final String appName;
  final String companyLogo;
  final String reportUrl;
  final String apiUrl;
  final String otpUrl;
  final String? providerLogo;
  final String loginName;
  final String clientName;
  final String clientUserName;
  final String uploadAttachments;
  final String withoutHeadUrl;
  final String withHeadUrl;
  final String client;

  AuthenticationAPIModels({
    required this.userId,
    required this.connectionString,
    required this.appCode,
    required this.appId,
    required this.appName,
    required this.companyLogo,
    required this.reportUrl,
    required this.apiUrl,
    required this.otpUrl,
    this.providerLogo,
    required this.loginName,
    required this.clientName,
    required this.clientUserName,
    required this.uploadAttachments,
    required this.withoutHeadUrl,
    required this.withHeadUrl,
    required this.client,
  });

  factory AuthenticationAPIModels.fromJson(Map<String, dynamic> json) {
    return AuthenticationAPIModels(
      userId: json["USER_ID"] ?? 0,
      connectionString: json["CONNECTION_STRING"] ?? "",
      appCode: json["APP_CD"] ?? "",
      appId: json["APP_ID"] ?? 0,
      appName: json["APP_NAME"] ?? "",
      companyLogo: json["COMPANY_LOGO"] ?? "",
      reportUrl: json["REPORT_URL"] ?? "",
      apiUrl: json["API_URL"] ?? "",
      otpUrl: json["OTP_URL"] ?? "",
      providerLogo: json["PROVIDER_LOGO"],
      loginName: json["LOGIN_NAME"] ?? "",
      clientName: json["CLIENT_NAME"] ?? "",
      clientUserName: json["CLIENT_USER_NAME"] ?? "",
      uploadAttachments: json["UPLOAD_ATTACHMENTS"] ?? "",
      withoutHeadUrl: json["WITHOUTHEAD_URL"] ?? "",
      withHeadUrl: json["WITHHEAD_URL"] ?? "",
      client: json["CLIENT"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "USER_ID": userId,
      "CONNECTION_STRING": connectionString,
      "APP_CD": appCode,
      "APP_ID": appId,
      "APP_NAME": appName,
      "COMPANY_LOGO": companyLogo,
      "REPORT_URL": reportUrl,
      "API_URL": apiUrl,
      "OTP_URL": otpUrl,
      "PROVIDER_LOGO": providerLogo,
      "LOGIN_NAME": loginName,
      "CLIENT_NAME": clientName,
      "CLIENT_USER_NAME": clientUserName,
      "UPLOAD_ATTACHMENTS": uploadAttachments,
      "WITHOUTHEAD_URL": withoutHeadUrl,
      "WITHHEAD_URL": withHeadUrl,
      "CLIENT": client,
    };
  }
}
