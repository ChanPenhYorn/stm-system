import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Api/Domain.dart';
import 'package:stm_report_app/Entity/Report/STMReportDetailModel.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Extension/ExtensionComponent.dart';
import 'package:stm_report_app/Extension/ExtensionMethod.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/AnimateLoading.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Photo/PhotoViewSlideOut.dart';
import 'package:stm_report_app/Widget/Report/STM/STMReportViewDialog.dart';

class STMReportDetail extends StatefulWidget {
  const STMReportDetail({Key? key}) : super(key: key);

  @override
  State<STMReportDetail> createState() => _STMReportDetailState();
}

class _STMReportDetailState extends State<STMReportDetail> {
  DateTime date = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    InitData = initData();
    super.initState();
  }

  String plateNumber = "";

  //Future
  Future<STMReportDetailModel> initData() async {
    var res = await Singleton.instance.apiExtension
        .get<STMReportDetailModel, STMReportDetailModel>(
      context: context,
      loading: false,
      param:
          "type=daily&date=${date.toYYYYMMDD()}&last_period=1&plate_number=${plateNumber}",
      baseUrl: ApiEndPoint.couponInvoiceList,
      deserialize: (e) => STMReportDetailModel.fromJson(e),
    );
    if (res.success!)
      return res.data!;
    else
      return Future.error(true);
    // return STMReportModel.fromJson(Extension.jsonSTMReport);
  }

  Future<STMReportDetailModel>? InitData;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  TextEditingController searchController = TextEditingController();
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
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Date Picker
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'របាយការណ៍ថ្ងៃ៖ ',
                  style: StyleColor.textStyleKhmerContentAuto(),
                ),
                //Arrow Left
                TextButton(
                  onPressed: () async {
                    date = date.subtract(Duration(days: 1));
                    InitData = initData();
                    setState(() {});
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    padding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 7, top: 7),
                    backgroundColor: StyleColor.appBarColor,
                  ),
                  child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      )),
                ),
                //Date
                TextButton(
                  onPressed: () async {
                    var res = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime.now().subtract(Duration(
                        days: 3650,
                      )),
                      lastDate: DateTime.now(),
                    );
                    if (res != null) {
                      date = res;
                      InitData = initData();
                      setState(() {});
                    }
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    padding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 7, top: 7),
                    backgroundColor: StyleColor.appBarColor,
                  ),
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      DateFormat('d MMMM', 'km').format(date) + " ${date.year}",
                      style: StyleColor.textStyleKhmerContentAuto(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                //Arrow Right
                TextButton(
                  onPressed: () async {
                    date = date.add(Duration(days: 1));
                    InitData = initData();
                    setState(() {});
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    padding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 7, top: 7),
                    backgroundColor: StyleColor.appBarColor,
                  ),
                  child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
            //Search
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextFormField(
                style: StyleColor.textStyleKhmerContent14,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                cursorColor: StyleColor.appBarColor,
                controller: searchController,
                onChanged: (text) {
                  plateNumber = text.trim();
                  InitData = initData();
                  setState(() {});
                },
                enableSuggestions: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 0, color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 0, color: Colors.grey.shade200),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 40,
                    minHeight: 5,
                  ),
                  suffixIconConstraints: BoxConstraints(
                    minWidth: 40,
                    minHeight: 5,
                  ),
                  suffixIcon: InkWell(
                      child: searchController.text.trim().length > 0
                          ? Icon(
                              Icons.clear,
                              color: StyleColor.appBarColor,
                            )
                          : SizedBox(),
                      onTap: () {
                        Extension.clearFocus(context);
                        searchController.clear();
                        plateNumber = "";
                        InitData = initData();
                        setState(() {});
                      }),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: 'ស្វែងរក (ផ្លាកលេខ)',
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: StyleColor.appBarColor.withOpacity(0.8),
                    ),
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
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 150,
                          child: Text(
                            "ផ្លាកលេខ",
                            style: StyleColor.textStyleKhmerDangrekAuto(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Text(
                            'ស្ថានីយចូល'.tr(),
                            style: StyleColor.textStyleKhmerDangrekAuto(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 100,
                          child: Text(
                            'ទម្ងន់ចូល(គក)'.tr(),
                            style: StyleColor.textStyleKhmerDangrekAuto(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            'ស្ថានីយចេញ'.tr(),
                            style: StyleColor.textStyleKhmerDangrekAuto(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 100,
                          child: Text(
                            'ទម្ងន់ចេញ(គក)'.tr(),
                            style: StyleColor.textStyleKhmerDangrekAuto(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            'ទម្ងន់ទំនិញ(គក)'.tr(),
                            style: StyleColor.textStyleKhmerDangrekAuto(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<STMReportDetailModel>(
                        future: InitData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData &&
                                snapshot.data!.data!.length > 0)
                              return Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: snapshot.data!.data!.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          height: 50,
                                          child: TextButton(
                                            onPressed: () async {
                                              showDialog(
                                                context: context,
                                                builder: (_) => Dialog(
                                                  child: STMReportViewDialog(
                                                      stmReportDataModel:
                                                          snapshot.data!
                                                              .data![index]),
                                                ),
                                              );
                                            },
                                            style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                backgroundColor:
                                                    (index % 2) == 0
                                                        ? StyleColor
                                                            .blueLighterOpa01
                                                        : StyleColor
                                                            .appBarColorOpa01),
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
                                                  Container(
                                                    width: 80,
                                                    height: 50,
                                                    child: InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                          useSafeArea: false,
                                                          context: context,
                                                          builder: (_) =>
                                                              PhotoViewSlideOut(
                                                            url: snapshot
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .couponIn!
                                                                    .plateFrontUrl! ??
                                                                "",
                                                          ),
                                                        );
                                                      },
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        child: Container(
                                                          color: Color.fromRGBO(
                                                              192,
                                                              192,
                                                              192,
                                                              0.2),
                                                          child: ExtensionComponent
                                                              .cachedNetworkImage(
                                                            url: snapshot
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .couponIn!
                                                                    .plateFrontUrl! ??
                                                                "",
                                                            profile: true,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    width: 70,
                                                    child: Text(
                                                      snapshot
                                                              .data!
                                                              .data![index]
                                                              .frontPlateObj!
                                                              .nameKh! +
                                                          "\n" +
                                                          snapshot
                                                              .data!
                                                              .data![index]
                                                              .frontPlateObj!
                                                              .plateNumberFormatted!,
                                                      style: StyleColor
                                                          .textStyleKhmerContentAuto(
                                                        fontSize: 14,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      snapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .stationInId !=
                                                              null
                                                          ? snapshot
                                                              .data!
                                                              .data![index]
                                                              .stationInId!
                                                          : "",
                                                      style: StyleColor
                                                          .textStyleKhmerContentAuto(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    width: 100,
                                                    child: Text(
                                                      snapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .weightIn !=
                                                              null
                                                          ? snapshot
                                                              .data!
                                                              .data![index]
                                                              .weightIn!
                                                              .toNumberFormat()
                                                          : "",
                                                      style: StyleColor
                                                          .textStyleKhmerContentAuto(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      snapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .stationOutId !=
                                                              null
                                                          ? snapshot
                                                              .data!
                                                              .data![index]
                                                              .stationOutId
                                                              .toString()
                                                          : "",
                                                      style: StyleColor
                                                          .textStyleKhmerContentAuto(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    width: 100,
                                                    child: Text(
                                                      snapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .weightOut !=
                                                              null
                                                          ? snapshot
                                                              .data!
                                                              .data![index]
                                                              .weightOut!
                                                              .toNumberFormat()
                                                          : "",
                                                      style: StyleColor
                                                          .textStyleKhmerContentAuto(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      snapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .weightProduct !=
                                                              null
                                                          ? snapshot
                                                              .data!
                                                              .data![index]
                                                              .weightProduct!
                                                              .toNumberFormat()
                                                          : "",
                                                      style: StyleColor
                                                          .textStyleKhmerContentAuto(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: StyleColor.appBarColor
                                          .withOpacity(0.6),
                                    ),
                                    height: 50,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          child: Text(
                                            'សរុប'.tr(),
                                            style: StyleColor
                                                .textStyleKhmerDangrekAuto(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          child: Text(
                                            snapshot.data!.data!.length
                                                .toString(),
                                            style: StyleColor
                                                .textStyleKhmerDangrekAuto(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(),
                                        ),
                                        Container(
                                          width: 100,
                                          child: Text(
                                            () {
                                              int total = 0;
                                              total = snapshot.data!.data!
                                                  .map((e) => e.weightIn ?? 0)
                                                  .reduce((value, element) =>
                                                      value + element);
                                              return total.toNumberFormat();
                                            }(),
                                            style: StyleColor
                                                .textStyleKhmerDangrekAuto(
                                              fontSize: 14,
                                              color: Colors.white,
                                              bold: true,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(),
                                        ),
                                        Container(
                                          width: 100,
                                          child: Text(
                                            () {
                                              int total = 0;
                                              total = snapshot.data!.data!
                                                  .map((e) => e.weightOut ?? 0)
                                                  .reduce((value, element) =>
                                                      value + element);
                                              return total.toNumberFormat();
                                            }(),
                                            style: StyleColor
                                                .textStyleKhmerDangrekAuto(
                                              fontSize: 14,
                                              color: Colors.white,
                                              bold: true,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            () {
                                              int total = 0;
                                              total = snapshot.data!.data!
                                                  .map((e) =>
                                                      e.weightProduct ?? 0)
                                                  .reduce((value, element) =>
                                                      value + element);
                                              return total.toNumberFormat();
                                            }(),
                                            style: StyleColor
                                                .textStyleKhmerDangrekAuto(
                                              fontSize: 14,
                                              color: Colors.white,
                                              bold: true,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            return PopupDialog.noResult();
                          }
                          return AnimateLoading();
                          return Container();
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
