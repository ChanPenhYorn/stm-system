import 'package:stm_report_app/Entity/User/UserModel.dart';

class Token {
  String? accessToken;
  String? tokenType;
  UserModel? user;
  List<Permission>? permission;
  int? expiresIn;
  String get BearerToken {
    return "Bearer " + accessToken!;
  }

  Token(
      {this.accessToken,
      this.tokenType,
      this.user,
      this.permission,
      this.expiresIn});

  Token.fromJson(Map<String, dynamic> json) {
    try {
      accessToken = json['access_token'];
      tokenType = json['token_type'];
      user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
      if (json['permission'] != null) {
        permission = <Permission>[];
        json['permission'].forEach((v) {
          permission!.add(new Permission.fromJson(v));
        });
      }
      expiresIn = json['expires_in'];
      print("no error");
    } catch (err) {
      print('sup');
      print(err);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.permission != null) {
      data['permission'] = this.permission!.map((v) => v.toJson()).toList();
    }
    data['expires_in'] = this.expiresIn;
    return data;
  }
}

class Permission {
  String? activity;
  String? widgetKh;
  String? widgetEn;
  String? grant;
  String? located;
  String? type;
  String? platform;
  int? get;
  int? update;
  int? delete;

  Permission(
      {this.activity,
      this.widgetKh,
      this.widgetEn,
      this.grant,
      this.located,
      this.type,
      this.platform,
      this.get,
      this.update,
      this.delete});

  Permission.fromJson(Map<String, dynamic> json) {
    activity = json['activity'];
    widgetKh = json['widget_kh'];
    widgetEn = json['widget_en'];
    grant = json['grant'];
    located = json['located'];
    type = json['type'];
    platform = json['platform'];
    get = json['get'];
    update = json['update'];
    delete = json['delete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity'] = this.activity;
    data['widget_kh'] = this.widgetKh;
    data['widget_en'] = this.widgetEn;
    data['grant'] = this.grant;
    data['located'] = this.located;
    data['type'] = this.type;
    data['platform'] = this.platform;
    data['get'] = this.get;
    data['update'] = this.update;
    data['delete'] = this.delete;
    return data;
  }
}

// class Token {
//   String? accessToken;
//   String? role;
//   String basicToken = "Basic YWRtaW46QmNAZG1pbg==";
//   int? userid;
//   late List<PermissionList> permission;
//   late List<Configures>? configures;
//   String? firstName;
//   String? lastName;
//   int? userType;
//   String? type;
//   String? typeid;
//   String? image;
//   String? warehouse;
//   String? dbcode;
//   String? address;
//
//   String get BearerToken {
//     return "Bearer " + accessToken!;
//   }
//
//   Token({this.firstName, this.lastName, this.accessToken, this.userid});
//
//   Token.fromJson(Map<String, dynamic> map) {
//     accessToken = map['token'];
//     role = map['role'];
//     userid = map['userid'];
//     firstName = map['firstName'];
//     lastName = map['lastName'];
//     userType = map['userType'];
//     type = map['type'];
//     typeid = map['typeid'];
//     image = map['image'];
//     warehouse = map['warehouse'];
//     dbcode = map['dbcode'];
//     address = map['address'];
//     if (map['permission'] != null) {
//       permission = <PermissionList>[];
//       map['permission'].forEach((v) {
//         permission.add(new PermissionList.fromJson(v));
//       });
//     }
//     if (map['configures'] != null) {
//       configures = <Configures>[];
//       map['configures'].forEach((v) {
//         configures!.add(new Configures.fromJson(v));
//       });
//     }
//   }
// }
