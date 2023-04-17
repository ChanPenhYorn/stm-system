class RegisterPostModel {
  String? firstNameKh;
  String? lastNameKh;
  String? firstNameEn;
  String? lastNameEn;
  String? udid;
  String? position;
  String? org;
  String? phoneNumber;
  String? modelName;
  String? modelVersion;
  String? qrType;

  RegisterPostModel(
      {this.firstNameKh,
      this.lastNameKh,
      this.firstNameEn,
      this.lastNameEn,
      this.udid,
      this.position,
      this.org,
      this.phoneNumber,
      this.modelName,
      this.modelVersion,
      this.qrType});

  RegisterPostModel.fromJson(Map<String, dynamic> json) {
    firstNameKh = json['first_name_kh'];
    lastNameKh = json['last_name_kh'];
    firstNameEn = json['first_name_en'];
    lastNameEn = json['last_name_en'];
    udid = json['udid'];
    position = json['position'];
    org = json['org'];
    phoneNumber = json['phone_number'];
    modelName = json['model_name'];
    modelVersion = json['model_version'];
    qrType = json['qr_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name_kh'] = this.firstNameKh;
    data['last_name_kh'] = this.lastNameKh;
    data['first_name_en'] = this.firstNameEn;
    data['last_name_en'] = this.lastNameEn;
    data['udid'] = this.udid;
    data['position'] = this.position;
    data['org'] = this.org;
    data['phone_number'] = this.phoneNumber;
    data['model_name'] = this.modelName;
    data['model_version'] = this.modelVersion;
    data['qr_type'] = this.qrType;
    return data;
  }
}
