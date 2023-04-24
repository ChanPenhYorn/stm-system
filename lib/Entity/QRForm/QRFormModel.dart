import 'package:stm_report_app/Entity/User/UserModel.dart';

class QRFormModel {
  String? userId;
  String? modelName;
  String? modelVersion;
  String? udid;
  String? qrType;
  UserModel? userModel;

  QRFormModel(
      {this.userId,
      this.modelName,
      this.modelVersion,
      this.udid,
      this.qrType,
      this.userModel});

  QRFormModel.fromJson(Map<String, dynamic> jsonData) {
    userId = jsonData['user_id'].toString();
    modelName = jsonData['model_name'];
    modelVersion = jsonData['model_version'];
    udid = jsonData['udid'];
    qrType = jsonData['qr_type'];
    var jsonUserModel = jsonData['user'];
    userModel =
        jsonUserModel != null ? new UserModel.fromJson((jsonUserModel)) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['model_name'] = this.modelName;
    data['model_version'] = this.modelVersion;
    data['udid'] = this.udid;
    data['qr_type'] = this.qrType;
    if (this.userModel != null) {
      data['user'] = this.userModel!.toJson();
    }
    return data;
  }
}
