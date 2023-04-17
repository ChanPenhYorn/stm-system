// class PPSHVTopupModel {
//   String? fromDate;
//   String? toDate;
//   List<PPSHVTopupDataModel>? data;
//   PPSHVTopupDataAverage? average;
//
//   PPSHVTopupModel({
//     this.fromDate,
//     this.toDate,
//     this.data,
//     this.average,
//   });
//
//   PPSHVTopupModel.fromJson(Map<String, dynamic> json) {
//     fromDate = json['from-date'];
//     toDate = json['to-date'];
//     if (json['data'] != null) {
//       data = <PPSHVTopupDataModel>[];
//       json['data'].forEach((v) {
//         data!.add(new PPSHVTopupDataModel.fromJson(v));
//       });
//     }
//     average = json['average'] != null
//         ? new PPSHVTopupDataAverage.fromJson(json['average'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['from-date'] = this.fromDate;
//     data['to-date'] = this.toDate;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     if (this.average != null) {
//       data['average'] = this.average!.toJson();
//     }
//     return data;
//   }
// }
//
// class PPSHVTopupDataModel {
//   String? date;
//   double? amountObuTotal;
//   double? amountObuPercent;
//   double? amountAnprTotal;
//   double? amountAnprPercent;
//   double? amountTotal;
//   int? transactionObuTxn;
//   double? transactionObuPercent;
//   int? transactionAnprTxn;
//   double? transactionAnprPercent;
//   double? transactionTotal;
//   int? trafficTotal;
//
//   PPSHVTopupDataModel({
//     this.date,
//     this.amountObuTotal,
//     this.amountObuPercent,
//     this.amountAnprTotal,
//     this.amountAnprPercent,
//     this.amountTotal,
//     this.transactionObuTxn,
//     this.transactionObuPercent,
//     this.transactionAnprTxn,
//     this.transactionAnprPercent,
//     this.transactionTotal,
//     this.trafficTotal,
//   });
//
//   PPSHVTopupDataModel.fromJson(Map<String, dynamic> json) {
//     date = json['date'];
//     amountObuTotal = json['amount-obu-total'].toDouble();
//     amountObuPercent = json['amount-obu-percent'].toDouble();
//     amountAnprTotal = json['amount-anpr-total'].toDouble();
//     amountAnprPercent = json['amount-anpr-percent'].toDouble();
//     amountTotal = json['amount-total'].toDouble();
//     transactionObuTxn = json['transaction-obu-txn'];
//     transactionObuPercent = json['transaction-obu-percent'].toDouble();
//     transactionAnprTxn = json['transaction-anpr-txn'];
//     transactionAnprPercent = json['transaction-anpr-percent'].toDouble();
//     transactionTotal = json['transaction-total'].toDouble();
//     trafficTotal = json['traffic-total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['date'] = this.date;
//     data['amount-obu-total'] = this.amountObuTotal;
//     data['amount-obu-percent'] = this.amountObuPercent;
//     data['amount-anpr-total'] = this.amountAnprTotal;
//     data['amount-anpr-percent'] = this.amountAnprPercent;
//     data['amount-total'] = this.amountTotal;
//     data['transaction-obu-txn'] = this.transactionObuTxn;
//     data['transaction-obu-percent'] = this.transactionObuPercent;
//     data['transaction-anpr-txn'] = this.transactionAnprTxn;
//     data['transaction-anpr-percent'] = this.transactionAnprPercent;
//     data['transaction-total'] = this.transactionTotal;
//     data['traffic-total'] = this.trafficTotal;
//
//     return data;
//   }
// }
//
// class PPSHVTopupDataAverage {
//   double? amountObuTotal;
//   double? amountObuPercent;
//   double? amountAnprTotal;
//   double? amountAnprPercent;
//   double? amountTotal;
//   int? transactionObuTxn;
//   double? transactionObuPercent;
//   int? transactionAnprTxn;
//   double? transactionAnprPercent;
//   int? transactionTotal;
//
//   PPSHVTopupDataAverage(
//       {this.amountObuTotal,
//       this.amountObuPercent,
//       this.amountAnprTotal,
//       this.amountAnprPercent,
//       this.amountTotal,
//       this.transactionObuTxn,
//       this.transactionObuPercent,
//       this.transactionAnprTxn,
//       this.transactionAnprPercent,
//       this.transactionTotal});
//
//   PPSHVTopupDataAverage.fromJson(Map<String, dynamic> json) {
//     amountObuTotal = json['amount-obu-total'];
//     amountObuPercent = json['amount-obu-percent'].toDouble();
//     amountAnprTotal = json['amount-anpr-total'];
//     amountAnprPercent = json['amount-anpr-percent'].toDouble();
//     amountTotal = json['amount-total'];
//     transactionObuTxn = json['transaction-obu-txn'];
//     transactionObuPercent = json['transaction-obu-percent'];
//     transactionAnprTxn = json['transaction-anpr-txn'];
//     transactionAnprPercent = json['transaction-anpr-percent'];
//     transactionTotal = json['transaction-total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['amount-obu-total'] = this.amountObuTotal;
//     data['amount-obu-percent'] = this.amountObuPercent;
//     data['amount-anpr-total'] = this.amountAnprTotal;
//     data['amount-anpr-percent'] = this.amountAnprPercent;
//     data['amount-total'] = this.amountTotal;
//     data['transaction-obu-txn'] = this.transactionObuTxn;
//     data['transaction-obu-percent'] = this.transactionObuPercent;
//     data['transaction-anpr-txn'] = this.transactionAnprTxn;
//     data['transaction-anpr-percent'] = this.transactionAnprPercent;
//     data['transaction-total'] = this.transactionTotal;
//     return data;
//   }
// }

class PPSHVTopupModel {
  String? fromDate;
  String? toDate;
  List<PPSHVTopupDataModel>? data;
  PPSHVTopupDataAverage? average;
  PPSHVTopupDataTotal? total;

  PPSHVTopupModel(
      {this.fromDate, this.toDate, this.data, this.average, this.total});

  PPSHVTopupModel.fromJson(Map<String, dynamic> json) {
    try {
      fromDate = json['from-date'];
      toDate = json['to-date'];
      if (json['data'] != null) {
        data = <PPSHVTopupDataModel>[];
        json['data'].forEach((v) {
          data!.add(new PPSHVTopupDataModel.fromJson(v));
        });
      }
      average = json['average'] != null
          ? new PPSHVTopupDataAverage.fromJson(json['average'])
          : null;
      total = json['total'] != null
          ? new PPSHVTopupDataTotal.fromJson(json['total'])
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
    return data;
  }
}

class PPSHVTopupDataModel {
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

  PPSHVTopupDataModel(
      {this.date,
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
      this.trafficTotal});

  PPSHVTopupDataModel.empty() {
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
  }

  PPSHVTopupDataModel.fromJson(Map<String, dynamic> json) {
    try {
      date = json['date'];
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
      transactionObu = json['transaction-obu'];
      transactionObuTotalPercent =
          json['transaction-obu-total-percent'].toDouble();
      transactionAnpr = json['transaction-anpr'];
      transactionAnprTotalPercent =
          json['transaction-anpr-total-percent'].toDouble();
      transactionDigital = json['transaction-digital'];
      transactionDigitalTotalPercent =
          json['transaction-digital-total-percent'].toDouble();
      transactionIccard = json['transaction-iccard'];
      transactionIccardTotalPercent =
          json['transaction-iccard-total-percent'].toDouble();
      transactionTotal = json['transaction-total'];
      trafficTotal = json['traffic-total'];
    } catch (err) {
      print('where');
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
    return data;
  }
}

class PPSHVTopupDataAverage {
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

  PPSHVTopupDataAverage(
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

  PPSHVTopupDataAverage.fromJson(Map<String, dynamic> json) {
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
    } catch (err) {
      // print(json);
      print(err);
    }
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

class PPSHVTopupDataTotal {
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

  PPSHVTopupDataTotal(
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

  PPSHVTopupDataTotal.fromJson(Map<String, dynamic> json) {
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
    } catch (err) {
      // print(json);
      print(err);
    }
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
