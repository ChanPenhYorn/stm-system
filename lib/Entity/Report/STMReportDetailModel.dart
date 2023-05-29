class STMReportDetailModel {
  String? fromDate;
  String? toDate;
  List<STMReportDetailDataModel>? data;

  STMReportDetailModel({this.fromDate, this.toDate, this.data});

  STMReportDetailModel.fromJson(Map<String, dynamic> json) {
    fromDate = json['from-date'];
    toDate = json['to-date'];
    if (json['data'] != null) {
      data = <STMReportDetailDataModel>[];
      json['data'].forEach((v) {
        data!.add(new STMReportDetailDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from-date'] = this.fromDate;
    data['to-date'] = this.toDate;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class STMReportDetailDataModel {
  String? id;
  String? couponInId;
  String? couponOutId;
  String? company;
  String? frontPlateNumber;
  String? backPlateNumber;
  String? stationInId;
  String? stationOutId;
  String? weightInDate;
  String? weightOutDate;
  int? weightIn;
  int? weightOut;
  int? weightProduct;
  String? invoiceDate;
  String? createdDate;
  String? createdBy;
  int? status;
  FrontPlateObj? frontPlateObj;
  CouponIn? couponIn;
  CouponIn? couponOut;

  STMReportDetailDataModel(
      {this.id,
      this.couponInId,
      this.couponOutId,
      this.company,
      this.frontPlateNumber,
      this.backPlateNumber,
      this.stationInId,
      this.stationOutId,
      this.weightInDate,
      this.weightOutDate,
      this.weightIn,
      this.weightOut,
      this.weightProduct,
      this.invoiceDate,
      this.createdDate,
      this.createdBy,
      this.status,
      this.frontPlateObj,
      this.couponIn,
      this.couponOut});

  STMReportDetailDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    couponInId = json['coupon_in_id'];
    couponOutId = json['coupon_out_id'];
    company = json['company'];
    frontPlateNumber = json['front_plate_number'];
    backPlateNumber = json['back_plate_number'];
    stationInId = json['station_in_id'];
    stationOutId = json['station_out_id'];
    weightInDate = json['weight_in_date'];
    weightOutDate = json['weight_out_date'];
    weightIn = json['weight_in'];
    weightOut = json['weight_out'];
    weightProduct = json['weight_product'];
    invoiceDate = json['invoice_date'];
    createdDate = json['created_date'];
    createdBy = json['created_by'];
    status = json['status'];
    frontPlateObj = json['front_plate_obj'] != null
        ? new FrontPlateObj.fromJson(json['front_plate_obj'])
        : null;
    couponIn = json['coupon_in'] != null
        ? new CouponIn.fromJson(json['coupon_in'])
        : null;
    couponOut = json['coupon_out'] != null
        ? new CouponIn.fromJson(json['coupon_out'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['coupon_in_id'] = this.couponInId;
    data['coupon_out_id'] = this.couponOutId;
    data['company'] = this.company;
    data['front_plate_number'] = this.frontPlateNumber;
    data['back_plate_number'] = this.backPlateNumber;
    data['station_in_id'] = this.stationInId;
    data['station_out_id'] = this.stationOutId;
    data['weight_in_date'] = this.weightInDate;
    data['weight_out_date'] = this.weightOutDate;
    data['weight_in'] = this.weightIn;
    data['weight_out'] = this.weightOut;
    data['weight_product'] = this.weightProduct;
    data['invoice_date'] = this.invoiceDate;
    data['created_date'] = this.createdDate;
    data['created_by'] = this.createdBy;
    data['status'] = this.status;
    if (this.frontPlateObj != null) {
      data['front_plate_obj'] = this.frontPlateObj!.toJson();
    }
    if (this.couponIn != null) {
      data['coupon_in'] = this.couponIn!.toJson();
    }
    if (this.couponOut != null) {
      data['coupon_out'] = this.couponOut!.toJson();
    }
    return data;
  }
}

class FrontPlateObj {
  String? code;
  String? nameKh;
  String? nameEn;
  String? plateNumberFormatted;

  FrontPlateObj(
      {this.code, this.nameKh, this.nameEn, this.plateNumberFormatted});

  FrontPlateObj.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    nameKh = json['name_kh'];
    nameEn = json['name_en'];
    plateNumberFormatted = json['plate_number_formatted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name_kh'] = this.nameKh;
    data['name_en'] = this.nameEn;
    data['plate_number_formatted'] = this.plateNumberFormatted;
    return data;
  }
}

class CouponIn {
  String? plateFrontUrl;
  String? plateBackUrl;
  String? vehicleFrontUrl;
  String? vehicleBackUrl;

  CouponIn(
      {this.plateFrontUrl,
      this.plateBackUrl,
      this.vehicleFrontUrl,
      this.vehicleBackUrl});

  CouponIn.fromJson(Map<String, dynamic> json) {
    plateFrontUrl = json['plate_front_url'];
    plateBackUrl = json['plate_back_url'];
    vehicleFrontUrl = json['vehicle_front_url'];
    vehicleBackUrl = json['vehicle_back_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plate_front_url'] = this.plateFrontUrl;
    data['plate_back_url'] = this.plateBackUrl;
    data['vehicle_front_url'] = this.vehicleFrontUrl;
    data['vehicle_back_url'] = this.vehicleBackUrl;
    return data;
  }
}
