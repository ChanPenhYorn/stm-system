import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';
import 'package:stm_report_app/Api/ApiEndPoint.dart';
import 'package:stm_report_app/Entity/Chart/AxisKeyDataModel.dart';
import 'package:stm_report_app/Entity/PPSHV/PPSHVTopupModel.dart';
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
import 'package:toggle_switch/toggle_switch.dart';

class PPSHVTopupReport extends StatefulWidget {
  const PPSHVTopupReport({Key? key}) : super(key: key);

  @override
  State<PPSHVTopupReport> createState() => _PPSHVTopupReportState();
}

class _PPSHVTopupReportState extends State<PPSHVTopupReport> {
  DateTime dateNow = DateTime.now();
  DateTime date = DateTime.now();

  @override
  void initState() {
    InitData = initData();
    super.initState();
  }

  bool isLastPeriod = false;
  int lastPeriod = 0;
  Future<PPSHVTopupModel> initData() async {
    var res = await Singleton.instance.apiExtension
        .get<PPSHVTopupModel, PPSHVTopupModel>(
      context: context,
      loading: false,
      param:
          "type=${getTypeBySegmentIndex()}&date=${date.toYYYYMMDD()}&last_period=${lastPeriod}",
      baseUrl: ApiEndPoint.ppshvTopup,
      deserialize: (e) => PPSHVTopupModel.fromJson(e),
    );
    if (res.success!)
      return res.data!;
    else
      return Future.error(true);
  }

  Future<PPSHVTopupModel>? InitData;

  double getIntervalByLength(int length) {
    // if (getTypeBySegmentIndex() == "daily")
    return 1;
    // else
    //   return length > 15 || length == 1 ? -1 : 1;
  }

  int selectedSegmentType = 0;
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
                    DateFormat('MMMM', "km").format(date) + " ${date.year}",
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

  String getDateCaption(PPSHVTopupModel snapshot) {
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

  // Widget getSelectSegmentDetail() {
  //   if (selectedSegmentType == 0 || selectedSegmentType == 1) {
  //     return Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(
  //           'របាយការណ៍ខែ៖ ',
  //           style: StyleColor.textStyleKhmerContentAuto(),
  //         ),
  //         TextButton(
  //           onPressed: () async {
  //             var res = await showMonthPicker(
  //               context: context,
  //               initialDate: date,
  //               firstDate: DateTime.now().subtract(Duration(days: 365)),
  //               lastDate: DateTime.now(),
  //               locale: Locale("km"),
  //             );
  //             if (res != null) {
  //               date = res;
  //               InitData = initData();
  //               setState(() {});
  //             }
  //           },
  //           style: TextButton.styleFrom(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10)),
  //             padding: EdgeInsets.only(left: 10, right: 10, bottom: 7, top: 7),
  //             backgroundColor: StyleColor.appBarColor,
  //           ),
  //           child: Text(
  //             DateFormat('MMMM').format(date).getKhmerMonth() + " ${date.year}",
  //             style: StyleColor.textStyleKhmerContentAuto(
  //               color: Colors.white,
  //             ),
  //           ),
  //         )
  //       ],
  //     );
  //   } else if (selectedSegmentType == 2 || selectedSegmentType == 3) {
  //     return Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(
  //           'របាយការណ៍ឆ្នាំ៖ ',
  //           style: StyleColor.textStyleKhmerContentAuto(),
  //         ),
  //         TextButton(
  //           onPressed: () async {
  //             selectYear(context);
  //           },
  //           style: TextButton.styleFrom(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10)),
  //             padding: EdgeInsets.only(left: 10, right: 10, bottom: 7, top: 7),
  //             backgroundColor: StyleColor.appBarColor,
  //           ),
  //           child: Text(
  //             DateFormat('yyyy').format(date),
  //             style: StyleColor.textStyleKhmerContentAuto(
  //               color: Colors.white,
  //             ),
  //           ),
  //         )
  //       ],
  //     );
  //   }
  //   return Container();
  // }

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
      if (selectedSegmentType == 0) {
        return 10000;
        return (total / 60).roundToDouble();
      } else
        return -1;
    } else
      return -1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleColor.appBarColor,
        title: Text(
          'បញ្ចូលទឹកប្រាក់',
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
            Expanded(
              child: FutureBuilder<PPSHVTopupModel>(
                future: InitData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData)
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListView(
                          physics: ClampingScrollPhysics(),
                          children: [
                            GraphCard(
                              bigTitle: "ផ្លូវល្បឿនលឿន ភ្នំពេញ-ក្រុងព្រះសីហនុ",
                              title:
                                  "ការបញ្ចូលទឹកប្រាក់ធៀបនឹងចរាចរណ៍ ${Extension.getTitleBySegmentIndex(
                                selectedSegmentType: selectedSegmentType,
                                date: date,
                              )}",
                              obj: snapshot.data!,
                              tableDateType: getDateTypeBySegment(),
                              tableTypeEnum: TABLE_TYPE_ENUM.PPSHVTopupMixedTrx,
                              widgetFunction: (duration, axisFontSize) {
                                return ExtensionComponent.graphComponent
                                    .getChart<PPSHVTopupDataModel>(
                                  axisFontSize: axisFontSize,
                                  chartType: CHART_TYPE_ENUM.LINE_CHART,
                                  title: "",
                                  jsonData: snapshot.data!.data!,
                                  primaryAxisX: 'date',
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
                                  ],
                                  primaryAxisXInterval: getIntervalByLength(
                                      snapshot.data!.data!.length),
                                  secondaryAxisYDataType:
                                      VALUE_DATA_TYPE.TRANSACTION,
                                  primaryAxisYDataType: VALUE_DATA_TYPE.NUMERIC,
                                  primaryAxisYInterval: getPrimaryAxisYInterval(
                                      snapshot.data!.total!.amountTotal == null
                                          ? 0
                                          : snapshot.data!.total!.amountTotal!),
                                  primaryAxisXFormat: getTypeBySegmentIndex() ==
                                          "monthly"
                                      ? AXIS_DATA_TYPE.DATETIME_yMMMM
                                      : getTypeBySegmentIndex() == "yearly"
                                          ? AXIS_DATA_TYPE.DATETIME_y
                                          : AXIS_DATA_TYPE.DATETIME_MMMMEEEEd,
                                  intervalType:
                                      getTypeBySegmentIndex() == "monthly"
                                          ? INTERVAL_TYPE_ENUM.MONTH
                                          : getTypeBySegmentIndex() == "yearly"
                                              ? INTERVAL_TYPE_ENUM.YEAR
                                              : INTERVAL_TYPE_ENUM.AUTO,
                                  primaryAxisYTitle: "",
                                  primaryDeserialize: (e) => e.toJson(),
                                  secondaryAxisY: [
                                    AxisKeyDataModel(
                                      label: "Transaction",
                                      data: "transaction-total",
                                      colorRgb: StyleColor.tranGreenColor,
                                    ),
                                  ],
                                  secondaryAxisYTitle: "",
                                );
                              },
                            ),
                            GraphCard(
                              bigTitle: "ផ្លូវល្បឿនលឿន ភ្នំពេញ-ក្រុងព្រះសីហនុ",
                              title:
                                  "ETC ធៀបនឹង ANPR ${Extension.getTitleBySegmentIndex(
                                selectedSegmentType: selectedSegmentType,
                                date: date,
                              )}",
                              widgetFunction: (duration, axisFontSize) {
                                return ExtensionComponent.graphComponent
                                    .getChart<PPSHVTopupDataModel>(
                                  chartType: CHART_TYPE_ENUM.BAR_CHART,
                                  title: "",
                                  jsonData: snapshot.data!.data!,
                                  primaryAxisX: 'date',
                                  primaryAxisY: [
                                    AxisKeyDataModel(
                                      label: "ANPR",
                                      data: "amount-anpr-dollar",
                                      colorRgb: StyleColor.anprColor,
                                    ),
                                    AxisKeyDataModel(
                                      label: "ETC",
                                      data: "amount-obu-dollar",
                                      colorRgb: StyleColor.etcColor,
                                    ),
                                  ],
                                  primaryAxisXInterval: getIntervalByLength(
                                      snapshot.data!.data!.length),
                                  primaryAxisXFormat: getTypeBySegmentIndex() ==
                                          "monthly"
                                      ? AXIS_DATA_TYPE.DATETIME_yMMMM
                                      : getTypeBySegmentIndex() == "yearly"
                                          ? AXIS_DATA_TYPE.DATETIME_y
                                          : AXIS_DATA_TYPE.DATETIME_MMMMEEEEd,
                                  intervalType:
                                      getTypeBySegmentIndex() == "monthly"
                                          ? INTERVAL_TYPE_ENUM.MONTH
                                          : getTypeBySegmentIndex() == "yearly"
                                              ? INTERVAL_TYPE_ENUM.YEAR
                                              : INTERVAL_TYPE_ENUM.AUTO,
                                  primaryAxisYDataType: VALUE_DATA_TYPE.NUMERIC,
                                  primaryAxisYTitle: "",
                                  primaryDeserialize: (e) => e.toJson(),
                                );
                              },
                            ),
                            GraphCard(
                              bigTitle: "ផ្លូវល្បឿនលឿន ភ្នំពេញ-ក្រុងព្រះសីហនុ",
                              title:
                                  "មធ្យមភាគការបញ្ចូលទឹកប្រាក់ ${getDateCaption(snapshot.data!)}",
                              widgetFunction: (duration, axisFontSize) {
                                return ExtensionComponent.graphComponent
                                    .getPie<PPSHVTopupDataModel>(
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
                                      return PPSHVTopupDataModel.empty();
                                  }(),
                                  primaryAxisY: [
                                    AxisKeyDataModel(
                                      label: "%ANPR",
                                      data: "amount-anpr-total-percent",
                                      colorRgb: StyleColor.anprColor,
                                    ),
                                    AxisKeyDataModel(
                                      label: "%ETC",
                                      data: "amount-obu-total-percent",
                                      colorRgb: StyleColor.etcColor,
                                    ),
                                  ],
                                  primaryDeserialize: (e) => e.toJson(),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    else
                      return PopupDialog.noResult();
                  }
                  return AnimateLoading();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
