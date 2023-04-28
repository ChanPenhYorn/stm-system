import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/Chart/AxisKeyDataModel.dart';
import 'package:stm_report_app/Entity/Report/STMReportModel.dart';
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

class STMReport extends StatefulWidget {
  const STMReport({Key? key}) : super(key: key);

  @override
  State<STMReport> createState() => _STMReportState();
}

class _STMReportState extends State<STMReport> {
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
  Future<STMReportModel> initData() async {
    var res = await Singleton.instance.apiExtension
        .get<STMReportModel, STMReportModel>(
      context: context,
      loading: false,
      param:
          "type=${getTypeBySegmentIndex()}&date=${date.toYYYYMMDD()}&last_period=${lastPeriod}",
      baseUrl: ApiEndPoint.vehicleRevenue,
      deserialize: (e) => STMReportModel.fromJson(e),
    );
    if (res.success!)
      return res.data!;
    else
      return Future.error(true);
    // return STMReportModel.fromJson(Extension.jsonSTMReport);
  }

  Future<STMReportModel>? InitData;

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
      return "monthly";
    else if (selectedSegmentType == 2)
      return "yearly";
    else
      return "yearly";
  }

  String getDateCaption(STMReportModel snapshot) {
    try {
      if (snapshot.data!.length > 0) {
        var list = snapshot.data!
            .where((element) => element.incomeDollar! > 0)
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
    if (selectedSegmentType == 0) {
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
                  child: Container(
                    height: 30,
                    alignment: Alignment.center,
                    child: Text(
                      DateFormat('MMMM', "km").format(date) + " ${date.year}",
                      style: StyleColor.textStyleKhmerContentAuto(
                        color: Colors.white,
                      ),
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
    } else if (selectedSegmentType == 1 || selectedSegmentType == 2) {
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
                  child: Container(
                    height: 30,
                    alignment: Alignment.center,
                    child: Text(
                      DateFormat('yyyy').format(date),
                      style: StyleColor.textStyleKhmerContentAuto(
                        color: Colors.white,
                      ),
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
    } else if (selectedSegmentType == 1) {
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
    else if (selectedSegmentType == 1)
      return TABLE_DATE_TYPE_ENUM.MONTHLY;
    else if (selectedSegmentType == 2) return TABLE_DATE_TYPE_ENUM.YEARLY;
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
    } else
      return -1;
  }

  Widget getTable(STMReportModel data) {
    if (data.data!.where((element) => element.vehicleTrx! > 0).length > 0)
      return Singleton.instance.tableComponent.getSTMReportRevenueTruck(
        context: context,
        stmReportTableType: TABLE_TYPE_ENUM.STMRevenueTruck,
        model: data,
        shrinkWrapColumn: false,
        tableDateType: getDateTypeBySegment(),
      );
    else
      return Container();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            ToggleSwitch(
              labels: ['ប្រចាំថ្ងៃ', 'ប្រចាំខែ', 'ប្រចាំឆ្នាំ'],
              activeFgColor: Colors.white,
              initialLabelIndex: selectedSegmentType,
              minWidth: 90,
              dividerMargin: 0,
              totalSwitches: 3,
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
              child: FutureBuilder<STMReportModel>(
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
                              //Graph
                              GraphCard(
                                bigTitle: "STM Monitoring Report",
                                widgetFunction: (duration, axisFontSize) {
                                  return ExtensionComponent.graphComponent
                                      .getChart<STMReportDataModel>(
                                    axisFontSize: Singleton
                                        .instance.graphAxisFontSizeScreen,
                                    chartType:
                                        CHART_TYPE_ENUM.STACK_BAR_AND_LINE,
                                    title: "",
                                    jsonData: snapshot.data!.data!,
                                    primaryAxisX: 'date',
                                    primaryAxisY: [
                                      AxisKeyDataModel(
                                        label: "ទំងន់",
                                        data: "weight-kg",
                                        colorRgb: StyleColor.mtcColor,
                                        trendLineColorRgb:
                                            StyleColor.etcTrendLineColor,
                                        chartType: CHART_TYPE_ENUM.STACK_BAR,
                                      ),
                                      AxisKeyDataModel(
                                        label: "ចំនួនឡាន",
                                        data: "vehicle-trx",
                                        colorRgb: Colors.blueAccent,
                                        trendLineColorRgb: StyleColor.mtcColor,
                                        chartType: CHART_TYPE_ENUM.STACK_BAR,
                                      ),
                                    ],
                                    primaryAxisYDataType:
                                        VALUE_DATA_TYPE.DOLLAR,
                                    primaryAxisYTitle: "",
                                    animationDuration: duration,
                                    primaryAxisYGridLine: 0.3,
                                    secondaryAxisYGridLine: 0,
                                    sideBySideSeries: false,
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
                                        label: "ចំណូល",
                                        data: "income-dollar",
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
                                    "តារាងទិន្នន័យដឹកជញ្ជូន និងចំណូល${Extension.getTitleBySegmentIndex(
                                  selectedSegmentType: selectedSegmentType,
                                  date: date,
                                )}",
                                downloadFileName: "revenue-truck",
                                obj: snapshot.data!,
                                tableDateType: getDateTypeBySegment(),
                                tableTypeEnum: TABLE_TYPE_ENUM.STMRevenueTruck,
                              ),
                              //Table
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: getTable(snapshot.data!)),
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
