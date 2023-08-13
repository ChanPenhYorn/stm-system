import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/Company/CompanyModel.dart';
import 'package:stm_report_app/Entity/Customer/CustomerModel.dart';
import 'package:stm_report_app/Entity/Report/STMReportDetailModel.dart';
import 'package:stm_report_app/Entity/Zone/ZoneModel.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Extension/ExtensionComponent.dart';
import 'package:stm_report_app/Extension/ExtensionMethod.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/AnimateLoading.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Dialog/DownloadCouponInvoiceBottomSheet.dart';
import 'package:stm_report_app/Widget/Photo/PhotoViewSlideOut.dart';
import 'package:stm_report_app/Widget/Report/STM/STMReportViewDialog.dart';

class STMReportDetail extends StatefulWidget {
  const STMReportDetail({Key? key}) : super(key: key);

  @override
  State<STMReportDetail> createState() => _STMReportDetailState();
}

class _STMReportDetailState extends State<STMReportDetail> {
  DateTime date = DateTime.now();

  late ScrollController scrollController1, scrollController2, scrollController3;
  @override
  void initState() {
    // TODO: implement initState
    InitCompany = initCompany();
    InitCustomer = initCustomer();
    InitZone = initZone();
    InitData = initData();
    super.initState();

    scrollController1 = ScrollController();
    scrollController2 = ScrollController();
    scrollController3 = ScrollController();

    scrollController1.addListener(() {
      scrollController2.animateTo(scrollController1.offset,
          duration: Duration(milliseconds: 300), curve: Curves.linear);
      scrollController3.animateTo(scrollController1.offset,
          duration: Duration(milliseconds: 300), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    scrollController1.dispose();
    scrollController2.dispose();
    scrollController3.dispose();

    super.dispose();
  }

  String plateNumber = "";
  //ListDropDown
  List<DropdownMenuItem<String>> listDropDownCompany =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> listDropDownCustomer =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> listDropDownZone =
      <DropdownMenuItem<String>>[];
  Future<STMReportDetailModel>? InitData;
  Future? InitCompany;
  Future? InitCustomer;
  Future? InitZone;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  TextEditingController searchController = TextEditingController();
  ScrollController conList = ScrollController();
  String? selectedCompanyCode;
  String? selectedCustomerCode;
  String? selectedZoneCode;

  //Future
  Future<STMReportDetailModel> initData() async {
    ///Init Company Drop Down
    var res = await Singleton.instance.apiExtension
        .get<STMReportDetailModel, STMReportDetailModel>(
      context: context,
      loading: false,
      param:
          "type=daily&date=${date.toYYYYMMDD()}&last_period=1&plate_number=${plateNumber}&company_codes=${selectedCompanyCode ?? ""}&customer_codes=${selectedCustomerCode ?? ""}&zone_codes=${selectedZoneCode ?? ""}",
      baseUrl: ApiEndPoint.couponInvoiceList,
      deserialize: (e) => STMReportDetailModel.fromJson(e),
    );
    if (res.success!)
      return res.data!;
    else
      return Future.error(true);
    // return STMReportModel.fromJson(Extension.jsonSTMReport);
  }

  Future? initCompany() async {
    var res = await Singleton.instance.apiExtension
        .get<List<CompanyModel>, CompanyModel>(
            context: context,
            loading: false,
            baseUrl: ApiEndPoint.companyList,
            deserialize: (e) => CompanyModel.fromJson(e));
    if (res.success!) {
      listDropDownCompany = res.data!
          .map(
            (m) => DropdownMenuItem(
              value: m.code,
              child: Text(
                m.name!,
                style: StyleColor.textStyleKhmerContent,
              ),
            ),
          )
          .toList();
      return res.data!;
    } else
      return [];
  }

  Future? initCustomer() async {
    var res = await Singleton.instance.apiExtension
        .get<List<CustomerModel>, CustomerModel>(
            context: context,
            loading: false,
            baseUrl: ApiEndPoint.customerList,
            deserialize: (e) => CustomerModel.fromJson(e));
    if (res.success!) {
      listDropDownCustomer = res.data!
          .map(
            (m) => DropdownMenuItem(
              value: m.code,
              child: Text(
                m.fullName!,
                style: StyleColor.textStyleKhmerContent,
              ),
            ),
          )
          .toList();
      return res.data!;
    } else
      return [];
  }

  Future? initZone() async {
    var res = await Singleton.instance.apiExtension
        .get<List<ZoneModel>, ZoneModel>(
            context: context,
            loading: false,
            baseUrl: ApiEndPoint.zoneList,
            deserialize: (e) => ZoneModel.fromJson(e));
    if (res.success!) {
      listDropDownZone = res.data!
          .map(
            (m) => DropdownMenuItem(
              value: m.code,
              child: Text(
                m.name!,
                style: StyleColor.textStyleKhmerContent,
              ),
            ),
          )
          .toList();
      return res.data!;
    } else
      return [];
  }

  String getPlateImageUrl(STMReportDetailDataModel data) {
    if (data.couponIn != null &&
        data.couponIn!.plateFrontUrl != "/uploads/default/no_plate.jpg") {
      return data.couponIn!.plateFrontUrl!;
    }
    // else if (data.couponIn != null &&
    //     data.couponIn!.plateBackUrl != "/uploads/default/no_plate.jpg") {
    //   return data.couponIn!.plateBackUrl!;
    // }
    else if (data.couponOut != null &&
        data.couponOut!.plateFrontUrl != "/uploads/default/no_plate.jpg") {
      return data.couponOut!.plateFrontUrl!;
    }
    // else if (data.couponOut != null &&
    //     data.couponOut!.plateBackUrl != "/uploads/default/no_plate.jpg") {
    //   return data.couponOut!.plateBackUrl!;
    // }
    return "";
  }

  void onDownloadCouponInvoiceRowClick(
      {required String pdf, required String excel}) {
    showModalBottomSheet(
      // context: Singleton.instance.graphContext!,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (_) {
        return DownloadCouponInvoiceBottomSheet(
          enableScreenshot: false,
          screenshotFunc: () {},
          filename: "report-daily" + "-" + date.toYYYYMMDD_NoDash(),
          date: date.toYYYYMMDD(),
          pdfUrl: pdf,
          excelUrl: excel,
          param:
              "type=daily&date=${date.toYYYYMMDD()}&last_period=1&plate_number=${plateNumber}&company_codes=${selectedCompanyCode ?? ""}&customer_codes=${selectedCustomerCode ?? ""}&zone_codes=${selectedZoneCode ?? ""}",
        );
      },
    );
  }

  void onClearCompanyCode() {
    selectedCompanyCode = null;
    InitData = initData();
    setState(() {});
  }

  void onClearCustomerCode() {
    selectedCustomerCode = null;
    InitData = initData();
    setState(() {});
  }

  void onClearZoneCode() {
    selectedZoneCode = null;
    InitData = initData();
    setState(() {});
  }

  Widget mobileScreen() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              //Header
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: StyleColor.appBarColor.withOpacity(0.8),
                ),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    Container(
                      width: 120,
                      child: Text(
                        'ស្ថានីយចូល'.tr(),
                        style: StyleColor.textStyleKhmerDangrekAuto(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: 120,
                      child: Text(
                        'ទម្ងន់ចូល(គក)'.tr(),
                        style: StyleColor.textStyleKhmerDangrekAuto(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: 120,
                      child: Text(
                        'ស្ថានីយចេញ'.tr(),
                        style: StyleColor.textStyleKhmerDangrekAuto(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: 120,
                      child: Text(
                        'ទម្ងន់ចេញ(គក)'.tr(),
                        style: StyleColor.textStyleKhmerDangrekAuto(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 100,
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
              Container(
                child: FutureBuilder<STMReportDetailModel>(
                    future: InitData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData && snapshot.data!.data!.length > 0)
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Panel
                              Container(
                                height: 400,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: snapshot.data!.data!.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin:
                                          EdgeInsets.only(top: 5, bottom: 5),
                                      height: 50,
                                      child: TextButton(
                                        onPressed: () async {
                                          showDialog(
                                            context: context,
                                            builder: (_) => Dialog(
                                              child: STMReportViewDialog(
                                                  stmReportDataModel: snapshot
                                                      .data!.data![index]),
                                            ),
                                          );
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
                                                              url: getPlateImageUrl(
                                                                  snapshot.data!
                                                                          .data![
                                                                      index])),
                                                    );
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    child: Container(
                                                      color: Color.fromRGBO(
                                                          192, 192, 192, 0.2),
                                                      child: ExtensionComponent
                                                          .cachedNetworkImage(
                                                        url: getPlateImageUrl(
                                                            snapshot.data!
                                                                .data![index]),
                                                        profile: true,
                                                      ),
                                                    ),
                                                  ),
                                                ),
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
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Container(
                                                width: 120,
                                                child: Text(
                                                  snapshot.data!.data![index]
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
                                              Container(
                                                width: 120,
                                                child: Text(
                                                  snapshot.data!.data![index]
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
                                              Container(
                                                width: 120,
                                                child: Text(
                                                  snapshot.data!.data![index]
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
                                              Container(
                                                width: 120,
                                                child: Text(
                                                  snapshot.data!.data![index]
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
                                              Text(
                                                snapshot.data!.data![index]
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
                              //Footer
                              Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color:
                                      StyleColor.appBarColor.withOpacity(0.6),
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
                                        snapshot.data!.data!.length.toString(),
                                        style: StyleColor
                                            .textStyleKhmerDangrekAuto(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 120,
                                    ),
                                    Container(
                                      width: 120,
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
                                    Container(
                                      width: 120,
                                    ),
                                    Container(
                                      width: 120,
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
                                    Container(
                                      width: 100,
                                      child: Text(
                                        () {
                                          int total = 0;
                                          total = snapshot.data!.data!
                                              .map((e) => e.weightProduct ?? 0)
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
        ),
      ),
    );
  }

  Widget tabletAndWebWidget() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: StyleColor.appBarColor.withOpacity(0.8),
            ),
            height: 50,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: scrollController1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  Container(
                    child: Text(
                      'ស្ថានីយចូល'.tr(),
                      style: StyleColor.textStyleKhmerDangrekAuto(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
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
                    width: 30,
                  ),
                  Container(
                    child: Text(
                      'ស្ថានីយចេញ'.tr(),
                      style: StyleColor.textStyleKhmerDangrekAuto(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
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
                  Container(
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
          ),
          Expanded(
            child: FutureBuilder<STMReportDetailModel>(
                future: InitData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data!.data!.length > 0)
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: snapshot.data!.data!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  height: 50,
                                  child: TextButton(
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        builder: (_) => Dialog(
                                          child: STMReportViewDialog(
                                              stmReportDataModel:
                                                  snapshot.data!.data![index]),
                                        ),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        backgroundColor: (index % 2) == 0
                                            ? StyleColor.blueLighterOpa01
                                            : StyleColor.appBarColorOpa01),
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        controller: scrollController2,
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
                                                      url: getPlateImageUrl(
                                                        snapshot
                                                            .data!.data![index],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Container(
                                                    color: Color.fromRGBO(
                                                        192, 192, 192, 0.2),
                                                    child: ExtensionComponent
                                                        .cachedNetworkImage(
                                                      url: getPlateImageUrl(
                                                          snapshot.data!
                                                              .data![index]),
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
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Container(
                                              child: Text(
                                                snapshot.data!.data![index]
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
                                                snapshot.data!.data![index]
                                                            .weightIn !=
                                                        null
                                                    ? snapshot.data!
                                                        .data![index].weightIn!
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
                                            Container(
                                              child: Text(
                                                snapshot.data!.data![index]
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
                                                snapshot.data!.data![index]
                                                            .weightOut !=
                                                        null
                                                    ? snapshot.data!
                                                        .data![index].weightOut!
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
                                            Container(
                                              child: Text(
                                                snapshot.data!.data![index]
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
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: StyleColor.appBarColor.withOpacity(0.6),
                            ),
                            height: 50,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: scrollController3,
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    child: Text(
                                      'សរុប'.tr(),
                                      style:
                                          StyleColor.textStyleKhmerDangrekAuto(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 170,
                                    child: Text(
                                      snapshot.data!.data!.length.toString(),
                                      style:
                                          StyleColor.textStyleKhmerDangrekAuto(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Container(
                                    width: 100,
                                    margin: EdgeInsets.only(left: 5),
                                    child: Text(
                                      () {
                                        int total = 0;
                                        total = snapshot.data!.data!
                                            .map((e) => e.weightIn ?? 0)
                                            .reduce((value, element) =>
                                                value + element);
                                        return total.toNumberFormat();
                                      }(),
                                      style:
                                          StyleColor.textStyleKhmerDangrekAuto(
                                        fontSize: 14,
                                        color: Colors.white,
                                        bold: true,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
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
                                      style:
                                          StyleColor.textStyleKhmerDangrekAuto(
                                        fontSize: 14,
                                        color: Colors.white,
                                        bold: true,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 70,
                                  ),
                                  Container(
                                    child: Text(
                                      () {
                                        int total = 0;
                                        total = snapshot.data!.data!
                                            .map((e) => e.weightProduct ?? 0)
                                            .reduce((value, element) =>
                                                value + element);
                                        return total.toNumberFormat();
                                      }(),
                                      style:
                                          StyleColor.textStyleKhmerDangrekAuto(
                                        fontSize: 14,
                                        color: Colors.white,
                                        bold: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    return PopupDialog.noResult();
                  }
                  return AnimateLoading();
                }),
          ),
        ],
      ),
    );
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
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Date Picker
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                          padding: EdgeInsets.only(
                              left: 10, right: 10, bottom: 7, top: 7),
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
                          padding: EdgeInsets.only(
                              left: 10, right: 10, bottom: 7, top: 7),
                          backgroundColor: StyleColor.appBarColor,
                        ),
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: Text(
                            DateFormat('d MMMM', 'km').format(date) +
                                " ${date.year}",
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
                          padding: EdgeInsets.only(
                              left: 10, right: 10, bottom: 7, top: 7),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: FutureBuilder<STMReportDetailModel>(
                      future: InitData,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.data!.length > 0)
                          return Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: TextButton(
                                onPressed: () {
                                  onDownloadCouponInvoiceRowClick(
                                    pdf: "report",
                                    excel: "report",
                                  );
                                },
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, bottom: 7, top: 7),
                                  backgroundColor: StyleColor.appBarDarkColor,
                                ),
                                child: Container(
                                  width: 120,
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.download,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'ទាញយក',
                                        style: StyleColor
                                            .textStyleKhmerContentAuto(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        return Container();
                      },
                    ),
                  )
                ],
              ),
            ),

            //Search Bar
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ///Search
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: AutoSizeText(
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            'ស្វែងរក',
                            style: StyleColor.textStyleKhmerDangrekAuto(),
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.4,
                          ),
                          child: Expanded(
                            child: TextFormField(
                              style: StyleColor.textStyleKhmerContent14,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.grey.shade200),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.grey.shade200),
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
                                    child:
                                        searchController.text.trim().length > 0
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
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelText: 'ស្វែងរក (ផ្លាកលេខ)',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    ///Company
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          padding: EdgeInsets.only(left: 10),
                          width: 150,
                          child: Row(
                            children: [
                              Text(
                                'ក្រុមហ៊ុន',
                                style: StyleColor.textStyleKhmerDangrekAuto(),
                              ),
                              selectedCompanyCode != null
                                  ? Container(
                                      margin: EdgeInsets.only(left: 10),
                                      padding: EdgeInsets.only(bottom: 3),
                                      width: 20,
                                      height: 25,
                                      child: IconButton(
                                        iconSize: 20,
                                        padding: EdgeInsets.zero,
                                        onPressed: onClearCompanyCode,
                                        icon: Icon(Icons.clear,
                                            color: Colors.red),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          height: 50,
                          width: 150,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 0.5, style: BorderStyle.solid),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: DropdownButton<String>(
                                items: listDropDownCompany,
                                value: selectedCompanyCode,
                                focusColor: Colors.transparent,
                                hint: Text(
                                  'ជ្រើសរើសក្រុមហ៊ុន',
                                  style: StyleColor.textStyleKhmerContent,
                                ),
                                padding: const EdgeInsets.only(left: 0),
                                style: StyleColor.textStyleKhmerContent,
                                onChanged: (companyCode) {
                                  setState(() {
                                    selectedCompanyCode = companyCode;
                                    InitData = initData();
                                  });
                                },
                                isExpanded: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    ///Customer
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          padding: EdgeInsets.only(left: 10),
                          width: 150,
                          child: Row(
                            children: [
                              Text(
                                'អតិថិជន',
                                style: StyleColor.textStyleKhmerDangrekAuto(),
                              ),
                              selectedCustomerCode != null
                                  ? Container(
                                      margin: EdgeInsets.only(left: 10),
                                      padding: EdgeInsets.only(bottom: 3),
                                      width: 20,
                                      height: 25,
                                      child: IconButton(
                                        iconSize: 20,
                                        padding: EdgeInsets.zero,
                                        onPressed: onClearCustomerCode,
                                        icon: Icon(Icons.clear,
                                            color: Colors.red),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          height: 50,
                          width: 150,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 0.5, style: BorderStyle.solid),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: DropdownButton<String>(
                                items: listDropDownCustomer,
                                value: selectedCustomerCode,
                                focusColor: Colors.transparent,
                                hint: Text(
                                  'ជ្រើសរើសអតិថិជន',
                                  style: StyleColor.textStyleKhmerContent,
                                ),
                                padding: const EdgeInsets.only(left: 0),
                                style: StyleColor.textStyleKhmerContent,
                                onChanged: (customerCode) {
                                  setState(() {
                                    selectedCustomerCode = customerCode;
                                    InitData = initData();
                                  });
                                },
                                isExpanded: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    ///Zone
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          padding: EdgeInsets.only(left: 10),
                          width: 150,
                          child: Row(
                            children: [
                              Text(
                                'តំបន់',
                                style: StyleColor.textStyleKhmerDangrekAuto(),
                              ),
                              selectedZoneCode != null
                                  ? Container(
                                      margin: EdgeInsets.only(left: 10),
                                      padding: EdgeInsets.only(bottom: 3),
                                      width: 20,
                                      height: 25,
                                      child: IconButton(
                                        iconSize: 20,
                                        padding: EdgeInsets.zero,
                                        onPressed: onClearZoneCode,
                                        icon: Icon(Icons.clear,
                                            color: Colors.red),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          height: 50,
                          width: 150,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 0.5, style: BorderStyle.solid),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: DropdownButton<String>(
                                items: listDropDownZone,
                                value: selectedZoneCode,
                                focusColor: Colors.transparent,
                                hint: Text(
                                  'ជ្រើសរើសតំបន់',
                                  style: StyleColor.textStyleKhmerContent,
                                ),
                                padding: const EdgeInsets.only(left: 0),
                                style: StyleColor.textStyleKhmerContent,
                                onChanged: (zoneCode) {
                                  setState(() {
                                    selectedZoneCode = zoneCode;
                                    InitData = initData();
                                  });
                                },
                                isExpanded: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            tabletAndWebWidget(),
          ],
        ),
      ),
    );
  }
}
