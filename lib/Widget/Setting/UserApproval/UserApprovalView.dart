import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Entity/User/UserModel.dart';
import 'package:stm_report_app/Extension/ExtensionMethod.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Setting/UserApproval/UserApprovalViewEditing.dart';

class UserApprovalView extends StatefulWidget {
  UserModel userModel;
  UserApprovalView({Key? key, required this.userModel}) : super(key: key);

  @override
  State<UserApprovalView> createState() => _UserApprovalViewState();
}

class _UserApprovalViewState extends State<UserApprovalView> {
  onClickSubmit() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserApprovalViewEditing(
          userModel: widget.userModel,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userModel.toJson());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Label.Register'.tr(),
          style: StyleColor.textStyleKhmerDangrekAuto(
              fontSize: 18, color: Colors.white),
        ),
        backgroundColor: StyleColor.appBarColor,
      ),
      body: ListView(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Label.RegisterInfo'.tr(),
            style: StyleColor.textStyleKhmerDangrekAuto(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          //Panel
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(color: StyleColor.appBarColor, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
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
                                style: StyleColor.textStyleKhmerContent14Grey)),
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(widget.userModel.id.toString(),
                                style: StyleColor.textStyleKhmerContent)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  color: StyleColor.appBarColorOpa01,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text('Label.UserName'.tr(),
                                style: StyleColor.textStyleKhmerContent14Grey)),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            widget.userModel.username ?? "",
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
                Container(
                  padding: EdgeInsets.all(10),
                  color: StyleColor.blueLighterOpa01,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text('Label.FullName'.tr() + '៖',
                                style: StyleColor.textStyleKhmerContent14Grey)),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            widget.userModel.fullNameKh,
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
                Container(
                  padding: EdgeInsets.all(10),
                  color: StyleColor.appBarColorOpa01,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text('Label.FullNameEn'.tr(),
                                style: StyleColor.textStyleKhmerContent14Grey)),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            widget.userModel.fullNameEn,
                            style: TextStyle(
                              fontFamily: 'Khmer OS Content',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  color: StyleColor.blueLighterOpa01,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text('Label.Org'.tr() + '៖',
                                style: StyleColor.textStyleKhmerContent14Grey)),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            widget.userModel.org ?? "",
                            style: StyleColor.textStyleKhmerContentAuto(
                              bold: true,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  color: StyleColor.appBarColorOpa01,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text('Hint.Position'.tr() + '៖',
                                style: StyleColor.textStyleKhmerContent14Grey)),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            widget.userModel.position ?? "",
                            style: StyleColor.textStyleKhmerContentAuto(
                              bold: true,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  color: StyleColor.blueLighterOpa01,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text('Hint.PhoneNumber'.tr() + '៖',
                                style: StyleColor.textStyleKhmerContent14Grey)),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            widget.userModel.phoneNumber ?? "",
                            style: StyleColor.textStyleKhmerContentAuto(
                              bold: true,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  color: StyleColor.appBarColorOpa01,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text('Label.CodeDevice'.tr(),
                                style: StyleColor.textStyleKhmerContent14Grey)),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            widget.userModel.udid ?? "",
                            style: StyleColor.textStyleKhmerContentAuto(
                              bold: true,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  color: StyleColor.blueLighterOpa01,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text('Label.DateRegister'.tr(),
                                style: StyleColor.textStyleKhmerContent14Grey)),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            widget.userModel.createdTime == null
                                ? ""
                                : widget.userModel.createdTime!
                                    .toDateStandardMPWT(),
                            style: StyleColor.textStyleKhmerContentAuto(
                              bold: true,
                              fontSize: 14,
                            ),
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
          )
        ],
      ),
    );
  }
}
