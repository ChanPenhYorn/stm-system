import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/PriceList/PriceListModel.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Extension/ExtensionMethod.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/AnimateLoading.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/PriceList/AddPriceListDialog.dart';
import 'package:stm_report_app/Widget/PriceList/BasePrice/EditBasePriceDialog.dart';
import 'package:stm_report_app/Widget/PriceList/EditPriceListDialog.dart';
import 'package:stm_report_app/Widget/Setting/Role/AddRole.dart';
import 'package:stm_report_app/Widget/Setting/Role/RoleView.dart';

class PriceList extends StatefulWidget {
  const PriceList({Key? key}) : super(key: key);

  @override
  State<PriceList> createState() => _PriceListState();
}

class _PriceListState extends State<PriceList> {
  @override
  void initState() {
    // TODO: implement initState
    InitData = initData();
    super.initState();
  }

  //Instance
  Future<PriceListModel?>? InitData;
  DateTime date = DateTime.now();

  Future<PriceListModel?> initData() async {
    var res = await Singleton.instance.apiExtension
        .get<PriceListModel, PriceListModel>(
            context: context,
            loading: false,
            baseUrl: ApiEndPoint.priceList,
            param: "date=${date.toYYYYMMDD()}",
            deserialize: (e) => PriceListModel.fromJson(e));
    if (res.success!)
      return res.data!;
    else
      return null;
  }

  void onClickAdd() async {
    var result = await showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        insetPadding: EdgeInsets.all(20),
        child: AddPriceListDialog(),
      ),
    );
    if (result != null && result) {
      InitData = initData();
      setState(() {});
    }
  }

  void onClickView(PriceListModel roleModel) async {
    // var result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => RoleView(roleModel: roleModel),
    //   ),
    // );
    // if (result != null && result) {
    //   InitData = initData();
    //   setState(() {});
    // }
  }

  void onCLickUpdate(ListPrice price) async {
    var result = await showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        insetPadding: EdgeInsets.all(20),
        child: EditPriceListDialog(price: price),
      ),
    );
    if (result != null && result) {
      InitData = initData();
      setState(() {});
    }
  }

  void onClickDelete(String date) async {
    var prompt = await PopupDialog.yesNoPrompt(context);
    if (prompt) {
      var res = await Singleton.instance.apiExtension.delete<String, String>(
        context: context,
        loading: true,
        param: "date=${date}",
        deserialize: (e) => e.toString(),
        baseUrl: ApiEndPoint.priceDelete,
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

  void onCLickUpdateBasePrice(DefaultPrice price) async {
    var result = await showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        insetPadding: EdgeInsets.all(20),
        child: EditBasePriceDialog(price: price),
      ),
    );
    if (result != null && result) {
      InitData = initData();
      setState(() {});
    }
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
          child: Column(
            children: [
              //Date Picker
              Container(
                width: 200,
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Text(
                      'តារាងតម្លៃខែ៖ ',
                      style: StyleColor.textStyleKhmerContentAuto(),
                    ),
                    TextButton(
                      onPressed: () async {
                        var res = await showMonthPicker(
                          context: context,
                          initialDate: date,
                          firstDate:
                              DateTime.now().subtract(Duration(days: 365)),
                          lastDate: DateTime.now(),
                          locale: Locale("km"),
                        );
                        if (res != null) {
                          date = res;
                          InitData = initData();
                          setState(() {});
                        }
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.only(
                            left: 10, right: 10, bottom: 7, top: 7),
                        backgroundColor: StyleColor.appBarColor,
                      ),
                      child: Container(
                        height: 30,
                        alignment: Alignment.center,
                        child: Text(
                          DateFormat('MMMM', "km").format(date) +
                              " ${date.year}",
                          style: StyleColor.textStyleKhmerContentAuto(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //List View
              Expanded(
                child: FutureBuilder<PriceListModel?>(
                    future: InitData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData)
                          return Column(
                            children: [
                              //Base Price View
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: TextButton(
                                  onPressed: () {
                                    if (snapshot.data!.defaultPrice != null)
                                      onCLickUpdateBasePrice(
                                          snapshot.data!.defaultPrice!);
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 20,
                                        right: 20),
                                    backgroundColor: StyleColor.appBarColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'តម្លៃមូលដ្ឋាន',
                                          style: StyleColor
                                              .textStyleKhmerDangrekAuto(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                        ),
                                        Text(
                                          snapshot.data!.defaultPrice!.price!
                                              .toDollarCurrency(),
                                          style:
                                              StyleColor.textStyleDefaultAuto(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              //Daily Price
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
                                        style: StyleColor
                                            .textStyleKhmerDangrekAuto(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'កាលបរិច្ឆេទ'.tr(),
                                        style: StyleColor
                                            .textStyleKhmerDangrekAuto(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'តម្លៃ'.tr(),
                                        style: StyleColor
                                            .textStyleKhmerDangrekAuto(
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
                                child: snapshot.data!.listPrice!.length > 0
                                    ? ListView.builder(
                                        physics: ClampingScrollPhysics(),
                                        itemCount:
                                            snapshot.data!.listPrice!.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            child: Container(
                                              height: 50,
                                              child: TextButton(
                                                onPressed: () {
                                                  // onClickView(snapshot.data!.listPrice![index]);
                                                  onCLickUpdate(snapshot
                                                      .data!.listPrice![index]);
                                                },
                                                style: TextButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  backgroundColor:
                                                      (index % 2) == 0
                                                          ? StyleColor
                                                              .blueLighter
                                                              .withOpacity(0.1)
                                                          : StyleColor
                                                              .appBarColor
                                                              .withOpacity(0.1),
                                                ),
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 80,
                                                        child: Text(
                                                          (index + 1)
                                                              .toString(),
                                                          style: StyleColor
                                                              .textStyleKhmerDangrekAuto(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          snapshot
                                                              .data!
                                                              .listPrice![index]
                                                              .date!,
                                                          style: StyleColor
                                                              .textStyleKhmerContentAuto(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          snapshot
                                                              .data!
                                                              .listPrice![index]
                                                              .price!
                                                              .toDollarCurrency(),
                                                          style: StyleColor
                                                              .textStyleKhmerContentAuto(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 50,
                                                        child: IconButton(
                                                          icon: Extension.getPermissionByActivity(
                                                                      activiyName:
                                                                          "Price List",
                                                                      activityEn:
                                                                          true)
                                                                  .GET
                                                              ? Icon(
                                                                  Icons.clear,
                                                                  color: StyleColor
                                                                      .appBarColor,
                                                                )
                                                              : Container(),
                                                          onPressed: () {
                                                            onClickDelete(
                                                                snapshot
                                                                    .data!
                                                                    .listPrice![
                                                                        index]
                                                                    .date!);
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
                                      )
                                    : PopupDialog.noResult(),
                              )
                            ],
                          );
                        return PopupDialog.noResult();
                      }
                      return AnimateLoading();
                    }),
              ),
            ],
          ),
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
          'Navigation.PriceList'.tr(),
          style: StyleColor.textStyleKhmerDangrekAuto(
              fontSize: 18, color: Colors.white),
        ),
      ),
      floatingActionButton: Extension.getPermissionByActivity(
                  activiyName: "Price List", activityEn: true)
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
