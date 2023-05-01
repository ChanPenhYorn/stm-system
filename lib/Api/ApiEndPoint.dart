class ApiEndPoint {
  // static String serverCamera = 'server/camera';
  // static String anprLiveHub = 'anprlive';
  // static String plateCapture = 'plate-capture';
  // static String plateCaptureByQty = 'plate-capture/getlastbyqty';
  static String ppshvTopup = 'ppshv/topup';
  static String ppshvDeduction = 'ppshv/deduction';
  static String vehicleRevenue = 'api/v1/report/vehicle-and-weight';
  static String vehicleRevenueExport =
      'api/v1/report/vehicle-and-weight/export';

  //STM
  static String login = "api/v1/authentication/login";
  static String changePassword = "api/v1/authentication/change_password";

  static String role = "api/v1/role";
  static String activity = "api/v1/activity";
  static String user = "api/v1/user";
  static String priceList = "api/v1/price/list";
  static String priceDelete = "api/v1/price/delete";
  static String priceCreateUpdate = "api/v1/price/createOrUpdate";

  static String register = "api/v1/authentication/register-approval";
  static String getApprovedAccountByUDID = "osr/get-approve-account-by-id";
  static String appVersion = "osr/app-version";

  static String userApproval = "api/v1/user/approval";
  static String userPost = "osr/users";
  static String requestOtp = "osr/request-otp";
  static String submitOtp = "osr/submit-otp";
  static String updateUserProfile = "osr/update-user-profile";

  static String decryptQR = "osr/encrypt-decrypt/decrypt";
  static String getFormApproval = "osr/users/not-approve-by-udid";
}
