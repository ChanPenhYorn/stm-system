class AppVersion {
  String? id;
  String? appVersion;
  String? iosVersion;
  String? androidVersion;
  String? apiVersion;
  String? appName;
  String? deployDate;
  String? status;

  AppVersion(
      {this.id,
      this.appVersion,
      this.iosVersion,
      this.androidVersion,
      this.apiVersion,
      this.appName,
      this.deployDate,
      this.status});

  AppVersion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appVersion = json['app_version'];
    iosVersion = json['ios_version'];
    androidVersion = json['android_version'];
    apiVersion = json['api_version'];
    appName = json['app_name'];
    deployDate = json['deploy_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['app_version'] = this.appVersion;
    data['ios_version'] = this.iosVersion;
    data['android_version'] = this.androidVersion;
    data['api_version'] = this.apiVersion;
    data['app_name'] = this.appName;
    data['deploy_date'] = this.deployDate;
    data['status'] = this.status;
    return data;
  }
}
