import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/Zone/ZoneModel.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';

class ZoneEdit extends StatefulWidget {
  final ZoneModel zoneModel;
  ZoneEdit({Key? key, required this.zoneModel}) : super(key: key);

  @override
  State<ZoneEdit> createState() => _ZoneEditState();
}

class _ZoneEditState extends State<ZoneEdit> {
  @override
  void initState() {
    // TODO: implement initState
    zoneNameCon.text = widget.zoneModel.name!;
    descriptionCon.text = widget.zoneModel.description!;
    super.initState();
  }

  TextEditingController zoneNameCon = TextEditingController();
  TextEditingController descriptionCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  onClickSubmit() async {
    bool available = _formKey.currentState!.validate();
    if (available) {
      var prompt = await PopupDialog.yesNoPrompt(context);
      if (prompt) {
        var body = ZoneModel(
          code: widget.zoneModel.code!,
          name: zoneNameCon.text.trim(),
          description: descriptionCon.text.trim(),
        ).toJson();
        var res = await Singleton.instance.apiExtension.post<String, String>(
            context: context,
            loading: true,
            baseUrl: ApiEndPoint.zoneUpdate,
            body: body,
            deserialize: (e) => e.toString());
        if (res.success!) {
          await PopupDialog.showSuccess(context, data: true, layerContext: 2);
        } else
          PopupDialog.showFailed(context, data: false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Extension.clearFocus(context);
        Singleton.instance.handleUserInteraction(context);
      },
      onPanDown: (_) {
        Singleton.instance.handleUserInteraction(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Navigation.Zone'.tr(),
            style: StyleColor.textStyleKhmerDangrekAuto(
                fontSize: 18, color: Colors.white),
          ),
          backgroundColor: StyleColor.appBarColor,
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: Singleton.instance.largeScreenWidthConstraint,
            ),
            alignment: Alignment.topCenter,
            child: Form(
              key: _formKey,
              child: ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Text(
                    'Navigation.ZoneEntity.Info'.tr(),
                    style: StyleColor.textStyleKhmerDangrekAuto(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  //Panel
                  Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: StyleColor.appBarColor.withOpacity(0.5),
                          width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //Zone Name
                        Container(
                          padding: EdgeInsets.all(10),
                          color: StyleColor.blueLighterOpa01,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text('ឈ្មោះតំបន់'.tr(),
                                        style: StyleColor
                                            .textStyleKhmerContent14Grey)),
                              ),
                              Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Message.PleaseInputCorrectly"
                                          .tr();
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: StyleColor.textStyleKhmerContent,
                                  controller: zoneNameCon,
                                  decoration: InputDecoration(
                                    errorStyle:
                                        StyleColor.textStyleKhmerContent12Red,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: StyleColor.appBarColor),
                                    ),
                                    hintStyle:
                                        StyleColor.textStyleKhmerDangrekAuto(
                                            color: Colors.grey),
                                    hintText: 'ឈ្មោះតំបន់'.tr(),
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        left: 10,
                                        top: 13,
                                        right: 10,
                                        bottom: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Description
                        Container(
                          padding: EdgeInsets.all(10),
                          color: StyleColor.blueLighterOpa01,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text('បរិយាយ'.tr(),
                                        style: StyleColor
                                            .textStyleKhmerContent14Grey)),
                              ),
                              Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Message.PleaseInputCorrectly"
                                          .tr();
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: StyleColor.textStyleKhmerContent,
                                  controller: descriptionCon,
                                  decoration: InputDecoration(
                                    errorStyle:
                                        StyleColor.textStyleKhmerContent12Red,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: StyleColor.appBarColor),
                                    ),
                                    hintStyle:
                                        StyleColor.textStyleKhmerDangrekAuto(
                                            color: Colors.grey),
                                    hintText: 'បរិយាយ'.tr(),
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        left: 10,
                                        top: 13,
                                        right: 10,
                                        bottom: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Button
                  Column(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          backgroundColor: StyleColor.appBarColor,
                          splashFactory: InkRipple.splashFactory,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Container(
                          height: 50,
                          width: 150,
                          alignment: Alignment.center,
                          child: Text(
                            'Button.Submit'.tr(),
                            style: StyleColor.textStyleKhmerDangrekAuto(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                        onPressed: onClickSubmit,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
