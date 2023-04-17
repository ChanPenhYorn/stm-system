import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Style/StyleColor.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UserSetting.Setting'.tr(),
          style: StyleColor.textStyleKhmerDangrekAuto(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
