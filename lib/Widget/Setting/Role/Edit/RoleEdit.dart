import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/Role/ActivityModel.dart';
import 'package:stm_report_app/Entity/Role/ActivtyCheckBoxModel.dart';
import 'package:stm_report_app/Entity/Role/Post/RolePostModel.dart';
import 'package:stm_report_app/Entity/Role/RoleModel.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/AnimateLoading.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';

class RoleEdit extends StatefulWidget {
  final RoleModel roleModel;
  const RoleEdit({Key? key, required this.roleModel}) : super(key: key);

  @override
  State<RoleEdit> createState() => _RoleEditState();
}

class _RoleEditState extends State<RoleEdit> {
  @override
  void initState() {
    // TODO: implement initState
    initData();
    roleNameCon.text = widget.roleModel.roleName ?? "";
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController roleNameCon = TextEditingController();
  List<ActivityCheckBoxModel> listCheckBox = [];
  List<ActivityModel> listActivityModel = [];
  Future<List<ActivityModel>>? InitActivity;

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
          if (listCheckBox[i].GET == false &&
              listCheckBox[i].UPDATE == false &&
              listCheckBox[i].DELETE == false) continue;
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
          methodType: "update",
          roleid: widget.roleModel.roleId,
          rolename: roleNameCon.text.trim(),
          activities: listActivities,
        ).toJson();
        print(body);
        var res =
            await Singleton.instance.apiExtension.post<RoleModel, RoleModel>(
          context: context,
          loading: true,
          deserialize: (e) => RoleModel.fromJson(e),
          baseUrl: ApiEndPoint.role,
          body: body,
        );
        if (res.success!) {
          PopupDialog.showSuccess(context, layerContext: 3, data: true);
        } else {
          PopupDialog.showFailed(context, data: false);
        }
      }
    }
  }

  void initCheckBox(List<ActivityModel> list) {
    list.forEach(
      (element) {
        var activity = widget.roleModel.activity!
                .where((element1) => element1.widgetName == element.widgetName)
                .isNotEmpty
            ? widget.roleModel.activity!
                .where((element1) => element1.widgetName == element.widgetName)
                .single
            : ActivityModel(get: "0", update: "0", delete: "0");
        listCheckBox.add(
          ActivityCheckBoxModel(
            GET: activity.get == "1" ? true : false,
            UPDATE: activity.update == "1" ? true : false,
            DELETE: activity.delete == "1" ? true : false,
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

  void onClickActivity({required int index}) {
    bool GET = listCheckBox[index].GET!;
    bool UPDATE = listCheckBox[index].UPDATE!;
    bool DELETE = listCheckBox[index].DELETE!;
    if (GET && UPDATE && DELETE) {
      listCheckBox[index].GET = false;
      listCheckBox[index].UPDATE = false;
      listCheckBox[index].DELETE = false;
    } else {
      listCheckBox[index].GET = true;
      listCheckBox[index].UPDATE = true;
      listCheckBox[index].DELETE = true;
    }
    setState(() {});
  }

  Future<List<ActivityModel>> initActivity() async {
    var res = await Singleton.instance.apiExtension
        .get<List<ActivityModel>, ActivityModel>(
            context: context,
            loading: false,
            baseUrl: ApiEndPoint.activity,
            deserialize: (e) => ActivityModel.fromJson(e));
    if (res.success!) {
      initCheckBox(res.data!);
      listActivityModel = res.data!;
      return res.data!;
    } else
      return [];
  }

  void initData() async {
    InitActivity = initActivity();
  }

  Widget getCheckBox({required int checkBoxIndex}) {
    return Row(
      children: [
        SizedBox(
          height: 30,
          width: 35,
          child: Checkbox(
            activeColor: StyleColor.appBarColor,
            value: listCheckBox[checkBoxIndex].GET,
            onChanged: (value) {
              setState(() {
                listCheckBox[checkBoxIndex].GET = value;
              });
            },
          ),
        ),
        SizedBox(
          height: 30,
          width: 35,
          child: Checkbox(
            activeColor: StyleColor.appBarColor,
            value: listCheckBox[checkBoxIndex].UPDATE,
            onChanged: (value) {
              setState(() {
                listCheckBox[checkBoxIndex].UPDATE = value;
              });
            },
          ),
        ),
        SizedBox(
          height: 30,
          width: 35,
          child: Checkbox(
            activeColor: StyleColor.appBarColor,
            value: listCheckBox[checkBoxIndex].DELETE,
            onChanged: (value) {
              setState(() {
                listCheckBox[checkBoxIndex].DELETE = value;
              });
            },
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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: StyleColor.appBarColor,
          title: Text(
            'Role.EditRolePermission'.tr(),
            style: StyleColor.textStyleKhmerDangrekAuto(
                fontSize: 18, color: Colors.white),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: roleNameCon,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Message.RoleUser.PleaseAddRoleUser'.tr();
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    errorStyle: StyleColor.textStyleKhmerContent14,
                    labelText: 'Role.RolePermissionName'.tr(),
                    prefixIcon: Icon(
                      Icons.key,
                      color: StyleColor.appBarColor,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          10,
                        ),
                      ),
                    ),
                    contentPadding: EdgeInsets.only(
                      left: 10,
                      top: 13,
                      right: 10,
                      bottom: 15,
                    ),
                  ),
                  style: StyleColor.textStyleKhmerContentAuto(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),

                //List View
                Expanded(
                    child: FutureBuilder<List<ActivityModel>>(
                  future: InitActivity,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data!.isNotEmpty)
                        return Column(
                          children: [
                            //Check All
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 30,
                                    width: 35,
                                    child: Checkbox(
                                      activeColor: StyleColor.appBarColor,
                                      value: getCheckAllStatus(GET: true),
                                      onChanged: (value) {
                                        onClickCheckAll(GET: true);
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 35,
                                    child: Checkbox(
                                      activeColor: StyleColor.appBarColor,
                                      value: getCheckAllStatus(UPDATE: true),
                                      onChanged: (value) {
                                        onClickCheckAll(UPDATE: true);
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 35,
                                    child: Checkbox(
                                      activeColor: StyleColor.appBarColor,
                                      value: getCheckAllStatus(DELETE: true),
                                      onChanged: (value) {
                                        onClickCheckAll(DELETE: true);
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //Title
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 40,
                                    child: Text(
                                      'ល.រ',
                                      style:
                                          StyleColor.textStyleKhmerDangrekAuto(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'ឈ្មោះសិទ្ធ',
                                      style:
                                          StyleColor.textStyleKhmerDangrekAuto(
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
                                          'មើល',
                                          style: StyleColor
                                              .textStyleKhmerDangrekAuto(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 35,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'កែ',
                                          style: StyleColor
                                              .textStyleKhmerDangrekAuto(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 35,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'លុប',
                                          style: StyleColor
                                              .textStyleKhmerDangrekAuto(
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
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      onClickActivity(index: index);
                                    },
                                    child: Container(
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
                                                snapshot
                                                    .data![index].widgetNameKh!,
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
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      else
                        return PopupDialog.noResult();
                    }
                    return AnimateLoading();
                  },
                )),
                //Button
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
