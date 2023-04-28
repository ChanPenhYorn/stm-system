import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stm_report_app/Extension/AppRoute.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Extension/ExtensionComponent.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Authentication/Login.dart';
import 'package:stm_report_app/Widget/Home/DrawerHome.dart';
import 'package:stm_report_app/Widget/Photo/PhotoViewSlideOut.dart';
import 'package:stm_report_app/Widget/Report/STM/STMReport.dart';
import 'package:stm_report_app/Widget/Setting/User/UserProfileView.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Extension.getDeviceType() == DeviceType.PHONE
          ? AppBar(
              title: Text(
                'STM Report',
                style: StyleColor.textStyleDefaultAuto(
                    fontSize: 18, bold: true, color: Colors.white),
              ),
            )
          : null,
      drawer: () {
        print(Extension.getDeviceType());
        if (Extension.getDeviceType() == DeviceType.PHONE)
          return Container(
            width: 300,
            // width: MediaQuery.of(context).size.width * 0.2,
            // constraints: BoxConstraints(maxWidth: 300, minWidth: 200),
            color: StyleColor.appBarColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: DrawerHome(),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                      bottom: 10,
                      right: 10,
                    ),
                    child: Text(
                      'ជំនាន់៖ V${Singleton.instance.appVersion.appVersion}',
                      textAlign: TextAlign.right,
                      // '',
                      style: StyleColor.textStyleKhmerContentAuto(
                          fontSize: 12, color: Colors.grey.shade300),
                    ),
                  ),
                )
              ],
            ),
          );
        else
          return Container();
      }(),
      body: Row(
        children: [
          () {
            if (Extension.getDeviceType() == DeviceType.TABLET) {
              return Container(
                width: 300,
                // width: MediaQuery.of(context).size.width * 0.2,
                // constraints: BoxConstraints(maxWidth: 300, minWidth: 200),
                color: StyleColor.appBarColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: DrawerHome(),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          bottom: 10,
                          right: 10,
                        ),
                        child: Text(
                          'ជំនាន់៖ V${Singleton.instance.appVersion.appVersion}',
                          textAlign: TextAlign.right,
                          // '',
                          style: StyleColor.textStyleKhmerContentAuto(
                              fontSize: 12, color: Colors.grey.shade300),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else
              return Container();
          }(),
          Expanded(child: STMReport()),
        ],
      ),
    );
  }
}
