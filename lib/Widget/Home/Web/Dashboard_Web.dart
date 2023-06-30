import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Home/DrawerHome.dart';
import 'package:stm_report_app/Widget/Report/STM/STMReport.dart';

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
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) {
        if (sizingInformation.isMobile) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'STM Report',
                style: StyleColor.textStyleDefaultAuto(
                    fontSize: 18, bold: true, color: Colors.white),
              ),
            ),
            drawer: Container(
              width: 250,
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
            ),
            body: STMReport(),
          );
        } else if (sizingInformation.isTablet) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'STM Report',
                style: StyleColor.textStyleDefaultAuto(
                    fontSize: 18, bold: true, color: Colors.white),
              ),
            ),
            drawer: Container(
              width: 250,
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
            ),
            body: STMReport(),
          );
        } else
          return Scaffold(
            body: Row(
              children: [
                Container(
                  width: 250,
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
                ),
                Expanded(child: STMReport()),
              ],
            ),
          );
      },
    );
  }
}
