import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/Role/ActivityModel.dart';
import 'package:stm_report_app/Entity/Role/ActivtyCheckBoxModel.dart';
import 'package:stm_report_app/Entity/Role/Post/RolePostModel.dart';
import 'package:stm_report_app/Entity/Role/RoleModel.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Setting/Role/Edit/RoleEdit.dart';

class RoleView extends StatefulWidget {
  RoleModel roleModel;
  RoleView({Key? key, required this.roleModel}) : super(key: key);

  @override
  State<RoleView> createState() => _RoleViewState();
}

class _RoleViewState extends State<RoleView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController roleNameCon = TextEditingController();
  List<ActivityCheckBoxModel> listCheckBox = [];
  List<ActivityModel> listActivityModel = [];

  void onClickSubmit() async {
    Extension.clearFocus(context);
    var result = _formKey.currentState!.validate();
    var isSelectRow = listCheckBox
        .where((element) =>
            element.GET == true ||
            element.UPDATE == true ||
            element.DELETE == true)
        .isNotEmpty;
    if (!isSelectRow) {
      await PopupDialog.showPopup(
          context, "Message.RoleUser.PleaseSelectRoleUser".tr(),
          success: 2);
    } else if (result) {
      var prompt = await PopupDialog.yesNoPrompt(context);
      if (prompt) {
        List<Activities> listActivities = [];
        for (int i = 0; i < listCheckBox.length; i++) {
          listActivities.add(
            Activities(
              id: listActivityModel[i].id!,
              get: listCheckBox[i].GET == true ? 1 : 0,
              update: listCheckBox[i].UPDATE == true ? 1 : 0,
              delete: listCheckBox[i].DELETE == true ? 1 : 0,
            ),
          );
        }
        var body = RolePostModel(
          methodType: "create",
          rolename: roleNameCon.text.trim(),
          activities: listActivities,
        ).toJson();
        var res =
            await Singleton.instance.apiExtension.post<RoleModel, RoleModel>(
          context: context,
          loading: true,
          deserialize: (e) => RoleModel.fromJson(e),
          baseUrl: ApiEndPoint.role,
          body: body,
        );
        if (res.success!) {
          PopupDialog.showSuccess(context, layerContext: 2, data: true);
        }
      }
    }
  }

  void initCheckBox(List<ActivityModel> list) {
    list.forEach(
      (element) {
        listCheckBox.add(
          ActivityCheckBoxModel(
            GET: false,
            UPDATE: false,
            DELETE: false,
          ),
        );
      },
    );
  }

  void onClickCheckAll({
    bool GET = false,
    bool UPDATE = false,
    bool DELETE = false,
  }) {
    if (GET) {
      if (!getCheckAllStatus(GET: GET)) {
        listCheckBox.forEach((element) {
          element.GET = true;
        });
      } else {
        listCheckBox.forEach((element) {
          element.GET = false;
        });
      }
    } else if (UPDATE) {
      if (!getCheckAllStatus(UPDATE: UPDATE)) {
        listCheckBox.forEach((element) {
          element.UPDATE = true;
        });
      } else {
        listCheckBox.forEach((element) {
          element.UPDATE = false;
        });
      }
    } else if (DELETE) {
      if (!getCheckAllStatus(DELETE: DELETE)) {
        listCheckBox.forEach((element) {
          element.DELETE = true;
        });
      } else {
        listCheckBox.forEach((element) {
          element.DELETE = false;
        });
      }
    }
    setState(() {});
  }

  Widget getCheckBox({required int checkBoxIndex}) {
    return Row(
      children: [
        SizedBox(
          height: 30,
          width: 35,
          child: Checkbox(
            activeColor: StyleColor.appBarColor,
            value: widget.roleModel.activity![checkBoxIndex].get != null &&
                    widget.roleModel.activity![checkBoxIndex].get == "1"
                ? true
                : false,
            onChanged: (value) {},
          ),
        ),
        SizedBox(
          height: 30,
          width: 35,
          child: Checkbox(
            activeColor: StyleColor.appBarColor,
            value: widget.roleModel.activity![checkBoxIndex].update != null &&
                    widget.roleModel.activity![checkBoxIndex].update == "1"
                ? true
                : false,
            onChanged: (value) {},
          ),
        ),
        SizedBox(
          height: 30,
          width: 35,
          child: Checkbox(
            activeColor: StyleColor.appBarColor,
            value: widget.roleModel.activity![checkBoxIndex].delete != null &&
                    widget.roleModel.activity![checkBoxIndex].delete == "1"
                ? true
                : false,
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }

  bool getCheckAllStatus({
    bool GET = false,
    bool UPDATE = false,
    bool DELETE = false,
  }) {
    if (GET) {
      return listCheckBox.where((e) => e.GET == true).length ==
              listCheckBox.length
          ? true
          : false;
    } else if (UPDATE) {
      return listCheckBox.where((e) => e.UPDATE == true).length ==
              listCheckBox.length
          ? true
          : false;
    } else if (DELETE) {
      return listCheckBox.where((e) => e.DELETE == true).length ==
              listCheckBox.length
          ? true
          : false;
    }
    return false;
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
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(
                  child: Text(
                    'Navigation.Permission'.tr(),
                    style: StyleColor.textStyleKhmerDangrek16,
                  ),
                ),
                Tab(
                  child: Text(
                    'Navigation.Users'.tr(),
                    style: StyleColor.textStyleKhmerDangrek16,
                  ),
                ),
              ],
            ),
            backgroundColor: StyleColor.appBarColor,
            title: Text(
              'Navigation.RolePermission'.tr(),
              style: StyleColor.textStyleKhmerDangrekAuto(
                  fontSize: 18, color: Colors.white),
            ),
            actions: [
              () {
                if (Extension.getPermissionByActivity(
                        activiyName: "Role", activityEn: true)
                    .UPDATE) {
                  return InkWell(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RoleEdit(
                            roleModel: widget.roleModel,
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
          body: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: Singleton.instance.largeScreenWidthConstraint,
              ),
              child: TabBarView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        //Title
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Text(
                            widget.roleModel.roleName!,
                            style: StyleColor.textStyleKhmerDangrekAuto(
                                fontSize: 20),
                          ),
                        ),

                        //Title List
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: StyleColor.appBarColor.withOpacity(0.8),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                          ),
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 40,
                                child: Text(
                                  'ល.រ',
                                  style: StyleColor.textStyleKhmerDangrekAuto(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Label.RolePermissionName'.tr(),
                                  style: StyleColor.textStyleKhmerDangrekAuto(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 35,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Label.View'.tr(),
                                      style:
                                          StyleColor.textStyleKhmerDangrekAuto(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 35,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Label.Edit'.tr(),
                                      style:
                                          StyleColor.textStyleKhmerDangrekAuto(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 35,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Label.Delete'.tr(),
                                      style:
                                          StyleColor.textStyleKhmerDangrekAuto(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        //Check List
                        Expanded(
                          child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            itemCount: widget.roleModel.activity!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 50,
                                child: Container(
                                  color: (index % 2) == 0
                                      ? StyleColor.blueLighterOpa01
                                      : StyleColor.appBarColorOpa01,
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        alignment: Alignment.center,
                                        child: Text(
                                          (index + 1).toString(),
                                          style: StyleColor
                                              .textStyleKhmerDangrekAuto(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          widget.roleModel.activity![index]
                                              .widgetNameKh!,
                                          style: StyleColor
                                              .textStyleKhmerContentAuto(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      getCheckBox(checkBoxIndex: index),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        //Title List
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: StyleColor.appBarColor.withOpacity(0.8),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                          ),
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 40,
                                child: Text(
                                  'Label.No'.tr(),
                                  style: StyleColor.textStyleKhmerDangrekAuto(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Navigation.Users'.tr(),
                                  style: StyleColor.textStyleKhmerDangrekAuto(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    'Hint.Org'.tr(),
                                    style: StyleColor.textStyleKhmerDangrekAuto(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    'Hint.Position'.tr(),
                                    style: StyleColor.textStyleKhmerDangrekAuto(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        //Check List
                        Expanded(
                          child: widget.roleModel.user!.length > 0
                              ? ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  itemCount: widget.roleModel.user!.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 50,
                                      child: Container(
                                        color: (index % 2) == 0
                                            ? StyleColor.blueLighter
                                                .withOpacity(0.1)
                                            : StyleColor.appBarColor
                                                .withOpacity(0.1),
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 40,
                                              child: Text(
                                                (index + 1).toString(),
                                                style: StyleColor
                                                    .textStyleKhmerDangrekAuto(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                widget.roleModel.user![index]
                                                    .fullNameKh,
                                                style: StyleColor
                                                    .textStyleKhmerContentAuto(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Text(
                                                  widget.roleModel.user![index]
                                                          .org ??
                                                      "Label.Unknown".tr(),
                                                  style: StyleColor
                                                      .textStyleKhmerContentAuto(),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Text(
                                                  widget.roleModel.user![index]
                                                          .position ??
                                                      "Label.Unknown".tr(),
                                                  style: StyleColor
                                                      .textStyleKhmerContentAuto(),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : PopupDialog.noResult(),
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
