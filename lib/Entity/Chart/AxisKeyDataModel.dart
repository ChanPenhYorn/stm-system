import 'dart:ui';

import 'package:stm_report_app/Enum/ChartTypeEnum.dart';
import 'package:stm_report_app/Enum/ValueDataTypeEnum.dart';

class AxisKeyDataModel {
  String? label;
  String? data;
  VALUE_DATA_TYPE? datatype;
  Color? colorRgb;
  Color? trendLineColorRgb;
  String? colorRgbString;
  CHART_TYPE_ENUM? chartType;

  AxisKeyDataModel({
    this.label,
    this.data,
    this.colorRgb,
    this.datatype,
    this.trendLineColorRgb,
    this.chartType,
  });

  AxisKeyDataModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    data = json['data'];
    colorRgbString = json['color-rgb'];
    var colorObj = json['color-rgb'].toString().split(",");
    colorRgb = Color.fromRGBO(
      int.parse(colorObj[0]),
      int.parse(colorObj[1]),
      int.parse(colorObj[2]),
      1,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['data'] = this.data;
    data['color-rgb'] = this.colorRgb;
    return data;
  }
}
