class ZoneModel {
  String? code;
  String? name;
  String? description;
  String? createdBy;
  String? createdDatetime;

  ZoneModel(
      {this.code,
      this.name,
      this.description,
      this.createdBy,
      this.createdDatetime});

  ZoneModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    description = json['description'];
    createdBy = json['created_by'];
    createdDatetime = json['created_datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['created_by'] = this.createdBy;
    data['created_datetime'] = this.createdDatetime;
    return data;
  }
}
