import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Entity/Zone/ZoneModel.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Setting/Zone/Edit/ZoneEdit.dart';

// ignore: must_be_immutable
class ZoneView extends StatefulWidget {
  ZoneModel zoneModel;
  ZoneView({Key? key, required this.zoneModel}) : super(key: key);

  @override
  State<ZoneView> createState() => _ZoneViewState();
}

class _ZoneViewState extends State<ZoneView> {
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
          actions: [
            () {
              if (Extension.getPermissionByActivity(
                      activiyName: "Zone", activityEn: true)
                  .UPDATE) {
                return InkWell(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ZoneEdit(
                          zoneModel: widget.zoneModel,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Label.Edit'.tr(),
                          style: StyleColor.textStyleKhmerContent14White,
                        )
                      ],
                    ),
                  ),
                );
              } else
                return Container();
            }()
          ],
        ),
        body: SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: Singleton.instance.largeScreenWidthConstraint,
              ),
              child: ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: false,
                children: [
                  //Panel
                  Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: StyleColor.appBarColor, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //Code
                        Container(
                          padding: EdgeInsets.all(10),
                          color: StyleColor.blueLighterOpa01,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text('Label.Code'.tr(),
                                        style: StyleColor
                                            .textStyleKhmerContent14Grey)),
                              ),
                              Expanded(
                                child: Container(
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text(
                                        widget.zoneModel.code.toString(),
                                        style:
                                            StyleColor.textStyleKhmerContent)),
                              ),
                            ],
                          ),
                        ),
                        //Zone Name
                        Container(
                          padding: EdgeInsets.all(10),
                          color: StyleColor.appBarColorOpa01,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text('ឈ្មោះទីតាំង'.tr(),
                                        style: StyleColor
                                            .textStyleKhmerContent14Grey)),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    widget.zoneModel.name ?? "",
                                    style: TextStyle(
                                        fontFamily: 'Khmer OS Content',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text('Label.Description'.tr(),
                                        style: StyleColor
                                            .textStyleKhmerContent14Grey)),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    widget.zoneModel.description ?? "",
                                    style: TextStyle(
                                        fontFamily: 'Khmer OS Content',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
