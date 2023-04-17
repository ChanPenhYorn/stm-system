import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/Role/ActivtyCheckBoxModel.dart';
import 'package:stm_report_app/Entity/Role/RoleModel.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/AnimateLoading.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';

class RoleSelectionDialog extends StatefulWidget {
  const RoleSelectionDialog({Key? key}) : super(key: key);

  @override
  State<RoleSelectionDialog> createState() => _RoleSelectionDialogState();
}

class _RoleSelectionDialogState extends State<RoleSelectionDialog> {
  List<ActivityCheckBoxModel> listCheckBox = [];
  Future<List<RoleModel>>? InitData;
  Future<List<RoleModel>>? initData() async {
    var res = await Singleton.instance.apiExtension
        .get<List<RoleModel>, RoleModel>(
            context: context,
            loading: false,
            baseUrl: ApiEndPoint.role,
            deserialize: (e) => RoleModel.fromJson(e));
    if (res.success!) {
      initCheckBox(res.data!);
      return res.data!;
    } else
      return [];
  }

  Widget getCheckBox({required int checkBoxIndex}) {
    return SizedBox(
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
    );
  }

  void initCheckBox(List<RoleModel> list) {
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

  void onClickRole({required int index}) {
    bool GET = listCheckBox[index].GET!;
    if (GET) {
      listCheckBox[index].GET = false;
    } else {
      listCheckBox[index].GET = true;
    }
    setState(() {});
  }

  void onClickSubmit(List<RoleModel> listRole) {
    List<RoleModel> returnRole = [];
    for (int i = 0; i < listCheckBox.length; i++) {
      if (listCheckBox[i].GET!) {
        returnRole.add(listRole[i]);
      }
    }
    Navigator.pop(context, returnRole);
  }

  @override
  void initState() {
    // TODO: implement initState
    InitData = initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RoleModel>>(
      future: InitData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!.length > 0)
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Container(
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              onClickRole(index: index);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: (index % 2) == 0
                                  ? StyleColor.blueLighter.withOpacity(0.1)
                                  : StyleColor.appBarColor.withOpacity(0.1),
                            ),
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Container(
                                    width: 80,
                                    child: Text(
                                      (index + 1).toString(),
                                      style:
                                          StyleColor.textStyleKhmerDangrekAuto(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      snapshot.data![index].roleName!,
                                      style:
                                          StyleColor.textStyleKhmerContentAuto(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  getCheckBox(checkBoxIndex: index),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //Button
                  TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        backgroundColor:
                            StyleColor.appBarColor.withOpacity(0.8),
                        splashFactory: InkRipple.splashFactory,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Container(
                        height: 40,
                        width: 150,
                        alignment: Alignment.center,
                        child: Text(
                          'Button.Submit'.tr(),
                          style: StyleColor.textStyleKhmerDangrekAuto(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        onClickSubmit(snapshot.data!);
                      })
                ],
              ),
            );
          else
            return PopupDialog.noResult();
        }
        return Container(width: 100, height: 100, child: AnimateLoading());
      },
    );
  }
}
