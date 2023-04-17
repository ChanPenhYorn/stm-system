import 'package:stm_report_app/Entity/PPSHV/ChecksumModel.dart';

class PPSHVDeductionModel {
  String? fromDate;
  String? toDate;
  List<PPSHVDeductionDataModel>? data;
  PPSHVDeductionDataAverage? average;
  PPSHVDeductionDataTotal? total;
  Checksum? checksum;

  PPSHVDeductionModel({
    this.fromDate,
    this.toDate,
    this.data,
    this.average,
    this.total,
    this.checksum,
  });

  PPSHVDeductionModel.fromJson(Map<String, dynamic> json) {
    try {
      fromDate = json['from-date'];
      toDate = json['to-date'];
      if (json['data'] != null) {
        data = <PPSHVDeductionDataModel>[];
        json['data'].forEach((v) {
          data!.add(new PPSHVDeductionDataModel.fromJson(v));
        });
      }
      average = json['average'] != null
          ? new PPSHVDeductionDataAverage.fromJson(json['average'])
          : null;
      total = json['total'] != null
          ? new PPSHVDeductionDataTotal.fromJson(json['total'])
          : null;
      checksum = json['checksum'] != null
          ? new Checksum.fromJson(json['checksum'])
          : null;
    } catch (exception) {
      print(exception);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from-date'] = this.fromDate;
    data['to-date'] = this.toDate;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.average != null) {
      data['average'] = this.average!.toJson();
    }
    if (this.total != null) {
      data['total'] = this.total!.toJson();
    }
    if (this.checksum != null) {
      data['checksum'] = this.checksum!.toJson();
    }
    return data;
  }
}

class PPSHVDeductionDataModel {
  String? date;
  double? amountObuDollar;
  double? amountObuTotalPercent;
  double? amountAnprDollar;
  double? amountAnprTotalPercent;
  double? amountDigitalTotalDollar;
  double? amountDigitalTotalPercent;
  double? amountIccardDollar;
  double? amountIccardTotalPercent;
  double? amountTotal;
  int? transactionObu;
  double? transactionObuTotalPercent;
  int? transactionAnpr;
  double? transactionAnprTotalPercent;
  int? transactionDigital;
  double? transactionDigitalTotalPercent;
  int? transactionIccard;
  double? transactionIccardTotalPercent;
  int? transactionTotal;
  int? trafficTotal;
  Checksum? checksum;

  PPSHVDeductionDataModel({
    this.date,
    this.amountObuDollar,
    this.amountObuTotalPercent,
    this.amountAnprDollar,
    this.amountAnprTotalPercent,
    this.amountIccardDollar,
    this.amountIccardTotalPercent,
    this.amountTotal,
    this.transactionObu,
    this.transactionObuTotalPercent,
    this.transactionAnpr,
    this.transactionAnprTotalPercent,
    this.transactionIccard,
    this.transactionIccardTotalPercent,
    this.transactionTotal,
    this.trafficTotal,
    this.checksum,
  });

  PPSHVDeductionDataModel.empty() {
    date = "";
    amountObuDollar = 0;
    amountObuTotalPercent = 0;
    amountAnprDollar = 0;
    amountAnprTotalPercent = 0;
    amountDigitalTotalDollar = 0;
    amountDigitalTotalPercent = 0;
    amountIccardDollar = 0;
    amountIccardTotalPercent = 0;
    amountTotal = 0;
    transactionObu = 0;
    transactionObuTotalPercent = 0;
    transactionAnpr = 0;
    transactionAnprTotalPercent = 0;
    transactionDigital;
    transactionDigitalTotalPercent = 0;
    transactionIccard = 0;
    transactionIccardTotalPercent = 0;
    transactionTotal = 0;
    trafficTotal = 0;
    Checksum checksum = Checksum();
  }

  PPSHVDeductionDataModel.fromJson(Map<String, dynamic> json) {
    try {
      date = json['date'];
      amountObuDollar = json['amount-obu-dollar'].toDouble();
      amountObuTotalPercent = json['amount-obu-total-percent'].toDouble();
      amountAnprDollar = json['amount-anpr-dollar'].toDouble();
      amountAnprTotalPercent = json['amount-anpr-total-percent'].toDouble();
      amountDigitalTotalDollar = json['amount-digital-total-dollar'].toDouble();
      ;
      amountDigitalTotalPercent =
          json['amount-digital-total-percent'].toDouble();
      ;
      amountIccardDollar = json['amount-iccard-dollar'].toDouble();
      ;
      amountIccardTotalPercent = json['amount-iccard-total-percent'].toDouble();
      amountTotal = json['amount-total'].toDouble();
      transactionObu = json['transaction-obu'];
      transactionObuTotalPercent =
          json['transaction-obu-total-percent'].toDouble();
      transactionAnpr = json['transaction-anpr'];
      transactionAnprTotalPercent =
          json['transaction-anpr-total-percent'].toDouble();
      transactionDigital = json['transaction-digital'];
      transactionDigitalTotalPercent =
          json['transaction-digital-total-percent'].toDouble();
      ;
      transactionIccard = json['transaction-iccard'];
      transactionIccardTotalPercent =
          json['transaction-iccard-total-percent'].toDouble();
      transactionTotal = json['transaction-total'];
      trafficTotal = json['traffic-total'];
      checksum = json['checksum'] != null
          ? new Checksum.fromJson(json['checksum'])
          : null;
    } catch (err) {
      // print(json);
      print(err);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['amount-obu-dollar'] = this.amountObuDollar;
    data['amount-obu-total-percent'] = this.amountObuTotalPercent;
    data['amount-anpr-dollar'] = this.amountAnprDollar;
    data['amount-anpr-total-percent'] = this.amountAnprTotalPercent;
    data['amount-digital-total-dollar'] = this.amountDigitalTotalDollar;
    data['amount-digital-total-percent'] = this.amountDigitalTotalPercent;
    data['amount-iccard-dollar'] = this.amountIccardDollar;
    data['amount-iccard-total-percent'] = this.amountIccardTotalPercent;
    data['amount-total'] = this.amountTotal;
    data['transaction-obu'] = this.transactionObu;
    data['transaction-obu-total-percent'] = this.transactionObuTotalPercent;
    data['transaction-anpr'] = this.transactionAnpr;
    data['transaction-anpr-total-percent'] = this.transactionAnprTotalPercent;
    data['transaction-digital'] = this.transactionDigital;
    data['transaction-digital-total-percent'] =
        this.transactionDigitalTotalPercent;
    data['transaction-iccard'] = this.transactionIccard;
    data['transaction-iccard-total-percent'] =
        this.transactionIccardTotalPercent;
    data['transaction-total'] = this.transactionTotal;
    data['traffic-total'] = this.trafficTotal;
    if (this.checksum != null) {
      data['checksum'] = this.checksum!.toJson();
    }
    return data;
  }
}

class PPSHVDeductionDataAverage {
  double? amountObuDollar;
  double? amountObuTotalPercent;
  double? amountAnprDollar;
  double? amountAnprTotalPercent;
  double? amountDigitalTotalDollar;
  double? amountDigitalTotalPercent;
  double? amountIccardDollar;
  double? amountIccardTotalPercent;
  double? amountTotal;
  double? transactionObu;
  double? transactionObuTotalPercent;
  double? transactionAnpr;
  double? transactionAnprTotalPercent;
  double? transactionDigital;
  double? transactionDigitalTotalPercent;
  double? transactionIccard;
  double? transactionIccardTotalPercent;
  double? transactionTotal;
  double? trafficTotal;

  PPSHVDeductionDataAverage(
      {this.amountObuDollar,
      this.amountObuTotalPercent,
      this.amountAnprDollar,
      this.amountAnprTotalPercent,
      this.amountDigitalTotalDollar,
      this.amountDigitalTotalPercent,
      this.amountIccardDollar,
      this.amountIccardTotalPercent,
      this.amountTotal,
      this.transactionObu,
      this.transactionObuTotalPercent,
      this.transactionAnpr,
      this.transactionAnprTotalPercent,
      this.transactionDigital,
      this.transactionDigitalTotalPercent,
      this.transactionIccard,
      this.transactionIccardTotalPercent,
      this.transactionTotal,
      this.trafficTotal});

  PPSHVDeductionDataAverage.fromJson(Map<String, dynamic> json) {
    try {
      amountObuDollar = json['amount-obu-dollar'].toDouble();
      amountObuTotalPercent = json['amount-obu-total-percent'].toDouble();
      amountAnprDollar = json['amount-anpr-dollar'].toDouble();
      amountAnprTotalPercent = json['amount-anpr-total-percent'].toDouble();
      amountDigitalTotalDollar = json['amount-digital-total-dollar'].toDouble();
      amountDigitalTotalPercent =
          json['amount-digital-total-percent'].toDouble();
      amountIccardDollar = json['amount-iccard-dollar'].toDouble();
      amountIccardTotalPercent = json['amount-iccard-total-percent'].toDouble();
      amountTotal = json['amount-total'].toDouble();
      transactionObu = json['transaction-obu'].toDouble();
      transactionObuTotalPercent =
          json['transaction-obu-total-percent'].toDouble();
      transactionAnpr = json['transaction-anpr'].toDouble();
      transactionAnprTotalPercent =
          json['transaction-anpr-total-percent'].toDouble();
      transactionDigital = json['transaction-digital'].toDouble();
      transactionDigitalTotalPercent =
          json['transaction-digital-total-percent'].toDouble();
      transactionIccard = json['transaction-iccard'].toDouble();
      transactionIccardTotalPercent =
          json['transaction-iccard-total-percent'].toDouble();
      transactionTotal = json['transaction-total'].toDouble();
      trafficTotal = json['traffic-total'].toDouble();
    } catch (err) {}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount-obu-dollar'] = this.amountObuDollar;
    data['amount-obu-total-percent'] = this.amountObuTotalPercent;
    data['amount-anpr-dollar'] = this.amountAnprDollar;
    data['amount-anpr-total-percent'] = this.amountAnprTotalPercent;
    data['amount-digital-total-dollar'] = this.amountDigitalTotalDollar;
    data['amount-digital-total-percent'] = this.amountDigitalTotalPercent;
    data['amount-iccard-dollar'] = this.amountIccardDollar;
    data['amount-iccard-total-percent'] = this.amountIccardTotalPercent;
    data['amount-total'] = this.amountTotal;
    data['transaction-obu'] = this.transactionObu;
    data['transaction-obu-total-percent'] = this.transactionObuTotalPercent;
    data['transaction-anpr'] = this.transactionAnpr;
    data['transaction-anpr-total-percent'] = this.transactionAnprTotalPercent;
    data['transaction-digital'] = this.transactionDigital;
    data['transaction-digital-total-percent'] =
        this.transactionDigitalTotalPercent;
    data['transaction-iccard'] = this.transactionIccard;
    data['transaction-iccard-total-percent'] =
        this.transactionIccardTotalPercent;
    data['transaction-total'] = this.transactionTotal;
    data['traffic-total'] = this.trafficTotal;
    return data;
  }
}

class PPSHVDeductionDataTotal {
  double? amountObuDollar;
  double? amountObuTotalPercent;
  double? amountAnprDollar;
  double? amountAnprTotalPercent;
  double? amountDigitalTotalDollar;
  double? amountDigitalTotalPercent;
  double? amountIccardDollar;
  double? amountIccardTotalPercent;
  double? amountTotal;
  double? transactionObu;
  double? transactionObuTotalPercent;
  double? transactionAnpr;
  double? transactionAnprTotalPercent;
  double? transactionDigital;
  double? transactionDigitalTotalPercent;
  double? transactionIccard;
  double? transactionIccardTotalPercent;
  double? transactionTotal;
  double? trafficTotal;

  PPSHVDeductionDataTotal(
      {this.amountObuDollar,
      this.amountObuTotalPercent,
      this.amountAnprDollar,
      this.amountAnprTotalPercent,
      this.amountDigitalTotalDollar,
      this.amountDigitalTotalPercent,
      this.amountIccardDollar,
      this.amountIccardTotalPercent,
      this.amountTotal,
      this.transactionObu,
      this.transactionObuTotalPercent,
      this.transactionAnpr,
      this.transactionAnprTotalPercent,
      this.transactionDigital,
      this.transactionDigitalTotalPercent,
      this.transactionIccard,
      this.transactionIccardTotalPercent,
      this.transactionTotal,
      this.trafficTotal});

  PPSHVDeductionDataTotal.fromJson(Map<String, dynamic> json) {
    try {
      amountObuDollar = json['amount-obu-dollar'].toDouble();
      amountObuTotalPercent = json['amount-obu-total-percent'].toDouble();
      amountAnprDollar = json['amount-anpr-dollar'].toDouble();
      amountAnprTotalPercent = json['amount-anpr-total-percent'].toDouble();
      amountDigitalTotalDollar = json['amount-digital-total-dollar'].toDouble();
      amountDigitalTotalPercent =
          json['amount-digital-total-percent'].toDouble();
      amountIccardDollar = json['amount-iccard-dollar'].toDouble();
      amountIccardTotalPercent = json['amount-iccard-total-percent'].toDouble();
      amountTotal = json['amount-total'].toDouble();
      transactionObu = json['transaction-obu'].toDouble();
      transactionObuTotalPercent =
          json['transaction-obu-total-percent'].toDouble();
      transactionAnpr = json['transaction-anpr'].toDouble();
      transactionAnprTotalPercent =
          json['transaction-anpr-total-percent'].toDouble();
      transactionDigital = json['transaction-digital'].toDouble();
      transactionDigitalTotalPercent =
          json['transaction-digital-total-percent'].toDouble();
      transactionIccard = json['transaction-iccard'].toDouble();
      transactionIccardTotalPercent =
          json['transaction-iccard-total-percent'].toDouble();
      transactionTotal = json['transaction-total'].toDouble();
      trafficTotal = json['traffic-total'].toDouble();
    } catch (err) {}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount-obu-dollar'] = this.amountObuDollar;
    data['amount-obu-total-percent'] = this.amountObuTotalPercent;
    data['amount-anpr-dollar'] = this.amountAnprDollar;
    data['amount-anpr-total-percent'] = this.amountAnprTotalPercent;
    data['amount-digital-total-dollar'] = this.amountDigitalTotalDollar;
    data['amount-digital-total-percent'] = this.amountDigitalTotalPercent;
    data['amount-iccard-dollar'] = this.amountIccardDollar;
    data['amount-iccard-total-percent'] = this.amountIccardTotalPercent;
    data['amount-total'] = this.amountTotal;
    data['transaction-obu'] = this.transactionObu;
    data['transaction-obu-total-percent'] = this.transactionObuTotalPercent;
    data['transaction-anpr'] = this.transactionAnpr;
    data['transaction-anpr-total-percent'] = this.transactionAnprTotalPercent;
    data['transaction-digital'] = this.transactionDigital;
    data['transaction-digital-total-percent'] =
        this.transactionDigitalTotalPercent;
    data['transaction-iccard'] = this.transactionIccard;
    data['transaction-iccard-total-percent'] =
        this.transactionIccardTotalPercent;
    data['transaction-total'] = this.transactionTotal;
    data['traffic-total'] = this.trafficTotal;
    return data;
  }
}
