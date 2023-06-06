import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Extension/ReusableComponent.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import '../../Infrastructor/Singleton.dart';
import 'package:easy_localization/easy_localization.dart';

class AdminSetting extends StatefulWidget {
  AdminSetting({Key? key}) : super(key: key);

  @override
  _AdminSettingState createState() {
    return _AdminSettingState();
  }
}

class _AdminSettingState extends State<AdminSetting> {
  @override
  void initState() {
    if (Extension.getDeviceType() == DeviceType.PHONE)
      initButtonPhone();
    else
      initButtonPhone();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> listButton = <Widget>[];
  void initButtonPhone() {
    int range = Singleton.instance.token!.permission!.length;
    for (int i = 0; i < range; i++) {
      if (Singleton.instance.token!.permission![i].get == 1 &&
          Singleton.instance.token!.permission![i].located == "setting") {
        int indexInListButton =
            Singleton.instance.dashboardButton.indexWhere((d) => () {
                  return d.buttonTitle!.tr() ==
                      Singleton.instance.token!.permission![i].widgetKh;
                }());

        if (indexInListButton >= 0) {
          listButton.add(
            ReusableComponent.textButton(
              onPressed: () {
                Singleton
                    .instance.dashboardButton[indexInListButton].initFunc!();
                // Navigator.pushNamed(
                //     context,
                //     Singleton
                //         .instance.dashboardButton[indexInListButton].route!);
                context.push(Singleton
                    .instance.dashboardButton[indexInListButton].route!);
              },
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        Singleton
                            .instance.dashboardButton[indexInListButton].icon!,
                        // scale: 2,
                        width: 40, height: 40,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      Singleton.instance.dashboardButton[indexInListButton]
                          .buttonTitle!
                          .tr(),
                      style: StyleColor.textStyleKhmerDangrekAuto(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              context: context,
            ),
          );
        }
      }
    }
    int mod = listButton.length % getAxisCount();
    if (mod != 0) {
      var loopLength;
      var value1 = listButton.length + 1;
      if (value1 % getAxisCount() == 0)
        loopLength = 1;
      else {
        loopLength = 2;
      }
      for (int y = 0; y < loopLength; y++) {
        listButton.add(
          InkWell(
            child: Container(
              color: Colors.white,
            ),
          ),
        );
      }
    }
  }

  int getAxisCount() {
    return Extension.getDeviceType() == DeviceType.PHONE ? 3 : 8;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: StyleColor.appBarColor,
        title: Text(
          "AdminSetting.Setting".tr(),
          style: StyleColor.textStyleKhmerDangrek18,
        ),
      ),
      body: SafeArea(child: () {
        if (listButton.length > 0)
          return Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(colors: [
                StyleColor.appBarColor,
                Colors.white,
              ], radius: 0.7, focal: Alignment.center),
            ),
            child: GridView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: getAxisCount(),
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2),
              itemCount: listButton.length,
              itemBuilder: (context, index) {
                return listButton[index];
              },
            ),
          );
        else
          return PopupDialog.noResult();
      }()),
    );
  }
}
