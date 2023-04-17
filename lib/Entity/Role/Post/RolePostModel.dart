class RolePostModel {
  String? methodType;
  String? roleid;
  String? rolename;
  List<Activities>? activities;

  RolePostModel({this.methodType, this.roleid, this.rolename, this.activities});

  RolePostModel.fromJson(Map<String, dynamic> json) {
    methodType = json['method_type'];
    roleid = json['role_id'];
    rolename = json['role_name'];
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add(new Activities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method_type'] = this.methodType;
    data['role_id'] = this.roleid;
    data['role_name'] = this.rolename;
    if (this.activities != null) {
      data['activities'] = this.activities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Activities {
  int? id;
  int? get;
  int? update;
  int? delete;

  Activities({this.id, this.get, this.update, this.delete});

  Activities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    get = json['get'];
    update = json['update'];
    delete = json['delete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['get'] = this.get;
    data['update'] = this.update;
    data['delete'] = this.delete;
    return data;
  }
}
