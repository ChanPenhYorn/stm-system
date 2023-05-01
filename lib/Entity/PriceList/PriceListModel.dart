class PriceListModel {
  DefaultPrice? defaultPrice;
  List<ListPrice>? listPrice;

  PriceListModel({this.defaultPrice, this.listPrice});

  PriceListModel.fromJson(Map<String, dynamic> json) {
    defaultPrice = json['default_price'] != null
        ? new DefaultPrice.fromJson(json['default_price'])
        : null;
    if (json['list_price'] != null) {
      listPrice = <ListPrice>[];
      json['list_price'].forEach((v) {
        listPrice!.add(new ListPrice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.defaultPrice != null) {
      data['default_price'] = this.defaultPrice!.toJson();
    }
    if (this.listPrice != null) {
      data['list_price'] = this.listPrice!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DefaultPrice {
  double? price;
  String? priceUnit;

  DefaultPrice({this.price, this.priceUnit});

  DefaultPrice.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    priceUnit = json['price_unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['price_unit'] = this.priceUnit;
    return data;
  }
}

class ListPrice {
  double? price;
  String? priceUnit;
  String? date;

  ListPrice({this.price, this.priceUnit, this.date});

  ListPrice.fromJson(Map<String, dynamic> json) {
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
