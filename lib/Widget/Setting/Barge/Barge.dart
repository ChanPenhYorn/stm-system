import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/Barge/BargeModel.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/AnimateLoading.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Setting/Barge/AddBarge.dart';
import 'package:stm_report_app/Widget/Setting/Barge/BargeView.dart';

class Barge extends StatefulWidget {
  const Barge({Key? key}) : super(key: key);

  @override
  State<Barge> createState() => _BargeState();
}

class _BargeState extends State<Barge> {
  Future<List<BargeModel>> initData() async {
    var res = await Singleton.instance.apiExtension
        .get<List<BargeModel>, BargeModel>(
            context: context,
            loading: false,
            baseUrl: ApiEndPoint.bargeList,
            deserialize: (e) => BargeModel.fromJson(e));
    if (res.success!)
      return res.data!;
    else
      return [];
  }

  Future<List<BargeModel>>? InitData;

  void onClickAdd() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddBarge()),
    );
    if (result != null && result) {
      InitData = initData();
      setState(() {});
    }
  }

  void onClickView(BargeModel bargeModel) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BargeView(bargeModel: bargeModel),
      ),
    );
    if (result != null && result) {
      InitData = initData();
      setState(() {});
    }
  }

  void onClickDelete(String code) async {
    var prompt = await PopupDialog.yesNoPrompt(context);
    if (prompt) {
      var body = BargeModel(code: code).toJson();
      var res = await Singleton.instance.apiExtension.post<String, String>(
        context: context,
        loading: true,
        deserialize: (e) => e.toString(),
        baseUrl: ApiEndPoint.bargeDelete,
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

  @override
  void initState() {
    // TODO: implement initState
    InitData = initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Navigation.Barge'.tr(),
            style: StyleColor.textStyleKhmerDangrekAuto(
                fontSize: 18, color: Colors.white),
          ),
          backgroundColor: StyleColor.appBarColor),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: Singleton.instance.largeScreenWidthConstraint,
          ),
          padding: EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: FutureBuilder<List<BargeModel>>(
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
                                    'Label.Code'.tr(),
                                    style: StyleColor.textStyleKhmerDangrekAuto(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Navigation.Barge'.tr(),
                                    style: StyleColor.textStyleKhmerDangrekAuto(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Label.Description'.tr(),
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
                                                snapshot.data![index].code!,
                                                style: StyleColor
                                                    .textStyleKhmerContentAuto(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                snapshot.data![index].name ??
                                                    "",
                                                style: StyleColor
                                                    .textStyleKhmerContentAuto(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                snapshot.data![index]
                                                        .description ??
                                                    "",
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
                                                              activiyName:
                                                                  "Barge",
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
                                                            .data![index]
                                                            .code!);
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
      ),
      floatingActionButton: Extension.getPermissionByActivity(
                  activiyName: "Barge", activityEn: true)
              .GET
          ? FloatingActionButton(
              onPressed: onClickAdd,
              backgroundColor: StyleColor.appBarColor,
              child: Icon(Icons.add),
            )
          : Container(),
    );
  }
}
