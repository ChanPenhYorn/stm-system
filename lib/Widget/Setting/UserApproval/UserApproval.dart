import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/Role/RoleModel.dart';
import 'package:stm_report_app/Entity/User/UserModel.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/AnimateLoading.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Setting/Role/AddRole.dart';
import 'package:stm_report_app/Widget/Setting/UserApproval/UserApprovalView.dart';

class UserApproval extends StatefulWidget {
  const UserApproval({Key? key}) : super(key: key);

  @override
  State<UserApproval> createState() => _UserApprovalState();
}

class _UserApprovalState extends State<UserApproval> {
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
            baseUrl: ApiEndPoint.userApproval,
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
        builder: (_) => UserApprovalView(userModel: userModel),
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
      var res =
          await Singleton.instance.apiExtension.post<UserModel, UserModel>(
        context: context,
        loading: true,
        deserialize: (e) => UserModel.fromJson(e),
        baseUrl: ApiEndPoint.userPost,
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

  Widget screenPhone() {
    return Padding(
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
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            icon: Icon(
                                              Icons.clear,
                                              color: StyleColor.appBarColor,
                                            ),
                                            onPressed: () {
                                              onClickDelete(
                                                  snapshot.data![index].id!);
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
          'Label.Register'.tr(),
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
