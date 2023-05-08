import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/User/UserModel.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/AnimateLoading.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Setting/Role/AddRole.dart';
import 'package:stm_report_app/Widget/Setting/User/UserView.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  void initState() {
    // TODO: implement initState
    InitData = initData();
    super.initState();
  }

  //Instance
  Future<List<UserModel>>? InitData;

  Future<List<UserModel>> initData() async {
    var res = await Singleton.instance.apiExtension
        .get<List<UserModel>, UserModel>(
            context: context,
            loading: false,
            baseUrl: ApiEndPoint.user,
            deserialize: (e) => UserModel.fromJson(e));
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

  void onClickView(UserModel userModel) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserView(userModel: userModel),
      ),
    );
    if (result != null && result) {
      InitData = initData();
      setState(() {});
    }
  }

  void onClickDelete(int id) async {
    var prompt = await PopupDialog.yesNoPrompt(context);
    if (prompt) {
      var body = UserModel(id: id, methodType: "delete").toJson();
      var res = await Singleton.instance.apiExtension.post<String, String>(
        context: context,
        loading: true,
        deserialize: (e) => e.toString(),
        baseUrl: ApiEndPoint.user,
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
        child: FutureBuilder<List<UserModel>>(
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
                                'Label.FullName'.tr(),
                                style: StyleColor.textStyleKhmerDangrekAuto(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Hint.Org'.tr(),
                                style: StyleColor.textStyleKhmerDangrekAuto(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
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
                                // onClickView(snapshot.data![index]);
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
                                      width: 40,
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
                                        snapshot.data![index].fullNameKh,
                                        style: StyleColor
                                            .textStyleKhmerContentAuto(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        snapshot.data![index].org ?? "",
                                        style: StyleColor
                                            .textStyleKhmerContentAuto(
                                          fontSize: 16,
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
                                          // onClickDelete(
                                          //     snapshot.data![index].iD!);
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
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: Singleton.instance.largeScreenWidthConstraint,
        ),
        padding: EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: FutureBuilder<List<UserModel>>(
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
                                  'Label.FullName'.tr(),
                                  style: StyleColor.textStyleKhmerDangrekAuto(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Hint.Org'.tr(),
                                  style: StyleColor.textStyleKhmerDangrekAuto(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
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
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Container(
                                  height: 50,
                                  child: TextButton(
                                    onPressed: () {
                                      onClickView(snapshot.data![index]);
                                    },
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        backgroundColor: (index % 2) == 0
                                            ? StyleColor.blueLighterOpa01
                                            : StyleColor.appBarColorOpa01),
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
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
                                              snapshot.data![index].fullNameKh,
                                              style: StyleColor
                                                  .textStyleKhmerContentAuto(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              snapshot.data![index].org ?? "",
                                              style: StyleColor
                                                  .textStyleKhmerContentAuto(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 30,
                                            child: Extension
                                                        .getPermissionByActivity(
                                                            activiyName: "User",
                                                            activityEn: true)
                                                    .DELETE
                                                ? IconButton(
                                                    padding: EdgeInsets.zero,
                                                    icon: Icon(
                                                      Icons.clear,
                                                      color: StyleColor
                                                          .appBarColor,
                                                    ),
                                                    onPressed: () {
                                                      onClickDelete(snapshot
                                                          .data![index].id!);
                                                    },
                                                  )
                                                : Container(),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleColor.appBarColor,
        title: Text(
          'Navigation.Users'.tr(),
          style: StyleColor.textStyleKhmerDangrekAuto(
              fontSize: 18, color: Colors.white),
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: onClickAdd,
      //   backgroundColor: StyleColor.appBarColor,
      //   child: Icon(Icons.add),
      // ),
      body: Extension.getDeviceType() == DeviceType.PHONE
          ? screenPhone()
          : screenPhone(),
    );
  }
}
