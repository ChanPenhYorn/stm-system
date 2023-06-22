class BargeModel {
  String? imagePath;
  String? code;
  String? name;
  String? description;
  String? address;
  String? phoneNumber;
  String? createdBy;
  String? createdDatetime;
  String? image;

  BargeModel({
    this.imagePath,
    this.code,
    this.name,
    this.description,
    this.address,
    this.phoneNumber,
    this.createdBy,
    this.createdDatetime,
    this.image,
  });

  BargeModel.fromJson(Map<String, dynamic> json) {
    imagePath = json['image_path'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    createdBy = json['created_by'];
    createdDatetime = json['created_datetime'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_path'] = this.imagePath;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['created_by'] = this.createdBy;
    data['created_datetime'] = this.createdDatetime;
    data['image'] = this.image;
    return data;
  }
}
