class ApiEndPoint {
  // static String serverCamera = 'server/camera';
  // static String anprLiveHub = 'anprlive';
  // static String plateCapture = 'plate-capture';
  // static String plateCaptureByQty = 'plate-capture/getlastbyqty';
  static String ppshvTopup = 'ppshv/topup';
  static String ppshvDeduction = 'ppshv/deduction';

  //STM
  static String login = "api/v1/authentication/login";

  static String role = "api/v1/role";
  static String activity = "api/v1/activity";
  // static String rolePost = "api/v1/role";

  static String register = "osr/register";
  static String getApprovedAccountByUDID = "osr/get-approve-account-by-id";
  static String changePassword = "osr/change-password";
  static String appVersion = "osr/app-version";

  static String user = "osr/users/listing";
  static String userApproval = "osr/users/not-approve";
  static String userPost = "osr/users";
  static String requestOtp = "osr/request-otp";
  static String submitOtp = "osr/submit-otp";
  static String updateUserProfile = "osr/update-user-profile";

  static String decryptQR = "osr/encrypt-decrypt/decrypt";
  static String getFormApproval = "osr/users/not-approve-by-udid";
}
