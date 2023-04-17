class OTPPostModel {
  String? udid;
  String? phoneNumber;
  String? otpCode;

  OTPPostModel({this.udid, this.phoneNumber, this.otpCode});

  OTPPostModel.fromJson(Map<String, dynamic> json) {
    udid = json['udid'];
    phoneNumber = json['phone_number'];
    otpCode = json['otp_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['udid'] = this.udid;
    data['phone_number'] = this.phoneNumber;
    data['otp_code'] = this.otpCode;
    return data;
  }
}
