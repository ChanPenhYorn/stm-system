class CompanyModel {
  String? logoPath;
  String? code;
  String? name;
  String? address;
  String? phoneNumber;
  String? description;
  String? createdBy;
  String? createdDatetime;
  String? logo;

  CompanyModel(
      {this.logoPath,
      this.code,
      this.name,
      this.address,
      this.phoneNumber,
      this.description,
      this.createdBy,
      this.createdDatetime,
      this.logo});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    logoPath = json['logo_path'];
    code = json['code'];
    name = json['name'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    description = json['description'];
    createdBy = json['created_by'];
    createdDatetime = json['created_datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo_path'] = this.logoPath;
    data['code'] = this.code;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['description'] = this.description;
    data['created_by'] = this.createdBy;
    data['created_datetime'] = this.createdDatetime;
    data['logo'] = this.logo;
    return data;
  }
}
