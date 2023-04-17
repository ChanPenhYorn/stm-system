class UDIDModel {
  String? udid;

  UDIDModel({this.udid});

  UDIDModel.fromJson(Map<String, dynamic> json) {
    udid = json['udid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['udid'] = this.udid;
    return data;
  }
}
