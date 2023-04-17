import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/Chart/AxisKeyDataModel.dart';
import 'package:stm_report_app/Entity/PPSHV/PPSHVDeductionModel.dart';
import 'package:stm_report_app/Enum/AxisDataTypeEnum.dart';
import 'package:stm_report_app/Enum/ChartTypeEnum.dart';
import 'package:stm_report_app/Enum/IntervalTypeEnum.dart';
import 'package:stm_report_app/Enum/TableDateType.dart';
import 'package:stm_report_app/Enum/TableTypeEnum.dart';
import 'package:stm_report_app/Enum/ValueDataTypeEnum.dart';
import 'package:stm_report_app/Extension/Extension.dart';
import 'package:stm_report_app/Extension/ExtensionComponent.dart';
import 'package:stm_report_app/Extension/ExtensionMethod.dart';
import 'package:stm_report_app/Infrastructor/Singleton.dart';
import 'package:stm_report_app/Style/AnimateLoading.dart';
import 'package:stm_report_app/Style/PopupDialog.dart';
import 'package:stm_report_app/Style/StyleColor.dart';
import 'package:stm_report_app/Widget/Card/GraphCard.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';
import 'package:toggle_switch/toggle_switch.dart';

class PPSHVDeductionReport extends StatefulWidget {
  const PPSHVDeductionReport({Key? key}) : super(key: key);

  @override
  State<PPSHVDeductionReport> createState() => _PPSHVDeductionReportState();
}

class _PPSHVDeductionReportState extends State<PPSHVDeductionReport> {
  @override
  void initState() {
    InitData = initData();
    super.initState();
  }

  //Instance
  DateTime dateNow = DateTime.now();
  DateTime date = DateTime.now();
  int selectedSegmentType = 0;
  bool isLastPeriod = false;
  int lastPeriod = 0;
  //Future
  Future<PPSHVDeductionModel> initData() async {
    var res = await Singleton.instance.apiExtension
        .get<PPSHVDeductionModel, PPSHVDeductionModel>(
      context: context,
      loading: false,
      param:
          "type=${getTypeBySegmentIndex()}&date=${date.toYYYYMMDD()}&last_period=${lastPeriod}",
      baseUrl: ApiEndPoint.ppshvDeduction,
      deserialize: (e) => PPSHVDeductionModel.fromJson(e),
    );
    if (res.success!)
      return res.data!;
    else
      return Future.error(true);
  }

  Future<PPSHVDeductionModel>? InitData;

  //Prop
  double getIntervalByLength(int length) {
    // if(selectedSegmentType==0)
    return 1;
    return length > 15 || length == 1 ? -1 : 1;
  }

  String getTypeBySegmentIndex() {
    if (selectedSegmentType == 0)
      return "daily";
    else if (selectedSegmentType == 1)
      return "weekly";
    else if (selectedSegmentType == 2)
      return "monthly";
    else if (selectedSegmentType == 3) return "yearly";
    return "";
  }

  String getDateCaption(PPSHVDeductionModel snapshot) {
    try {
      if (snapshot.data!.length > 0) {
        var list = snapshot.data!
            .where((element) => element.transactionTotal! > 0)
            .toList()
            .reversed
            .toList();
        if (list.length > 0) {
          var obj = list.first;
          if (selectedSegmentType == 0) {
            return "- " +
                DateFormat.MMMMEEEEd("km").format(DateTime.parse(obj.date!));
          } else if (selectedSegmentType == 2) {
            return "- " +
                DateFormat.yMMMM("km").format(DateTime.parse(obj.date!));
          } else if (selectedSegmentType == 3) {
            return "- " + DateFormat.y("km").format(DateTime.parse(obj.date!));
          }
        }
      }
      return "";
    } catch (err) {
      return "";
    }
  }

  Widget getSelectSegmentDetail() {
    if (selectedSegmentType == 0 || selectedSegmentType == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'របាយការណ៍ខែ៖ ',
            style: StyleColor.textStyleKhmerContentAuto(),
          ),
          !isLastPeriod
              ? TextButton(
                  onPressed: () async {
                    var res = await showMonthPicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime.now().subtract(Duration(days: 365)),
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
                    padding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 7, top: 7),
                    backgroundColor: StyleColor.appBarColor,
                  ),
                  child: Text(
                    DateFormat('MMMM', "km").format(date) + " ${date.year}",
                    style: StyleColor.textStyleKhmerContentAuto(
                      color: Colors.white,
                    ),
                  ),
                )
              : TextButton(
                  onPressed: () async {},
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 7, top: 7),
                    backgroundColor: Colors.grey,
                  ),
                  child: Text(
                    DateFormat('MMMM', 'km').format(date) + " ${date.year}",
                    style: StyleColor.textStyleKhmerContentAuto(
                      color: Colors.white,
                    ),
                  ),
                ),
          getLastPeriod(),
        ],
      );
    } else if (selectedSegmentType == 2 || selectedSegmentType == 3) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'របាយការណ៍ឆ្នាំ៖ ',
            style: StyleColor.textStyleKhmerContentAuto(),
          ),
          !isLastPeriod
              ? TextButton(
                  onPressed: () async {
                    selectYear(context);
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 7, top: 7),
                    backgroundColor: StyleColor.appBarColor,
                  ),
                  child: Text(
                    DateFormat('yyyy').format(date),
                    style: StyleColor.textStyleKhmerContentAuto(
                      color: Colors.white,
                    ),
                  ),
                )
              : TextButton(
                  onPressed: () async {},
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 7, top: 7),
                    backgroundColor: Colors.grey,
                  ),
                  child: Text(
                    DateFormat('yyyy').format(date),
                    style: StyleColor.textStyleKhmerContentAuto(
                      color: Colors.white,
                    ),
                  ),
                ),
          getLastPeriod(),
        ],
      );
    }
    return Container();
  }

  Widget getLastPeriod() {
    if (selectedSegmentType == 0) {
      return Container(
        margin: EdgeInsets.only(
          left: 10,
        ),
        width: 130,
        child: ListTileTheme(
          horizontalTitleGap: 0,
          child: CheckboxListTile(
            value: isLastPeriod,
            activeColor: StyleColor.appBarColor,
            contentPadding: EdgeInsets.all(0),
            onChanged: (value) {
              setState(() {
                isLastPeriod = value!;
                date = DateTime.now();
                lastPeriod = value ? 7 : 0;
                InitData = initData();
              });
            },
            title: Text(
              '7 ថ្ងៃចុងក្រោយ',
              style: StyleColor.textStyleKhmerContentAuto(
                fontSize: 14,
              ),
            ),
            dense: true,
            controlAffinity: ListTileControlAffinity.leading,
            visualDensity: VisualDensity.compact,
          ),
        ),
      );
    } else if (selectedSegmentType == 2) {
      return Container(
        margin: EdgeInsets.only(
          left: 10,
        ),
        width: 130,
        child: ListTileTheme(
          horizontalTitleGap: 0,
          child: CheckboxListTile(
            value: isLastPeriod,
            activeColor: StyleColor.appBarColor,
            contentPadding: EdgeInsets.all(0),
            onChanged: (value) {
              setState(() {
                isLastPeriod = value!;
                date = DateTime.now();
                lastPeriod = value ? 12 : 0;
                InitData = initData();
              });
            },
            title: Text(
              '12 ខែចុងក្រោយ',
              style: StyleColor.textStyleKhmerContentAuto(
                fontSize: 14,
              ),
            ),
            dense: true,
            controlAffinity: ListTileControlAffinity.leading,
            visualDensity: VisualDensity.compact,
          ),
        ),
      );
    }
    return Container();
  }

  //Method
  selectYear(context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          iconPadding: EdgeInsets.zero,
          title: Container(
            padding: EdgeInsets.all(20),
            color: Colors.blue,
            child: Text(
              "ជ្រើសរើស",
              style: StyleColor.textStyleKhmerDangrekAuto(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 10, 1),
              // lastDate: DateTime.now(),
              lastDate: DateTime.now(),
              initialDate: DateTime.now(),
              selectedDate: date,
              onChanged: (DateTime dateTime) {
                setState(() {
                  dateTime = DateTime(dateTime.year, 1, 1);
                  date = dateTime;
                  InitData = initData();
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  onSelectToggle(index) {
    selectedSegmentType = index;
    isLastPeriod = false;
    lastPeriod = 0;
    if (getTypeBySegmentIndex() == "monthly" ||
        getTypeBySegmentIndex() == "yearly")
      date = DateTime(DateTime.now().year, 1, 1);
    else
      date = DateTime.now();

    InitData = initData();
    setState(() {});
  }

  TABLE_DATE_TYPE_ENUM getDateTypeBySegment() {
    if (selectedSegmentType == 0)
      return TABLE_DATE_TYPE_ENUM.DAILY;
    else if (selectedSegmentType == 2)
      return TABLE_DATE_TYPE_ENUM.MONTHLY;
    else if (selectedSegmentType == 3) return TABLE_DATE_TYPE_ENUM.YEARLY;
    return TABLE_DATE_TYPE_ENUM.DAILY;
  }

  double getPrimaryAxisYInterval(double total) {
    if (total != null && total > 0) {
      if (selectedSegmentType > 0) {
        return (total / 80).roundToDouble();
      } else if (selectedSegmentType == 0) {
        return (total / 110).roundToDouble();
      } else
        return -1;
      // else if (selectedSegmentType == 0)
      //   return -1;
    } else
      return -1;
  }

  PPSHVDeductionModel removeNoDataCheckSum(PPSHVDeductionModel data) {
    // data.data!.removeWhere((element) => element.checksum == null);
    // data.data![0].checksum!.grandTotal!.trip = null;
    // data.data![0].checksum!.grandTotal!.amount = null;

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleColor.appBarColor,
        title: Text(
          'ចរាចរណ៍ និងចំណូល',
          style: StyleColor.textStyleKhmerDangrekAuto(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Image.asset("assets/image/stm_report_logo.png", width: 40),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            ToggleSwitch(
              labels: [
                'ប្រចាំថ្ងៃ',
                'ប្រចាំសប្តាហ៍',
                'ប្រចាំខែ',
                'ប្រចាំឆ្នាំ'
              ],
              activeFgColor: Colors.white,
              initialLabelIndex: selectedSegmentType,
              minWidth: 90,
              dividerMargin: 0,
              totalSwitches: 4,
              onToggle: onSelectToggle,
              customTextStyles: [
                StyleColor.textStyleKhmerContentAuto(
                  color: Colors.white,
                  fontSize: 12,
                  bold: selectedSegmentType == 0 ? true : false,
                ),
                StyleColor.textStyleKhmerContentAuto(
                  color: Colors.white,
                  fontSize: 12,
                  bold: selectedSegmentType == 1 ? true : false,
                ),
                StyleColor.textStyleKhmerContentAuto(
                  color: Colors.white,
                  fontSize: 12,
                  bold: selectedSegmentType == 2 ? true : false,
                ),
                StyleColor.textStyleKhmerContentAuto(
                  color: Colors.white,
                  fontSize: 12,
                  bold: selectedSegmentType == 3 ? true : false,
                ),
              ],
            ),
            //Segmented Detail
            Padding(
              padding: const EdgeInsets.all(5),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: getSelectSegmentDetail(),
              ),
            ),
            // Divider(),
            Expanded(
              child: FutureBuilder<PPSHVDeductionModel>(
                future: InitData,
                builder: (context, snapshot) {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: () {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData && snapshot.data!.data!.length > 0)
                          return ListView(
                            physics: ClampingScrollPhysics(),
                            children: [
                              //Traffic Trx CA Type
                              GraphCard(
                                bigTitle:
                                    "ផ្លូវល្បឿនលឿន ភ្នំពេញ-ក្រុងព្រះសីហនុ",
                                title:
                                    "ចំនួនចរាចរណ៍ (ប្រភេទយានយន្ត) ${Extension.getTitleBySegmentIndex(
                                  selectedSegmentType: selectedSegmentType,
                                  date: date,
                                )}",
                                obj: snapshot.data!,
                                tableDateType: getDateTypeBySegment(),
                                tableTypeEnum: TABLE_TYPE_ENUM
                                    .PPSHVDeductionRevenueVehicle,
                                downloadFileName: "revenue-gate-catype",
                                widgetFunction: (duration, axisFontSize) {
                                  return ExtensionComponent
                                      .ppshvDeductionTrafficVehicleType(
                                          axisFontSize: axisFontSize,
                                          deductionModel: snapshot.data!,
                                          title: "",
                                          primaryAxisXFormat:
                                              getTypeBySegmentIndex() ==
                                                      "monthly"
                                                  ? AXIS_DATA_TYPE
                                                      .DATETIME_yMMMM
                                                  : getTypeBySegmentIndex() ==
                                                          "yearly"
                                                      ? AXIS_DATA_TYPE
                                                          .DATETIME_y
                                                      : AXIS_DATA_TYPE
                                                          .DATETIME_MMMMEEEEd,
                                          intervalType:
                                              getTypeBySegmentIndex() ==
                                                      "monthly"
                                                  ? INTERVAL_TYPE_ENUM.MONTH
                                                  : getTypeBySegmentIndex() ==
                                                          "yearly"
                                                      ? INTERVAL_TYPE_ENUM.YEAR
                                                      : INTERVAL_TYPE_ENUM.AUTO,
                                          // primaryAxisYInterval:
                                          //     getPrimaryAxisYInterval(snapshot
                                          //                 .data!
                                          //                 .total!
                                          //                 .amountTotal ==
                                          //             null
                                          //         ? 0
                                          //         : snapshot.data!.total!
                                          //             .amountTotal!),
                                          animationDuration: duration,
                                          zoom: false);
                                },
                              ),
                              //Line Graph
                              GraphCard(
                                bigTitle:
                                    "ផ្លូវល្បឿនលឿន ភ្នំពេញ-ក្រុងព្រះសីហនុ",
                                title:
                                    "ចំណូលធៀបនឹងចរាចរណ៍ (ប្រភេទយានយន្ត) ${Extension.getTitleBySegmentIndex(
                                  selectedSegmentType: selectedSegmentType,
                                  date: date,
                                )}",
                                obj: () {
                                  removeNoDataCheckSum(snapshot.data!);
                                  return snapshot.data!;
                                }(),
                                tableDateType: getDateTypeBySegment(),
                                tableTypeEnum: TABLE_TYPE_ENUM
                                    .PPSHVDeductionRevenueVehicle,
                                downloadFileName: "revenue-gate-catype",
                                widgetFunction: (duration, axisFontSize) {
                                  return ExtensionComponent
                                      .ppshvDeductionRevenueVehicleType(
                                    axisFontSize: axisFontSize,
                                    deductionModel: snapshot.data!,
                                    title: "",
                                    primaryAxisXFormat:
                                        getTypeBySegmentIndex() == "monthly"
                                            ? AXIS_DATA_TYPE.DATETIME_yMMMM
                                            : getTypeBySegmentIndex() ==
                                                    "yearly"
                                                ? AXIS_DATA_TYPE.DATETIME_y
                                                : AXIS_DATA_TYPE
                                                    .DATETIME_MMMMEEEEd,
                                    intervalType: getTypeBySegmentIndex() ==
                                            "monthly"
                                        ? INTERVAL_TYPE_ENUM.MONTH
                                        : getTypeBySegmentIndex() == "yearly"
                                            ? INTERVAL_TYPE_ENUM.YEAR
                                            : INTERVAL_TYPE_ENUM.AUTO,
                                    primaryAxisYInterval:
                                        getPrimaryAxisYInterval(
                                            snapshot.data!.total!.amountTotal ==
                                                    null
                                                ? 0
                                                : snapshot
                                                    .data!.total!.amountTotal!),
                                    animationDuration: duration,
                                    zoom: false,
                                  );
                                },
                              ),
                              // Stack Bar with Line
                              GraphCard(
                                bigTitle:
                                    "ផ្លូវល្បឿនលឿន ភ្នំពេញ-ក្រុងព្រះសីហនុ",
                                widgetFunction: (duration, axisFontSize) {
                                  return ExtensionComponent.graphComponent
                                      .getChart<PPSHVDeductionDataModel>(
                                    axisFontSize: Singleton
                                        .instance.graphAxisFontSizeScreen,
                                    chartType:
                                        CHART_TYPE_ENUM.STACK_BAR_AND_LINE,
                                    title: "",
                                    jsonData: snapshot.data!.data!,
                                    primaryAxisX: 'date',
                                    primaryAxisY: [
                                      AxisKeyDataModel(
                                        label: "Traffic",
                                        data: "transaction-total",
                                        colorRgb: StyleColor.mtcColor,
                                        trendLineColorRgb: StyleColor.mtcColor,
                                        chartType: CHART_TYPE_ENUM.STACK_BAR,
                                      ),
                                      AxisKeyDataModel(
                                        label: "Digital",
                                        data: "transaction-digital",
                                        colorRgb: StyleColor.blueDarker,
                                        trendLineColorRgb:
                                            StyleColor.etcTrendLineColor,
                                        chartType: CHART_TYPE_ENUM.STACK_BAR,
                                      ),
                                    ],
                                    primaryAxisYDataType:
                                        VALUE_DATA_TYPE.TRANSACTION,
                                    primaryAxisYTitle: "",
                                    animationDuration: duration,
                                    primaryAxisYGridLine: 0.3,
                                    secondaryAxisYGridLine: 0,
                                    sideBySideSeries: false,
                                    primaryAxisYInterval:
                                        getPrimaryAxisYInterval(
                                      snapshot.data!.total!.amountTotal == null
                                          ? 0
                                          : snapshot.data!.total!.amountTotal!,
                                    ),
                                    primaryAxisXInterval: getIntervalByLength(
                                        snapshot.data!.data!.length),
                                    primaryAxisXFormat:
                                        getTypeBySegmentIndex() == "monthly"
                                            ? AXIS_DATA_TYPE.DATETIME_yMMMM
                                            : getTypeBySegmentIndex() ==
                                                    "yearly"
                                                ? AXIS_DATA_TYPE.DATETIME_y
                                                : AXIS_DATA_TYPE
                                                    .DATETIME_MMMMEEEEd,
                                    intervalType: getTypeBySegmentIndex() ==
                                            "monthly"
                                        ? INTERVAL_TYPE_ENUM.MONTH
                                        : getTypeBySegmentIndex() == "yearly"
                                            ? INTERVAL_TYPE_ENUM.YEAR
                                            : INTERVAL_TYPE_ENUM.AUTO,
                                    primaryAxisYCompact: true,
                                    primaryDeserialize: (e) => e.toJson(),
                                    secondaryAxisY: [
                                      AxisKeyDataModel(
                                        label: "\$Revenue",
                                        data: "amount-total",
                                        colorRgb: StyleColor.etcColor,
                                        chartType: CHART_TYPE_ENUM.LINE_CHART,
                                      ),
                                    ],
                                    secondaryAxisYDataType:
                                        VALUE_DATA_TYPE.DOLLAR,
                                    secondaryAxisYTitle: "",
                                  );
                                },
                                title:
                                    "ចរាចរណ៍ និងចំណូល ${Extension.getTitleBySegmentIndex(
                                  selectedSegmentType: selectedSegmentType,
                                  date: date,
                                )}",
                                downloadFileName: "revenue-compare-by-gate",
                                obj: snapshot.data!,
                                tableDateType: getDateTypeBySegment(),
                                tableTypeEnum:
                                    TABLE_TYPE_ENUM.PPSHVDeductionMixedTrx,
                              ),

                              //Line Graph
                              GraphCard(
                                bigTitle:
                                    "ផ្លូវល្បឿនលឿន ភ្នំពេញ-ក្រុងព្រះសីហនុ",
                                title:
                                    "ចំណូលធៀបនឹងចរាចរណ៍ (ប្រភេទច្រក) ${Extension.getTitleBySegmentIndex(
                                  selectedSegmentType: selectedSegmentType,
                                  date: date,
                                )}",
                                obj: snapshot.data!,
                                tableDateType: getDateTypeBySegment(),
                                downloadFileName: "revenue-gate-type",
                                tableTypeEnum: TABLE_TYPE_ENUM
                                    .PPSHVDeductionCrossDigitalTrx,
                                widgetFunction: (duration, axisFontSize) {
                                  return ExtensionComponent.graphComponent.getChart<
                                          PPSHVDeductionDataModel>(
                                      axisFontSize:
                                          Singleton
                                              .instance.graphAxisFontSizeScreen,
                                      primaryAxisYTitle: "",
                                      primaryAxisYGridLine: 0.1,
                                      chartType: CHART_TYPE_ENUM.LINE_CHART,
                                      title: "",
                                      jsonData: snapshot.data!.data!,
                                      primaryAxisX: 'date',
                                      primaryAxisYInterval:
                                          getPrimaryAxisYInterval(
                                              snapshot.data!.total!
                                                          .amountTotal ==
                                                      null
                                                  ? 0
                                                  : snapshot.data!.total!
                                                      .amountTotal!),
                                      primaryAxisXFormat:
                                          getTypeBySegmentIndex() == "monthly"
                                              ? AXIS_DATA_TYPE.DATETIME_yMMMM
                                              : getTypeBySegmentIndex() ==
                                                      "yearly"
                                                  ? AXIS_DATA_TYPE.DATETIME_y
                                                  : AXIS_DATA_TYPE
                                                      .DATETIME_MMMMEEEEd,
                                      intervalType: getTypeBySegmentIndex() ==
                                              "monthly"
                                          ? INTERVAL_TYPE_ENUM.MONTH
                                          : getTypeBySegmentIndex() == "yearly"
                                              ? INTERVAL_TYPE_ENUM.YEAR
                                              : INTERVAL_TYPE_ENUM.AUTO,
                                      primaryAxisXInterval: getIntervalByLength(
                                          snapshot.data!.data!.length),
                                      primaryAxisY: [
                                        AxisKeyDataModel(
                                          label: "\$ANPR",
                                          data: "amount-anpr-dollar",
                                          colorRgb: StyleColor.anprColor,
                                        ),
                                        AxisKeyDataModel(
                                          label: "\$ETC",
                                          data: "amount-obu-dollar",
                                          colorRgb: StyleColor.etcColor,
                                        ),
                                        AxisKeyDataModel(
                                          label: "\$MTC",
                                          data: "amount-iccard-dollar",
                                          colorRgb: StyleColor.mtcColor,
                                        ),
                                      ],
                                      primaryAxisYDataType:
                                          VALUE_DATA_TYPE.NUMERIC,
                                      // primaryAxisYTitle: "ទឹកប្រាក់",
                                      primaryDeserialize: (e) => e.toJson(),
                                      secondaryAxisY: [
                                        AxisKeyDataModel(
                                          label: "Traffic",
                                          data: "transaction-total",
                                          colorRgb:
                                              Color.fromRGBO(41, 110, 9, 1.0),
                                        ),
                                      ],
                                      secondaryAxisYInterval: -1,
                                      // secondaryAxisYTitle: "ចរាចរណ៍",
                                      secondaryAxisYDataType:
                                          VALUE_DATA_TYPE.TRANSACTION);
                                },
                              ),

                              //Stack Bar
                              GraphCard(
                                bigTitle:
                                    "ផ្លូវល្បឿនលឿន ភ្នំពេញ-ក្រុងព្រះសីហនុ",
                                title:
                                    "ប្រៀបធៀបចំណូល${Extension.getTitleBySegmentIndex(
                                  selectedSegmentType: selectedSegmentType,
                                  date: date,
                                )}",
                                widgetFunction: (duration, axisFontSize) {
                                  return ExtensionComponent.graphComponent
                                      .getChart<PPSHVDeductionDataModel>(
                                    axisFontSize: Singleton
                                        .instance.graphAxisFontSizeScreen,
                                    chartType: CHART_TYPE_ENUM.STACK_BAR,
                                    title: "",
                                    sideBySideSeries: false,
                                    jsonData: snapshot.data!.data!,
                                    primaryAxisX: 'date',
                                    primaryAxisXFormat:
                                        getTypeBySegmentIndex() == "monthly"
                                            ? AXIS_DATA_TYPE.DATETIME_yMMMM
                                            : getTypeBySegmentIndex() ==
                                                    "yearly"
                                                ? AXIS_DATA_TYPE.DATETIME_y
                                                : AXIS_DATA_TYPE
                                                    .DATETIME_MMMMEEEEd,
                                    intervalType: getTypeBySegmentIndex() ==
                                            "monthly"
                                        ? INTERVAL_TYPE_ENUM.MONTH
                                        : getTypeBySegmentIndex() == "yearly"
                                            ? INTERVAL_TYPE_ENUM.YEAR
                                            : INTERVAL_TYPE_ENUM.AUTO,
                                    primaryAxisY: [
                                      AxisKeyDataModel(
                                        label: "\$MTC",
                                        data: "amount-iccard-dollar",
                                        colorRgb: StyleColor.mtcColor,
                                      ),
                                      AxisKeyDataModel(
                                        label: "\$ETC",
                                        data: "amount-obu-dollar",
                                        colorRgb: StyleColor.etcColor,
                                        trendLineColorRgb:
                                            StyleColor.etcTrendLineColor,
                                      ),
                                      AxisKeyDataModel(
                                          label: "\$ANPR",
                                          data: "amount-anpr-dollar",
                                          colorRgb: StyleColor.anprColor
                                              .withOpacity(0.8),
                                          trendLineColorRgb:
                                              StyleColor.anprTrendLineColor),
                                    ],
                                    primaryAxisYDataType:
                                        VALUE_DATA_TYPE.NUMERIC,
                                    primaryAxisXInterval: getIntervalByLength(
                                        snapshot.data!.data!.length),
                                    primaryAxisYTitle: "",
                                    primaryDeserialize: (e) => e.toJson(),
                                    secondaryAxisY: [
                                      AxisKeyDataModel(
                                        label: "Traffic",
                                        data: "transaction-total",
                                        colorRgb: Colors.red.shade500,
                                      ),
                                    ],
                                    secondaryAxisYTitle: "បរិមាណចរាចរណ៍",
                                  );
                                },
                              ),
                              //PPSHV Deduction ETC ANPR Percentage
                              GraphCard(
                                bigTitle:
                                    "ផ្លូវល្បឿនលឿន ភ្នំពេញ-ក្រុងព្រះសីហនុ",
                                title:
                                    "ភាគរយចំនួនចរាចរណ៍ ETC នឹង ANPR ${Extension.getTitleBySegmentIndex(
                                  // "ETC ធៀបនឹង ANPR ${Extension.getTitleBySegmentIndex(
                                  selectedSegmentType: selectedSegmentType,
                                  date: date,
                                )}",
                                downloadFileName: "revenue-etc-anpr",
                                widgetFunction: (duration, axisFontSize) {
                                  return ExtensionComponent.graphComponent
                                      .getChart<PPSHVDeductionDataModel>(
                                    axisFontSize: Singleton
                                        .instance.graphAxisFontSizeScreen,
                                    chartType: CHART_TYPE_ENUM.BAR_CHART,
                                    title: "",
                                    jsonData: snapshot.data!.data!,
                                    primaryAxisX: 'date',
                                    primaryAxisXFormat:
                                        getTypeBySegmentIndex() == "monthly"
                                            ? AXIS_DATA_TYPE.DATETIME_yMMMM
                                            : getTypeBySegmentIndex() ==
                                                    "yearly"
                                                ? AXIS_DATA_TYPE.DATETIME_y
                                                : AXIS_DATA_TYPE
                                                    .DATETIME_MMMMEEEEd,
                                    intervalType: getTypeBySegmentIndex() ==
                                            "monthly"
                                        ? INTERVAL_TYPE_ENUM.MONTH
                                        : getTypeBySegmentIndex() == "yearly"
                                            ? INTERVAL_TYPE_ENUM.YEAR
                                            : INTERVAL_TYPE_ENUM.AUTO,
                                    primaryAxisY: [
                                      AxisKeyDataModel(
                                        label: "%ETC",
                                        data: "transaction-obu-total-percent",
                                        colorRgb: StyleColor.etcColor,
                                      ),
                                      AxisKeyDataModel(
                                        label: "%ANPR",
                                        data: "transaction-anpr-total-percent",
                                        colorRgb: StyleColor.anprColor,
                                      ),
                                    ],
                                    primaryAxisXInterval: getIntervalByLength(
                                        snapshot.data!.data!.length),
                                    primaryAxisYDataType:
                                        VALUE_DATA_TYPE.PERCENT,
                                    primaryAxisYTitle: "",
                                    primaryDeserialize: (e) => e.toJson(),
                                  );
                                },
                              ),
                              //PPSHV Deduction Lanes Percentage Bar
                              GraphCard(
                                bigTitle:
                                    "ផ្លូវល្បឿនលឿន ភ្នំពេញ-ក្រុងព្រះសីហនុ",
                                title:
                                    "ភាគរយចំនួនចរាចរណ៍ (ប្រភេទច្រក) ${Extension.getTitleBySegmentIndex(
                                  // "ETC ធៀបនឹង ANPR ធៀបនឹង MTC ${Extension.getTitleBySegmentIndex(
                                  selectedSegmentType: selectedSegmentType,
                                  date: date,
                                )}",
                                downloadFileName: "revenue-etc-anpr-mtc",
                                widgetFunction: (duration, axisFontSize) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: ExtensionComponent.graphComponent
                                        .getChart<PPSHVDeductionDataModel>(
                                      axisFontSize: Singleton
                                          .instance.graphAxisFontSizeScreen,
                                      chartType: CHART_TYPE_ENUM.STACK_100_BAR,
                                      title: "",
                                      jsonData: snapshot.data!.data!,
                                      primaryAxisX: 'date',
                                      primaryAxisY: [
                                        AxisKeyDataModel(
                                          label: "%ANPR",
                                          data:
                                              "transaction-anpr-total-percent",
                                          colorRgb: StyleColor.anprColor,
                                        ),
                                        AxisKeyDataModel(
                                          label: "%ETC",
                                          data: "transaction-obu-total-percent",
                                          colorRgb: StyleColor.etcColor,
                                        ),
                                        AxisKeyDataModel(
                                          label: "%MTC",
                                          data:
                                              "transaction-iccard-total-percent",
                                          colorRgb: StyleColor.mtcColor,
                                        ),
                                      ],
                                      primaryAxisXInterval: getIntervalByLength(
                                          snapshot.data!.data!.length),
                                      primaryAxisXFormat:
                                          getTypeBySegmentIndex() == "monthly"
                                              ? AXIS_DATA_TYPE.DATETIME_yMMMM
                                              : getTypeBySegmentIndex() ==
                                                      "yearly"
                                                  ? AXIS_DATA_TYPE.DATETIME_y
                                                  : AXIS_DATA_TYPE
                                                      .DATETIME_MMMMEEEEd,
                                      intervalType: getTypeBySegmentIndex() ==
                                              "monthly"
                                          ? INTERVAL_TYPE_ENUM.MONTH
                                          : getTypeBySegmentIndex() == "yearly"
                                              ? INTERVAL_TYPE_ENUM.YEAR
                                              : INTERVAL_TYPE_ENUM.AUTO,
                                      primaryAxisYDataType:
                                          VALUE_DATA_TYPE.PERCENT,
                                      primaryAxisYTitle: "",
                                      primaryDeserialize: (e) => e.toJson(),
                                    ),
                                  );
                                },
                              ),
                              //PPSHV Deduction Lanes Percentage Pie
                              GraphCard(
                                bigTitle:
                                    "ផ្លូវល្បឿនលឿន ភ្នំពេញ-ក្រុងព្រះសីហនុ",
                                title:
                                    "ភាគរយចំនួនចរាចរណ៍ ${getDateCaption(snapshot.data!)}",
                                downloadFileName:
                                    "revenue-average-pie-by-gate-type",
                                widgetFunction: (duration, axisFontSize) {
                                  return ExtensionComponent.graphComponent
                                      .getPie<PPSHVDeductionDataModel>(
                                    title: "",
                                    jsonData: () {
                                      var list = snapshot.data!.data!
                                          .where((element) =>
                                              element.transactionTotal! > 0)
                                          .toList()
                                          .reversed
                                          .toList();
                                      if (list.length > 0)
                                        return list.first;
                                      else
                                        return PPSHVDeductionDataModel.empty();
                                    }(),
                                    primaryAxisY: [
                                      AxisKeyDataModel(
                                        label: "%ANPR",
                                        data: "transaction-anpr-total-percent",
                                        colorRgb: StyleColor.anprColor,
                                      ),
                                      AxisKeyDataModel(
                                        label: "%ETC",
                                        data: "transaction-obu-total-percent",
                                        colorRgb: StyleColor.etcColor,
                                      ),
                                      AxisKeyDataModel(
                                        label: "%MTC",
                                        data:
                                            "transaction-iccard-total-percent",
                                        colorRgb: StyleColor.mtcColor,
                                      ),
                                    ],
                                    primaryDeserialize: (e) => e.toJson(),
                                  );
                                },
                              ),
                            ],
                          );
                        else
                          return PopupDialog.noResult();
                      }
                      return AnimateLoading();
                    }(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
