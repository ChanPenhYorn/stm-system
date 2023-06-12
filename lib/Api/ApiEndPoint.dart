class ApiEndPoint {
  // static String serverCamera = 'server/camera';
  // static String anprLiveHub = 'anprlive';
  // static String plateCapture = 'plate-capture';
  // static String plateCaptureByQty = 'plate-capture/getlastbyqty';
  static String ppshvTopup = '/ppshv/topup';
  static String ppshvDeduction = '/ppshv/deduction';
  static String vehicleRevenue = '/api/v1/report/vehicle-and-weight';
  static String vehicleRevenueExport =
      '/api/v1/report/vehicle-and-weight/export';
  static String couponInvoiceExport = '/api/v1/coupon-invoice/list/export';

  static String couponInvoiceList = "/api/v1/coupon-invoice/list";

  //STM
  static String login = "/api/v1/authentication/login";
  static String changePassword = "/api/v1/authentication/change_password";

  static String role = "/api/v1/role";
  static String activity = "/api/v1/activity";
  static String user = "/api/v1/user";
  static String priceList = "/api/v1/price/list";
  static String priceDelete = "/api/v1/price/delete";
  static String priceCreateUpdate = "/api/v1/price/createOrUpdate";
  static String priceDefaultUpdate = "/api/v1/price/defaultUpdate";

  //Company
  static String companyList = "/api/v1/company/list";
  static String companyDelete = "/api/v1/company/delete";
  static String companyCreate = "/api/v1/company/create";
  static String companyUpdate = "/api/v1/company/update";
  //Customer
  static String customerList = "/api/v1/customer/list";
  static String customerDelete = "/api/v1/customer/delete";
  static String customerCreate = "/api/v1/customer/create";
  static String customerUpdate = "/api/v1/customer/update";
  //Product
  static String productList = "/api/v1/product/list";
  static String productDelete = "/api/v1/product/delete";
  static String productCreate = "/api/v1/product/create";
  static String productUpdate = "/api/v1/product/update";
  //Zone
  static String zoneList = "/api/v1/zone/list";
  static String zoneDelete = "/api/v1/zone/delete";
  static String zoneCreate = "/api/v1/zone/create";
  static String zoneUpdate = "/api/v1/zone/update";

  static String register = "/api/v1/authentication/register-approval";
  static String getApprovedAccountByUDID = "/osr/get-approve-account-by-id";
  static String appVersion = "/osr/app-version";

  static String userApproval = "/api/v1/user/approval";
  static String userPost = "/osr/users";
  static String requestOtp = "/osr/request-otp";
  static String submitOtp = "/osr/submit-otp";
  static String updateUserProfile = "/osr/update-user-profile";

  static String decryptQR = "/osr/encrypt-decrypt/decrypt";
  static String getFormApproval = "/osr/users/not-approve-by-udid";
}
