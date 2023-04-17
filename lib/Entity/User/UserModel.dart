import 'package:stm_report_app/Entity/Role/RoleModel.dart';

class UserModel {
  String? methodType;
  String? roleId;
  int? id;
  String? username;
  String? password;
  int? approved;
  int? approvedBy;
  String? firstNameKh;
  String? lastNameKh;
  String? phoneNumber;
  String? map;
  String? createdTime;
  String? dbCode;
  String? createdBy;
  String? image;
  int? status;
  String? type;
  String? typeId;
  String? firstNameEn;
  String? lastNameEn;
  String? udid;
  String? position;
  String? org;
  String? approvedTime;
  String? pdfUrl;
  List<RoleModel>? role;
  String? formAttachment;

  UserModel(
      {this.methodType,
      this.roleId,
      this.id,
      this.username,
      this.password,
      this.approved,
      this.approvedBy,
      this.firstNameKh,
      this.lastNameKh,
      this.phoneNumber,
      this.map,
      this.createdTime,
      this.dbCode,
      this.createdBy,
      this.image,
      this.status,
      this.type,
      this.typeId,
      this.firstNameEn,
      this.lastNameEn,
      this.udid,
      this.position,
      this.org,
      this.approvedTime,
      this.role,
      this.formAttachment,
      this.pdfUrl});

  String get fullNameKh {
    print(lastNameKh);
    lastNameKh = lastNameKh == null ? "" : lastNameKh!;
    firstNameKh = firstNameKh == null ? "" : firstNameKh!;
    return lastNameKh! + " " + firstNameKh!;
  }

  String get fullNameEn {
    lastNameEn = lastNameEn == null ? "" : lastNameEn!;
    firstNameEn = firstNameEn == null ? "" : firstNameEn!;
    return lastNameEn! + " " + firstNameEn!;
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    try {
      methodType = json['method_type'];
      roleId = json['role_id'];
      id = json['id'];
      username = json['username'];
      password = json['password'];
      approved = json['approved'];
      approvedBy = json['approved_by'];
      firstNameKh = json['first_name_kh'];
      lastNameKh = json['last_name_kh'];
      phoneNumber = json['phone_number'];
      map = json['map'];
      createdTime = json['created_time'];
      dbCode = json['db_code'];
      createdBy = json['created_by'];
      image = json['image'];
      status = json['status'];
      type = json['type'];
      typeId = json['type_id'];
      firstNameEn = json['first_name_en'];
      lastNameEn = json['last_name_en'];
      udid = json['udid'];
      position = json['position'];
      org = json['org'];
      approvedTime = json['approved_time'];
      pdfUrl = json['pdf_url'];
      formAttachment = json["form_attachment"];
      if (json['role'] != null) {
        role = <RoleModel>[];
        json['role'].forEach((v) {
          role!.add(new RoleModel.fromJson(v));
        });
      }
    } catch (err) {
      print("sup");
      print(err);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method_type'] = this.methodType;
    data['role_id'] = this.roleId;
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['approved'] = this.approved;
    data['approved_by'] = this.approvedBy;
    data['first_name_kh'] = this.firstNameKh;
    data['last_name_kh'] = this.lastNameKh;
    data['phone_number'] = this.phoneNumber;
    data['map'] = this.map;
    data['created_time'] = this.createdTime;
    data['db_code'] = this.dbCode;
    data['created_by'] = this.createdBy;
    data['image'] = this.image;
    data['status'] = this.status;
    data['type'] = this.type;
    data['type_id'] = this.typeId;
    data['first_name_en'] = this.firstNameEn;
    data['last_name_en'] = this.lastNameEn;
    data['udid'] = this.udid;
    data['position'] = this.position;
    data['org'] = this.org;
    data['approved_time'] = this.approvedTime;
    data['pdf_url'] = this.pdfUrl;
    data['form_attachment'] = this.formAttachment;
    if (this.role != null) {
      data['role'] = this.role!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
