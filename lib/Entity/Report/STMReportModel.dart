class STMReportModel {
  String? fromDate;
  String? toDate;
  List<STMReportDataModel>? data;
  Total? total;

  STMReportModel({this.fromDate, this.toDate, this.data, this.total});

  STMReportModel.fromJson(Map<String, dynamic> json) {
    fromDate = json['from-date'];
    toDate = json['to-date'];
    if (json['data'] != null) {
      data = <STMReportDataModel>[];
      json['data'].forEach((v) {
        data!.add(new STMReportDataModel.fromJson(v));
      });
    }
    total = json['total'] != null ? new Total.fromJson(json['total']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from-date'] = this.fromDate;
    data['to-date'] = this.toDate;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.total != null) {
      data['total'] = this.total!.toJson();
    }
    return data;
  }
}

class STMReportDataModel {
  String? date;
  int? vehicleTrx;
  double? vehicleTotalPercent;
  double? weightTonne;
  double? weightTotalPercent;
  double? incomeDollar;
  double? incomeTotalPercent;

  STMReportDataModel(
      {this.date,
      this.vehicleTrx,
      this.vehicleTotalPercent,
      this.weightTonne,
      this.weightTotalPercent,
      this.incomeDollar,
      this.incomeTotalPercent});

  STMReportDataModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    vehicleTrx = json['vehicle-trx'];
    vehicleTotalPercent = json['vehicle-total-percent'].toDouble();
    weightTonne = json['weight-tonne'].toDouble();
    weightTotalPercent = json['weight-total-percent'].toDouble();
    incomeDollar = json['income-dollar'].toDouble();
    incomeTotalPercent = json['income-total-percent'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['vehicle-trx'] = this.vehicleTrx;
    data['vehicle-total-percent'] = this.vehicleTotalPercent;
    data['weight-tonne'] = this.weightTonne;
    data['weight-total-percent'] = this.weightTotalPercent;
    data['income-dollar'] = this.incomeDollar;
    data['income-total-percent'] = this.incomeTotalPercent;
    return data;
  }
}

class Total {
  int? vehicleTrx;
  double? weightTonne;
  double? incomeDollar;
  int? maximumValueVehicleTrx;
  double? maximumValueWeightTonne;
  double? maximumValueIncomeDollar;
  int? minimumValueVehicleTrx;
  double? minimumValueWeightTonne;
  double? minimumValueIncomeDollar;

  Total(
      {this.vehicleTrx,
      this.weightTonne,
      this.incomeDollar,
      this.maximumValueVehicleTrx,
      this.maximumValueWeightTonne,
      this.maximumValueIncomeDollar,
      this.minimumValueVehicleTrx,
      this.minimumValueWeightTonne,
      this.minimumValueIncomeDollar});

  Total.fromJson(Map<String, dynamic> json) {
    vehicleTrx = json['vehicle-trx'];
    weightTonne = json['weight-tonne'].toDouble();
    incomeDollar = json['income-dollar'].toDouble();
    maximumValueVehicleTrx = json['maximum-value-vehicle-trx'];
    maximumValueWeightTonne = json['maximum-value-weight-tonne'].toDouble();
    maximumValueIncomeDollar = json['maximum-value-income-dollar'].toDouble();
    minimumValueVehicleTrx = json['minimum-value-vehicle-trx'];
    minimumValueWeightTonne = json['minimum-value-weight-tonne'].toDouble();
    minimumValueIncomeDollar = json['minimum-value-income-dollar'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicle-trx'] = this.vehicleTrx;
    data['weight-tonne'] = this.weightTonne;
    data['income-dollar'] = this.incomeDollar;
    data['maximum-value-vehicle-trx'] = this.maximumValueVehicleTrx;
    data['maximum-value-weight-tonne'] = this.maximumValueWeightTonne;
    data['maximum-value-income-dollar'] = this.maximumValueIncomeDollar;
    data['minimum-value-vehicle-trx'] = this.minimumValueVehicleTrx;
    data['minimum-value-weight-tonne'] = this.minimumValueWeightTonne;
    data['minimum-value-income-dollar'] = this.minimumValueIncomeDollar;
    return data;
  }
}
