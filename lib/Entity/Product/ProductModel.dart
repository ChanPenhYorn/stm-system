class ProductModel {
  String? imagePath;
  String? image;
  String? code;
  String? nameEn;
  String? nameKh;
  String? description;
  String? createdBy;
  String? createdDatetime;

  ProductModel(
      {this.imagePath,
      this.image,
      this.code,
      this.nameEn,
      this.nameKh,
      this.description,
      this.createdBy,
      this.createdDatetime});

  ProductModel.fromJson(Map<String, dynamic> json) {
    imagePath = json['image_path'];
    image = json['image'];
    code = json['code'];
    nameEn = json['name_en'];
    nameKh = json['name_kh'];
    description = json['description'];
    createdBy = json['created_by'];
    createdDatetime = json['created_datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_path'] = this.imagePath;
    data['image'] = this.image;
    data['code'] = this.code;
    data['name_en'] = this.nameEn;
    data['name_kh'] = this.nameKh;
    data['description'] = this.description;
    data['created_by'] = this.createdBy;
    data['created_datetime'] = this.createdDatetime;
    return data;
  }
}
