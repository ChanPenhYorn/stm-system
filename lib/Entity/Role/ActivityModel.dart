class ActivityModel {
  int? id;
  String? widgetName;
  String? widgetNameKh;
  String? located;
  String? type;
  String? platform;
  String? dbCode;
  String? get;
  String? update;
  String? delete;

  ActivityModel({
    this.id,
    this.widgetName,
    this.widgetNameKh,
    this.located,
    this.type,
    this.platform,
    this.dbCode,
    this.get,
    this.update,
    this.delete,
  });

  ActivityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    widgetName = json['widget_name'];
    widgetNameKh = json['widget_name_kh'];
    located = json['located'];
    type = json['type'];
    platform = json['platform'];
    dbCode = json['db_code'];
    get = json['get'];
    update = json['update'];
    delete = json['delete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['widget_name'] = this.widgetName;
    data['widget_name_kh'] = this.widgetNameKh;
    data['located'] = this.located;
    data['type'] = this.type;
    data['platform'] = this.platform;
    data['db_code'] = this.dbCode;
    data['get'] = this.get;
    data['update'] = this.update;
    data['delete'] = this.delete;
    return data;
  }
}
