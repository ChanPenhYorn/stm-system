import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/Role/RoleModel.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/AnimateLoading.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Setting/Role/AddRole.dart';
import 'package:stm_report_app/Widget/Setting/Role/RoleView.dart';

class Role extends StatefulWidget {
  const Role({Key? key}) : super(key: key);

  @override
  State<Role> createState() => _RoleState();
}

class _RoleState extends State<Role> {
  @override
  void initState() {
    // TODO: implement initState
    InitData = initData();
    super.initState();
  }

  //Instance
  Future<List<RoleModel>>? InitData;

  Future<List<RoleModel>> initData() async {
    var res = await Singleton.instance.apiExtension
        .get<List<RoleModel>, RoleModel>(
            context: context,
            loading: false,
            baseUrl: ApiEndPoint.role,
            deserialize: (e) => RoleModel.fromJson(e));
    if (res.success!)
      return res.data!;
    else
      return [];
  }

  void onClickAdd() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddRole(),
      ),
    );
    if (result != null && result) {
      InitData = initData();
      setState(() {});
    }
  }

  void onClickView(RoleModel roleModel) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RoleView(roleModel: roleModel),
      ),
    );
    if (result != null && result) {
      InitData = initData();
      setState(() {});
    }
  }

  void onClickDelete(String id) async {
    var prompt = await PopupDialog.yesNoPrompt(context);
    if (prompt) {
      var body = RoleModel(roleId: id, methodType: "delete").toJson();
      var res = await Singleton.instance.apiExtension
          .post<List<RoleModel>, RoleModel>(
        context: context,
        loading: true,
        deserialize: (e) => RoleModel.fromJson(e),
        baseUrl: ApiEndPoint.role,
        body: body,
      );
      if (res.success!) {
        InitData = initData();
        PopupDialog.showSuccess(context);
      } else {
        PopupDialog.showFailed(context);
      }
      setState(() {});
    }
  }

  Widget screenTablet() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: FutureBuilder<List<RoleModel>>(
            future: InitData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && snapshot.data!.length > 0)
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        color: Color.fromRGBO(148, 194, 193, 1),
                        height: 50,
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              child: Text(
                                'Label.No'.tr(),
                                style: StyleColor.textStyleKhmerDangrekAuto(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Label.RolePermissionName'.tr(),
                                style: StyleColor.textStyleKhmerDangrekAuto(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return TextButton(
                              onPressed: () {
                                onClickView(snapshot.data![index]);
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                backgroundColor: (index % 2) == 0
                                    ? Colors.white
                                    : Color.fromRGBO(171, 213, 211, 0.2),
                              ),
                              child: Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                height: 50,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 80,
                                      child: Text(
                                        (index + 1).toString(),
                                        style: StyleColor
                                            .textStyleKhmerDangrekAuto(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        snapshot.data![index].roleName!,
                                        style: StyleColor
                                            .textStyleKhmerContentAuto(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 50,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.clear,
                                          color: StyleColor.appBarColor,
                                        ),
                                        onPressed: () {
                                          onClickDelete(
                                              snapshot.data![index].roleId!);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  );
                return PopupDialog.noResult();
              }
              return AnimateLoading();
            }),
      ),
    );
  }

  Widget screenPhone() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: FutureBuilder<List<RoleModel>>(
            future: InitData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && snapshot.data!.length > 0)
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        color: StyleColor.appBarColor.withOpacity(0.8),
                        height: 50,
                        child: Row(
                          children: [
                            Container(
                              width: 80,
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
                                'Label.RolePermissionName'.tr(),
                                style: StyleColor.textStyleKhmerDangrekAuto(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Container(
                                height: 50,
                                child: TextButton(
                                  onPressed: () {
                                    onClickView(snapshot.data![index]);
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    backgroundColor: (index % 2) == 0
                                        ? StyleColor.blueLighter
                                            .withOpacity(0.1)
                                        : StyleColor.appBarColor
                                            .withOpacity(0.1),
                                  ),
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 80,
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
                                            snapshot.data![index].roleName!,
                                            style: StyleColor
                                                .textStyleKhmerContentAuto(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 50,
                                          child: IconButton(
                                            icon: Extension
                                                        .getPermissionByActivity(
                                                            activiyName: "Role",
                                                            activityEn: true)
                                                    .GET
                                                ? Icon(
                                                    Icons.clear,
                                                    color:
                                                        StyleColor.appBarColor,
                                                  )
                                                : Container(),
                                            onPressed: () {
                                              onClickDelete(snapshot
                                                  .data![index].roleId!);
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  );
                return PopupDialog.noResult();
              }
              return AnimateLoading();
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleColor.appBarColor,
        title: Text(
          'Navigation.RolePermission'.tr(),
          style: StyleColor.textStyleKhmerDangrekAuto(
              fontSize: 18, color: Colors.white),
        ),
      ),
      floatingActionButton: Extension.getPermissionByActivity(
                  activiyName: "Role", activityEn: true)
              .GET
          ? FloatingActionButton(
              onPressed: onClickAdd,
              backgroundColor: StyleColor.appBarColor,
              child: Icon(Icons.add),
            )
          : Container(),
      body: Extension.getDeviceType() == DeviceType.PHONE
          ? screenPhone()
          : screenPhone(),
    );
  }
}
