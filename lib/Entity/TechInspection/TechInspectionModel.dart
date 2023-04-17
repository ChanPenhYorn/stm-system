class TechInspectionModel {
  String? title;
  String? fromDate;
  String? toDate;
  List<YearData>? yearData;
  ChangeAmount? changeAmount;
  ChangeAmount? changePercent;

  TechInspectionModel(
      {this.title,
      this.fromDate,
      this.toDate,
      this.yearData,
      this.changeAmount,
      this.changePercent});

  TechInspectionModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    fromDate = json['from-date'];
    toDate = json['to-date'];
    if (json['year-data'] != null) {
      yearData = <YearData>[];
      json['year-data'].forEach((v) {
        yearData!.add(new YearData.fromJson(v));
      });
    }
    changeAmount = json['change-amount'] != null
        ? new ChangeAmount.fromJson(json['change-amount'])
        : null;
    changePercent = json['change-percent'] != null
        ? new ChangeAmount.fromJson(json['change-percent'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['from-date'] = this.fromDate;
    data['to-date'] = this.toDate;
    if (this.yearData != null) {
      data['year-data'] = this.yearData!.map((v) => v.toJson()).toList();
    }
    if (this.changeAmount != null) {
      data['change-amount'] = this.changeAmount!.toJson();
    }
    if (this.changePercent != null) {
      data['change-percent'] = this.changePercent!.toJson();
    }
    return data;
  }

  static List<TechInspectionModel> fromJsonArray(List<dynamic> body) {
    try {
      List<TechInspectionModel> listTechInspectionModel =
          <TechInspectionModel>[];
      body.forEach((f) =>
          {listTechInspectionModel.add(TechInspectionModel.fromJson(f))});
      return listTechInspectionModel;
    } catch (err) {
      print(err);
      return [];
    }
  }
}

class YearData {
  String? year;
  List<MonthData>? monthData;
  double? total;

  YearData({this.year, this.monthData, this.total});

  YearData.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    if (json['month-data:'] != null) {
      monthData = <MonthData>[];
      json['month-data:'].forEach((v) {
        monthData!.add(new MonthData.fromJson(v));
      });
    }
    total = json['total'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    if (this.monthData != null) {
      data['month-data:'] = this.monthData!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class MonthData {
  String? month;
  double? value;

  MonthData({this.month, this.value});

  MonthData.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    value = json['value'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['value'] = this.value;
    return data;
  }
}

class ChangeAmount {
  List<MonthData>? monthData;
  double? total;

  ChangeAmount({this.monthData, this.total});

  ChangeAmount.fromJson(Map<String, dynamic> json) {
    if (json['month-data'] != null) {
      monthData = <MonthData>[];
      json['month-data'].forEach((v) {
        monthData!.add(new MonthData.fromJson(v));
      });
    }
    total = json['total'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.monthData != null) {
      data['month-data'] = this.monthData!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class ChangePercent {
  List<MonthData>? monthData;
  double? total;

  ChangePercent({this.monthData, this.total});

  ChangePercent.fromJson(Map<String, dynamic> json) {
    if (json['month-data'] != null) {
      monthData = <MonthData>[];
      json['month-data'].forEach((v) {
        monthData!.add(new MonthData.fromJson(v));
      });
    }
    total = json['total'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.monthData != null) {
      data['month-data'] = this.monthData!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}
