class PricePostModel {
  double? price;
  String? priceUnit;
  String? date;

  PricePostModel({this.price, this.priceUnit, this.date});

  PricePostModel.fromJson(Map<String, dynamic> json) {
    price = json['price'].toDouble();
    priceUnit = json['price_unit'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['price_unit'] = this.priceUnit;
    data['date'] = this.date;
    return data;
  }
}
