import 'package:flutter/material.dart';

class DashboardButton {
  DashboardButton(
      {this.context,
      this.id,
      this.buttonTitle,
      this.buttonDesc,
      this.icon,
      this.route,
      this.initFunc});
  BuildContext? context;
  int? id;
  String? buttonTitle;
  String? buttonDesc;
  String? icon;
  String? route;
  Function? initFunc;
}
