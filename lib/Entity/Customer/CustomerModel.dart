class CustomerModel {
  String? fullName;
  String? imagePath;
  String? code;
  String? firstName;
  String? lastName;
  String? description;
  String? address;
  String? phoneNumber;
  String? createdBy;
  String? createdDatetime;
  String? image;

  CustomerModel(
      {this.fullName,
      this.imagePath,
      this.code,
      this.firstName,
      this.lastName,
      this.description,
      this.address,
      this.phoneNumber,
      this.createdBy,
      this.createdDatetime,
      this.image});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    imagePath = json['image_path'];
    code = json['code'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    description = json['description'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    createdBy = json['created_by'];
    createdDatetime = json['created_datetime'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['image_path'] = this.imagePath;
    data['code'] = this.code;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['description'] = this.description;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['created_by'] = this.createdBy;
    data['created_datetime'] = this.createdDatetime;
    data['image'] = this.image;
    return data;
  }
}
