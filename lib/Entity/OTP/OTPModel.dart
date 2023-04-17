class OTPModel {
  String? id;
  String? userId;
  String? otpCode;
  String? expiredIn;
  String? expiredTime;
  String? createdTime;

  OTPModel(
      {this.id,
      this.userId,
      this.otpCode,
      this.expiredIn,
      this.expiredTime,
      this.createdTime});

  OTPModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    userId = json['user_id'].toString();
    otpCode = json['otp_code'].toString();
    expiredIn = json['expired_in'].toString();
    expiredTime = json['expired_time'];
    createdTime = json['created_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['otp_code'] = this.otpCode;
    data['expired_in'] = this.expiredIn;
    data['expired_time'] = this.expiredTime;
    data['created_time'] = this.createdTime;
    return data;
  }
}
