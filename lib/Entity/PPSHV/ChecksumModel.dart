class Checksum {
  String? excelUrl;
  String? pdfUrl;
  GrandTotal? grandTotal;
  VehicleType? typeA;
  VehicleType? typeB;
  VehicleType? typeC;
  VehicleType? typeD;
  VehicleType? typeE;

  Checksum(
      {this.excelUrl,
      this.pdfUrl,
      this.grandTotal,
      this.typeA,
      this.typeB,
      this.typeC,
      this.typeD,
      this.typeE});

  Checksum.fromJson(Map<String, dynamic> json) {
    excelUrl = json['excel_url'];
    pdfUrl = json['pdf_url'];
    grandTotal = json['grand_total'] != null
        ? new GrandTotal.fromJson(json['grand_total'])
        : null;
    typeA = json['type_a'] != null
        ? new VehicleType.fromJson(json['type_a'])
        : null;
    typeB = json['type_b'] != null
        ? new VehicleType.fromJson(json['type_b'])
        : null;
    typeC = json['type_c'] != null
        ? new VehicleType.fromJson(json['type_c'])
        : null;
    typeD = json['type_d'] != null
        ? new VehicleType.fromJson(json['type_d'])
        : null;
    typeE = json['type_e'] != null
        ? new VehicleType.fromJson(json['type_e'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['excel_url'] = this.excelUrl;
    data['pdf_url'] = this.pdfUrl;
    if (this.grandTotal != null) {
      data['grand_total'] = this.grandTotal!.toJson();
    }
    if (this.typeA != null) {
      data['type_a'] = this.typeA!.toJson();
    }
    if (this.typeB != null) {
      data['type_b'] = this.typeB!.toJson();
    }
    if (this.typeC != null) {
      data['type_c'] = this.typeC!.toJson();
    }
    if (this.typeD != null) {
      data['type_d'] = this.typeD!.toJson();
    }
    if (this.typeE != null) {
      data['type_e'] = this.typeE!.toJson();
    }
    return data;
  }
}

class GrandTotal {
  double? amount;
  int? trip;
  int? trip0point0;
  double? trip0point0Percentage;
  int? trip78point4;
  double? trip78point4Percentage;
  int? trip80point0;
  double? trip80point0Percentage;

  GrandTotal(
      {this.amount,
      this.trip,
      this.trip0point0,
      this.trip0point0Percentage,
      this.trip78point4,
      this.trip78point4Percentage});

  GrandTotal.fromJson(Map<String, dynamic> json) {
    amount = json['amount'].toDouble();
    trip = json['trip'];
    trip0point0 = json['trip_0point0'];
    trip0point0Percentage = json['trip_0point0_percentage'].toDouble();
    trip78point4 = json['trip_78point4'];
    trip78point4Percentage = json['trip_78point4_percentage'].toDouble();
    trip80point0 = json['trip_80point0'];
    trip80point0Percentage = json['trip_80point0_percentage'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['trip'] = this.trip;
    data['trip_0point0'] = this.trip0point0;
    data['trip_0point0_percentage'] = this.trip0point0Percentage;
    data['trip_78point4'] = this.trip78point4;
    data['trip_78point4_percentage'] = this.trip78point4Percentage;
    data['trip_80point0'] = this.trip80point0;
    data['trip_80point0_percentage'] = this.trip80point0Percentage;
    return data;
  }
}

class VehicleType {
  double? amount;
  double? tripPercentage;
  int? trip;
  int? type0point0;
  int? type78point4;
  int? type80point0;

  VehicleType(
      {this.amount,
      this.tripPercentage,
      this.trip,
      this.type0point0,
      this.type78point4,
      this.type80point0});

  VehicleType.fromJson(Map<String, dynamic> json) {
    amount = json['amount'].toDouble();
    tripPercentage = json['trip_percentage'].toDouble();
    trip = json['trip'];
    type0point0 = json['type_0point0'];
    type78point4 = json['type_78point4'];
    type80point0 = json['type_80point0'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['trip_percentage'] = this.tripPercentage;
    data['trip'] = this.trip;
    data['type_0point0'] = this.type0point0;
    data['type_78point4'] = this.type78point4;
    data['type_80point0'] = this.type80point0;
    return data;
  }
}
