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
  double? weightKg;
  double? weightTotalPercent;
  double? incomeDollar;
  double? incomeTotalPercent;

  STMReportDataModel(
      {this.date,
      this.vehicleTrx,
      this.vehicleTotalPercent,
      this.weightKg,
      this.weightTotalPercent,
      this.incomeDollar,
      this.incomeTotalPercent});

  STMReportDataModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    vehicleTrx = json['vehicle-trx'];
    vehicleTotalPercent = json['vehicle-total-percent'] != null
        ? json['vehicle-total-percent'].toDouble()
        : null;
    weightKg = json['weight-kg'] != null ? json['weight-kg'].toDouble() : null;
    weightTotalPercent = json['weight-total-percent'] != null
        ? json['weight-total-percent'].toDouble()
        : null;
    incomeDollar =
        json['income-dollar'] != null ? json['income-dollar'].toDouble() : null;
    incomeTotalPercent = json['income-total-percent'] != null
        ? json['income-total-percent'].toDouble()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['vehicle-trx'] = this.vehicleTrx;
    data['vehicle-total-percent'] = this.vehicleTotalPercent;
    data['weight-kg'] = this.weightKg;
    data['weight-total-percent'] = this.weightTotalPercent;
    data['income-dollar'] = this.incomeDollar;
    data['income-total-percent'] = this.incomeTotalPercent;
    return data;
  }
}

class Total {
  int? vehicleTrx;
  double? weightKg;
  double? incomeDollar;
  int? maximumValueVehicleTrx;
  double? maximumValueWeightKg;
  double? maximumValueIncomeDollar;
  int? minimumValueVehicleTrx;
  double? minimumValueWeightKg;
  double? minimumValueIncomeDollar;

  Total(
      {this.vehicleTrx,
      this.weightKg,
      this.incomeDollar,
      this.maximumValueVehicleTrx,
      this.maximumValueWeightKg,
      this.maximumValueIncomeDollar,
      this.minimumValueVehicleTrx,
      this.minimumValueWeightKg,
      this.minimumValueIncomeDollar});

  Total.fromJson(Map<String, dynamic> json) {
    vehicleTrx = json['vehicle-trx'];
    weightKg = json['weight-kg'] != null ? json['weight-kg'].toDouble() : null;
    incomeDollar =
        json['income-dollar'] != null ? json['income-dollar'].toDouble() : null;
    maximumValueVehicleTrx = json['maximum-value-vehicle-trx'] != null
        ? json['maximum-value-vehicle-trx']
        : null;
    maximumValueWeightKg = json['maximum-value-weight-kg'] != null
        ? json['maximum-value-weight-kg'].toDouble()
        : null;
    maximumValueIncomeDollar = json['maximum-value-income-dollar'] != null
        ? json['maximum-value-income-dollar'].toDouble()
        : null;
    minimumValueVehicleTrx = json['minimum-value-vehicle-trx'];
    minimumValueWeightKg = json['minimum-value-weight-kg'] != null
        ? json['minimum-value-weight-kg'].toDouble()
        : null;
    minimumValueIncomeDollar = json['minimum-value-income-dollar'] != null
        ? json['minimum-value-income-dollar'].toDouble()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicle-trx'] = this.vehicleTrx;
    data['weight-kg'] = this.weightKg;
    data['income-dollar'] = this.incomeDollar;
    data['maximum-value-vehicle-trx'] = this.maximumValueVehicleTrx;
    data['maximum-value-weight-kg'] = this.maximumValueWeightKg;
    data['maximum-value-income-dollar'] = this.maximumValueIncomeDollar;
    data['minimum-value-vehicle-trx'] = this.minimumValueVehicleTrx;
    data['minimum-value-weight-kg'] = this.minimumValueWeightKg;
    data['minimum-value-income-dollar'] = this.minimumValueIncomeDollar;
    return data;
  }
}
