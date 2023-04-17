import 'package:stm_report_app/Entity/Role/ActivityModel.dart';
import 'package:stm_report_app/Entity/User/UserModel.dart';

class RoleModel {
  String? methodType;
  String? roleId;
  String? roleName;
  String? createdDate;
  String? updatedDate;
  String? dbCode;
  String? type;
  List<UserModel>? user;
  List<ActivityModel>? activity;

  RoleModel({
    this.methodType,
    this.roleId,
    this.roleName,
    this.createdDate,
    this.updatedDate,
    this.dbCode,
    this.type,
    this.user,
    this.activity,
  });

  RoleModel.fromJson(Map<String, dynamic> json) {
    try {
      methodType = json['method_type'];
      roleId = json['role_id'];
      roleName = json['role_name'];
      createdDate = json['created_date'];
      updatedDate = json['updated_date'];
      dbCode = json['db_code'];
      type = json['type'];
      if (json['user'] != null) {
        user = <UserModel>[];
        json['user'].forEach((v) {
          user!.add(new UserModel.fromJson(v));
        });
      }
      if (json['activity'] != null) {
        activity = <ActivityModel>[];
        json['activity'].forEach((v) {
          activity!.add(new ActivityModel.fromJson(v));
        });
      }
    } catch (err) {
      print(err);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method_type'] = this.methodType;
    data['role_id'] = this.roleId;
    data['role_name'] = this.roleName;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    data['db_code'] = this.dbCode;
    data['type'] = this.type;
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }
    if (this.activity != null) {
      data['activity'] = this.activity!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
