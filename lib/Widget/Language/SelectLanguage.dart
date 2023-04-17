import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/StyleColor.dart';

class SelectLanguage extends StatefulWidget {
  SelectLanguage({Key? key}) : super(key: key);

  @override
  _SelectLanguageState createState() {
    return _SelectLanguageState();
  }
}

class _SelectLanguageState extends State<SelectLanguage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int? val = Singleton.instance.selectedLanguage == 'km-KH' ? 0 : 1;

  void selectLanguage(int? value) async {
    Singleton.instance.selectedLanguage = value == 0 ? 'km-KH' : 'en-US';
    var res = await Singleton.instance.writeLocalStorage(
        'language_selected', Singleton.instance.selectedLanguage);
    if (res) {
      var split = Singleton.instance.selectedLanguage.split("-");
      EasyLocalization.of(context)!.setLocale(Locale(split[0], split[1]));
      setState(() {
        val = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: StyleColor.appBarColor,
          title: Text(
            "UserSetting.SelectLanguage".tr(),
            style: StyleColor.textStyleKhmerDangrek18,
          ),
        ),
        body: Column(
          children: [
            RadioListTile(
              groupValue: val,
              onChanged: (dynamic value) {
                selectLanguage(value);
              },
              controlAffinity: ListTileControlAffinity.trailing,
              title: Row(
                children: [
                  Image.asset(
                    'assets/image/flag/km-KH.png',
                    width: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'ភាសាខ្មែរ',
                    style: StyleColor.textStyleKhmerContent14,
                  ),
                ],
              ),
              value: 0,
            ),
            Divider(
              height: 0,
            ),
            RadioListTile(
              groupValue: val,
              onChanged: (dynamic value) {
                selectLanguage(value);
              },
              controlAffinity: ListTileControlAffinity.trailing,
              title: Row(
                children: [
                  Image.asset(
                    'assets/image/flag/en-US.png',
                    width: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'English',
                    style: StyleColor.textStyleKhmerContent14,
                  ),
                ],
              ),
              value: 1,
            )
          ],
        ));
  }
}
