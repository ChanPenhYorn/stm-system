class ResponseRes<T, D> {
  bool? success;
  String? description;
  T? data;

  ResponseRes.fromJson(Map<String, dynamic> json, {D deserialize(dynamic e)?}) {
    success = json['success'] == "true" ? true : false;
    // success = json['success'];
    description = json['description'];
    if (json['data'] != null) {
      if (json['data'] is List) {
        data = json['data'].map((e) => deserialize!(e)).toList().cast<D>();
      } else {
        data = deserialize!(json['data']) as T;
      }
    }
  }

  Map<String, dynamic> toJson(T serialize(dynamic e)) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['description'] = this.description;
    data['data'] = serialize(data);
    return data;
  }

  ResponseRes.successDataResponse() {
    success = true;
    description = '';
    data = null;
  }

  ResponseRes.noDataResponse() {
    success = false;
    description = '';
    data = null;
  }
}
