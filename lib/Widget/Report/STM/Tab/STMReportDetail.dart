import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

List<String> options = ['ស្ថានីយចូល', 'ស្ថានីយចេញ'];

class _STMReportDetailState extends State<STMReportDetail> {
  late bool canOutOrNot;
  var selectPrintINandOutID;

  int select = 0;
  late int scale;

  String currentOption = options[0];

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;
  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 600;

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
    // scrollController2.addListener(() {
    //   scrollController1.animateTo(scrollController2.offset,
    //       duration: Duration(milliseconds: 300), curve: Curves.linear);
    //   scrollController3.animateTo(scrollController2.offset,
    //       duration: Duration(milliseconds: 300), curve: Curves.linear);
    // });
    // scrollController3.addListener(() {
    //   scrollController2.animateTo(scrollController3.offset,
    //       duration: Duration(milliseconds: 300), curve: Curves.linear);
    //   scrollController1.animateTo(scrollController3.offset,
    //       duration: Duration(milliseconds: 300), curve: Curves.linear);
    // });
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

  DialogScaleDesktop(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: Colors.white,
              child: Container(
                padding: EdgeInsets.all(10),
                width: 450,
                height: 330,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      width: screenWidth,
                      height: 50,
                      child: Text(
                        'ទាញយករបាយការណ៏ថ្លឹង',
                        style: StyleColor.textStyleKhmerDangrekAuto(
                          // bold: true,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    StatefulBuilder(builder: (context, setState) {
                      return Container(
                        height: 140,
                        child: Column(children: [
                          RadioListTile(
                            title: Container(
                                alignment: Alignment.center,
                                height: 60,
                                decoration: BoxDecoration(
                                  color:
                                      StyleColor.appBarColor.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text('ស្ថានីយចូល',
                                    style: StyleColor.textStyleKhmerContentAuto(
                                      fontSize: 18,
                                      color: Colors.white,
                                      bold: true,
                                    ))),
                            value: options[0],
                            groupValue: currentOption,
                            onChanged: (value) {
                              setState(() {
                                select = 0;
                                currentOption = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Container(
                                alignment: Alignment.center,
                                height: 60,
                                decoration: BoxDecoration(
                                  color:
                                      StyleColor.appBarColor.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text('ស្ថានីយចេញ',
                                    style: StyleColor.textStyleKhmerContentAuto(
                                      fontSize: 18,
                                      color: Colors.white,
                                      bold: true,
                                    ))),
                            value: options[1],
                            groupValue: currentOption,
                            onChanged: canOutOrNot
                                ? (value) {
                                    setState(() {
                                      select = 1;
                                      currentOption = value.toString();
                                    });
                                  }
                                : null,
                          ),
                        ]),
                      );
                    }),
                    Divider(),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 190,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  canOutOrNot = false;
                                  currentOption = options[0];
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[200],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'បោះបង',
                                  style: StyleColor.textStyleKhmerContentAuto(
                                    fontSize: 16,
                                    color: Colors.red,
                                    bold: true,
                                  ),
                                )),
                          ),
                          Container(
                            width: 190,
                            height: 50,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: ElevatedButton(
                                onPressed: () {
                                  canOutOrNot = false;
                                  currentOption = options[0];
                                  String invoice_id = selectPrintINandOutID;
                                  var scale_type = "";
                                  DownloadDialog(invoice_id, scale_type);
                                  Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      StyleColor.appBarColor.withOpacity(0.6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'យល់ព្រម',
                                  style: StyleColor.textStyleKhmerContentAuto(
                                    fontSize: 16,
                                    color: Colors.white,
                                    bold: true,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }

  DialogScaleMobiile(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              backgroundColor: Colors.grey[400],
              child: Container(
                padding: EdgeInsets.all(10),
                width: 300,
                height: 220,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      width: screenWidth,
                      height: 50,
                      child: Text(
                        'ទាញយករបាយការណ៏ថ្លឹង',
                        style: StyleColor.textStyleKhmerDangrekAuto(
                          // bold: true,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    StatefulBuilder(builder: (context, setState) {
                      return Container(
                        height: 100,
                        child: Column(children: [
                          RadioListTile(
                            title: Container(
                                alignment: Alignment.center,
                                height: 40,
                                decoration: BoxDecoration(
                                  color:
                                      StyleColor.appBarColor.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text('ស្ថានីយចូល',
                                    style: StyleColor.textStyleKhmerContentAuto(
                                      fontSize: 14,
                                      color: Colors.white,
                                      bold: true,
                                    ))),
                            value: options[0],
                            groupValue: currentOption,
                            onChanged: (value) {
                              setState(() {
                                currentOption = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Container(
                                alignment: Alignment.center,
                                height: 40,
                                decoration: BoxDecoration(
                                  color:
                                      StyleColor.appBarColor.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text('ស្ថានីយចេញ',
                                    style: StyleColor.textStyleKhmerContentAuto(
                                      fontSize: 14,
                                      color: Colors.white,
                                      bold: true,
                                    ))),
                            value: options[1],
                            groupValue: currentOption,
                            onChanged: (value) {
                              setState(() {
                                currentOption = value.toString();
                              });
                            },
                          ),
                        ]),
                      );
                    }),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[200],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'បោះបង',
                                  style: StyleColor.textStyleKhmerContentAuto(
                                    fontSize: 12,
                                    color: Colors.red,
                                    bold: true,
                                  ),
                                )),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      StyleColor.appBarColor.withOpacity(0.7),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'យល់ព្រម',
                                  style: StyleColor.textStyleKhmerContentAuto(
                                    fontSize: 12,
                                    color: Colors.white,
                                    bold: true,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }

  Widget RespnSiveDialog(BuildContext context) {
    if (isDesktop(context)) {
      return DialogScaleDesktop(context);
    } else {
      return DialogScaleMobiile(context);
    }
  }

  Widget mobileScreen() {
    double screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // height: screenHeight * 0.1,
            width: screenWidth,
            // alignment: Alignment.center,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
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
                    width: 100,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 100,
                    child: Text(
                      "ផ្លាកលេខ",
                      style: StyleColor.textStyleKhmerDangrekAuto(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 100,
                    child: Text(
                      'ស្ថានីយចូល'.tr(),
                      style: StyleColor.textStyleKhmerDangrekAuto(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
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
                    width: 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 100,
                    child: Text(
                      'ស្ថានីយចេញ'.tr(),
                      style: StyleColor.textStyleKhmerDangrekAuto(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 100,
                    child: Text(
                      'ទម្ងន់ចេញ(គក)'.tr(),
                      style: StyleColor.textStyleKhmerDangrekAuto(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 100,
                    child: Text(
                      'ទម្ងន់ទំនិញ(គក)'.tr(),
                      style: StyleColor.textStyleKhmerDangrekAuto(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    alignment: Alignment.center,
                    width: 120,
                    child: Text(
                      'ទាញយក'.tr(),
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
                      return Container(
                        width: screenWidth,
                        child: Column(
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
                                    width: screenWidth,
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    height: 60,
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
                                        width: screenWidth,
                                        // alignment: Alignment.center,
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          controller: scrollController2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
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
                                                alignment: Alignment.centerLeft,
                                                width: 100,
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
                                                              .data![index],
                                                        ),
                                                      ),
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
                                                alignment: Alignment.centerLeft,
                                                width: 100,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      snapshot
                                                          .data!
                                                          .data![index]
                                                          .frontPlateObj!
                                                          .nameKh!,
                                                      style: StyleColor
                                                          .textStyleKhmerContentAuto(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    Text(
                                                      snapshot
                                                          .data!
                                                          .data![index]
                                                          .frontPlateObj!
                                                          .plateNumberFormatted!,
                                                      style: StyleColor
                                                          .textStyleKhmerContentAuto(
                                                        fontSize: 12,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: 100,
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
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: 100,
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
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: 100,
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
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: 100,
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
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: 100,
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
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),

                                              //download buttons
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: 120,
                                                padding: const EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: FutureBuilder<
                                                    STMReportDetailModel>(
                                                  future: InitData,
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData &&
                                                        snapshot.data!.data!
                                                                .length >
                                                            0)
                                                      return Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Container(
                                                          child: TextButton(
                                                            onPressed: () {
                                                              RespnSiveDialog(
                                                                  context);
                                                            },
                                                            style: TextButton
                                                                .styleFrom(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                            ),
                                                            child: Container(
                                                              width: 50,
                                                              height: 40,
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .download_outlined,
                                                                    color: Colors
                                                                        .blue,
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
                              width: screenWidth,
                              // alignment: Alignment.center,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
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
                                    SizedBox(
                                      width: 100,
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: 100,
                                      child: Text(
                                        snapshot.data!.data!.length.toString(),
                                        style: StyleColor
                                            .textStyleKhmerDangrekAuto(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
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
                                          fontSize: 12,
                                          color: Colors.white,
                                          bold: true,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
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
                                          fontSize: 12,
                                          color: Colors.white,
                                          bold: true,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
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
                                          fontSize: 12,
                                          color: Colors.white,
                                          bold: true,
                                        ),
                                      ),
                                    ),

                                    //Download all button
                                    Container(
                                      width: 120,
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child:
                                            FutureBuilder<STMReportDetailModel>(
                                          future: InitData,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData &&
                                                snapshot.data!.data!.length > 0)
                                              return Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      onDownloadCouponInvoiceRowClick(
                                                        pdf: "report",
                                                        excel: "report",
                                                      );
                                                    },
                                                    style: TextButton.styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      padding: EdgeInsets.only(
                                                          left: 5,
                                                          right: 5,
                                                          bottom: 7,
                                                          top: 7),
                                                    ),
                                                    child: Container(
                                                      height: 50,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
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
                                                                .textStyleKhmerDangrekAuto(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
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
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
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

  Widget tabletAndWebWidget() {
    double screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // height: screenHeight * 0.1,
            width: screenWidth,
            // alignment: Alignment.center,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 50,
                    child: Text(
                      'Label.No'.tr(),
                      style: StyleColor.textStyleKhmerDangrekAuto(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 100,
                  ),
                  Container(
                    alignment: Alignment.center,
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
                    alignment: Alignment.centerLeft,
                    width: 150,
                    child: Text(
                      'ស្ថានីយចូល'.tr(),
                      style: StyleColor.textStyleKhmerDangrekAuto(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 150,
                    child: Text(
                      'ទម្ងន់ចូល(គក)'.tr(),
                      style: StyleColor.textStyleKhmerDangrekAuto(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 150,
                    child: Text(
                      'ស្ថានីយចេញ'.tr(),
                      style: StyleColor.textStyleKhmerDangrekAuto(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 150,
                    child: Text(
                      'ទម្ងន់ចេញ(គក)'.tr(),
                      style: StyleColor.textStyleKhmerDangrekAuto(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 100,
                    child: Text(
                      'ទម្ងន់ទំនិញ(គក)'.tr(),
                      style: StyleColor.textStyleKhmerDangrekAuto(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    alignment: Alignment.center,
                    width: 100,
                    child: Text(
                      'ទាញយក'.tr(),
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
                      return Container(
                        width: screenWidth,
                        child: Column(
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
                                    width: screenWidth,
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    height: 60,
                                    child: TextButton(
                                      onPressed: () async {
                                        var valueID =
                                            snapshot.data!.data![index].id;
                                        selectPrintINandOutID = valueID;
                                        print(valueID);
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
                                        width: screenWidth,
                                        // alignment: Alignment.center,
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          controller: scrollController2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: 50,
                                                child: Text(
                                                  (index + 1).toString(),
                                                  style: StyleColor
                                                      .textStyleKhmerDangrekAuto(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width: 100,
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
                                                              .data![index],
                                                        ),
                                                      ),
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
                                                alignment: Alignment.center,
                                                width: 150,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      snapshot
                                                          .data!
                                                          .data![index]
                                                          .frontPlateObj!
                                                          .nameKh!,
                                                      style: StyleColor
                                                          .textStyleKhmerContentAuto(
                                                        fontSize: 14,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Text(
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
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: 150,
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
                                                alignment: Alignment.centerLeft,
                                                width: 150,
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
                                                alignment: Alignment.centerLeft,
                                                width: 150,
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
                                                alignment: Alignment.centerLeft,
                                                width: 150,
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
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: 100,
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

                                              //!Report Download button

                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: 100,
                                                padding: const EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: FutureBuilder<
                                                    STMReportDetailModel>(
                                                  future: InitData,
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData &&
                                                        snapshot.data!.data!
                                                                .length >
                                                            0)
                                                      return Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Container(
                                                          child: TextButton(
                                                            onPressed: () {
                                                              var weighOut =
                                                                  snapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .weightOut;
                                                              if (weighOut ==
                                                                  null) {
                                                                canOutOrNot =
                                                                    false;
                                                              } else {
                                                                canOutOrNot =
                                                                    true;
                                                              }

                                                              var valueID =
                                                                  snapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .id;
                                                              selectPrintINandOutID =
                                                                  valueID;
                                                              print(
                                                                  selectPrintINandOutID);
                                                              RespnSiveDialog(
                                                                  context);
                                                            },
                                                            style: TextButton
                                                                .styleFrom(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                            ),
                                                            child: Container(
                                                              width: 50,
                                                              height: 40,
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .download_outlined,
                                                                    color: Colors
                                                                        .blue,
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
                              width: screenWidth,
                              // alignment: Alignment.center,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: 50,
                                      child: Text(
                                        'សរុប'.tr(),
                                        style: StyleColor
                                            .textStyleKhmerDangrekAuto(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
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
                                      alignment: Alignment.centerLeft,
                                      width: 150,
                                      child: Text(
                                        'ទម្ងន់ចូលសរុប​​(គក)'.tr(),
                                        style: StyleColor
                                            .textStyleKhmerDangrekAuto(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: 150,
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
                                      alignment: Alignment.centerLeft,
                                      width: 150,
                                      child: Text(
                                        'ទម្ងន់ចេញសរុប(គក)'.tr(),
                                        style: StyleColor
                                            .textStyleKhmerDangrekAuto(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: 150,
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
                                      alignment: Alignment.centerLeft,
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

                                    //Download ALL buttom
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child:
                                            FutureBuilder<STMReportDetailModel>(
                                          future: InitData,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData &&
                                                snapshot.data!.data!.length > 0)
                                              return Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      onDownloadCouponInvoiceRowClick(
                                                        pdf: "report",
                                                        excel: "report",
                                                      );
                                                    },
                                                    style: TextButton.styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      padding: EdgeInsets.only(
                                                          left: 5,
                                                          right: 5,
                                                          bottom: 7,
                                                          top: 7),
                                                    ),
                                                    child: Container(
                                                      width: 100,
                                                      height: 40,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
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
                                                              color:
                                                                  Colors.white,
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
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
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

  Widget screenBar(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      width: screenWidth,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: AutoSizeText(
                    'ស្វែងរក (ផ្លាកលេខ)',
                    style: StyleColor.textStyleKhmerDangrekAuto(),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: screenWidth * 0.4,
                  ),
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
                        },
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: 'ស្វែងរក',
                      labelStyle: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            // Company Dropdown
            Container(
              child: Column(
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
                                  icon: Icon(Icons.clear, color: Colors.red),
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
                        side: BorderSide(width: 0.5, style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
            ),
            SizedBox(
              width: 20,
            ),
            // Customer Dropdown
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
                                icon: Icon(Icons.clear, color: Colors.red),
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
                      side: BorderSide(width: 0.5, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
            SizedBox(
              width: 20,
            ),
            // Zone Dropdown
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
                                icon: Icon(Icons.clear, color: Colors.red),
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
                      side: BorderSide(width: 0.5, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
    );
  }

  Widget responsiveScreen() {
    if (isDesktop(context)) {
      return tabletAndWebWidget();
    } else {
      return mobileScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraints) {
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
            child: Container(
              width: screenWidth,
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
                              if (snapshot.hasData &&
                                  snapshot.data!.data!.length > 0)
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            bottom: 7,
                                            top: 7),
                                        backgroundColor:
                                            StyleColor.appBarDarkColor,
                                      ),
                                      child: Container(
                                        width: 120,
                                        height: 40,
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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

                  // screenBar(),

                  //Search Bar
                  screenBar(context),

                  responsiveScreen(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void DownloadDialog(invoice_id, scaleType) {
    DownloadScaleInAndOut(invoice_id, scaleType);
  }

  void DownloadScaleInAndOut(invoice_id, scale_type) async {
    var fileType = "pdf";

    if (select == 0) {
      scale_type = "in";
      var stream = await Singleton.instance.apiExtension
          .downloadReportCouponInvoiceByID(
              context, fileType, invoice_id, scale_type);
      if (kIsWeb) {
        await FileSaver.instance.saveFile(
          name: "file.pdf",
          ext: "pdf",
          bytes: stream,
          mimeType: MimeType.pdf,
        );
      }
    } else if (select == 1) {
      scale_type = "out";
      var stream = await Singleton.instance.apiExtension
          .downloadReportCouponInvoiceByID(
              context, fileType, invoice_id, scale_type);
      if (kIsWeb) {
        await FileSaver.instance.saveFile(
          name: "file.pdf",
          ext: "pdf",
          bytes: stream,
          mimeType: MimeType.pdf,
        );
      }
    } else {
      Navigator.pop(context);
    }
  }
}
